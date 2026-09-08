#!/usr/bin/env bash
#
# Measure what a file really costs the model that will load it.
#
# Line counts and character counts are both poor proxies for a skill's context
# cost, so this measures the tokenizer directly: send the file through the local
# `claude` CLI and diff the input-side token count against a baseline run. No API
# key is involved — it reuses the CLI's own authentication.
#
# Each measured file costs one real model round trip, so point it at the files you
# are about to commit rather than at the whole tree.
#
# Usage:
#   bash count-tokens.sh <file>...
#   TARGET=3000 bash count-tokens.sh SKILL.md     # tighter budget than the default
#
# Exit codes:
#   0  every file measured and within TARGET
#   1  a file exceeded TARGET, or a named file did not exist
#   2  bad usage, or a required command is missing
#   3  a measurement failed or came back unusable (no count is reported as a pass)

set -euo pipefail

TARGET=${TARGET:-5000}

command -v claude >/dev/null || { echo "count-tokens: need the claude CLI on PATH" >&2; exit 2; }
command -v jq >/dev/null || { echo "count-tokens: need jq on PATH" >&2; exit 2; }
[ "$#" -gt 0 ] || { echo "usage: bash $0 <file>..." >&2; exit 2; }

row() { printf '%-46s %8s %6s %8s %7s  %s\n' "$1" "$2" "$3" "$4" "${5:-}" "${6:-}"; }

# Ratios are carried as hundredths so the script needs no bc.
fmt_ratio() { printf '%d.%02d' "$(( $1 / 100 ))" "$(( $1 % 100 ))"; }

# The payload is a file full of instructions, so every tool is denied: without
# that the model could act on what it reads, and any tool turn would add cache
# reads that corrupt the very number being measured. The delimiters alone are
# presentation, not a control.
ask() {
  claude -p "$(printf 'Reply with exactly: ok\n\n===BEGIN===\n%s\n===END===\n' "$1")" \
    --output-format json --allowedTools ''
}

# A large user message lands in cache_creation rather than input_tokens, so all
# three input-side buckets are summed. `usage.*` covers the main model only;
# auxiliary calls to a smaller model appear in modelUsage but not here.
#
# Every failure path here must be loud. A missing `usage` object silently
# defaulting to 0 would produce a negative token count that compares as "under
# budget" — a false pass on exactly the check this script exists to make.
input_total() {
  local json total
  json=$1
  if [ "$(jq -r '.is_error // false' <<<"$json")" != "false" ]; then
    echo "count-tokens: claude reported an error: $(jq -r '.result // "unknown"' <<<"$json")" >&2
    return 1
  fi
  if [ "$(jq -r '.usage | type' <<<"$json")" != "object" ]; then
    echo "count-tokens: response carried no usage object" >&2
    return 1
  fi
  total=$(jq -r '(.usage.input_tokens // 0)
               + (.usage.cache_creation_input_tokens // 0)
               + (.usage.cache_read_input_tokens // 0)' <<<"$json")
  case "$total" in ''|*[!0-9]*)
    echo "count-tokens: could not read a token count from the response" >&2
    return 1 ;;
  esac
  [ "$total" -gt 0 ] || { echo "count-tokens: token count came back as zero" >&2; return 1; }
  printf '%s' "$total"
}

# The probe's fixed overhead drifts between sessions, so the baseline is measured
# in the same run as the files it is subtracted from.
baseline_json=$(ask "") || { echo "count-tokens: baseline measurement failed" >&2; exit 3; }
baseline=$(input_total "$baseline_json") || exit 3
model=$(jq -r '(.modelUsage // {}) | to_entries
        | if length == 0 then "unknown"
          else (max_by(.value.cacheReadInputTokens + .value.cacheCreationInputTokens) | .key)
          end' <<<"$baseline_json") || {
  echo "count-tokens: could not determine the model name from modelUsage — continuing without it" >&2
  model="unknown"
}

printf 'model: %s    budget: %s tokens\n\n' "$model" "$TARGET"
row FILE BYTES LINES TOKENS B/TOK ''

status=0
tightest=''
for f in "$@"; do
  if [ ! -f "$f" ]; then
    row "$f" - - - - 'no such file'
    [ "$status" -eq 3 ] || status=1
    continue
  fi

  bytes=$(( $(wc -c < "$f") ))
  lines=$(( $(wc -l < "$f") ))

  if ! json=$(ask "$(cat "$f")") || ! measured=$(input_total "$json"); then
    row "$f" "$bytes" "$lines" - - 'measurement failed'
    status=3
    continue
  fi

  tokens=$(( measured - baseline ))
  if [ "$tokens" -lt 1 ]; then
    row "$f" "$bytes" "$lines" "$tokens" - 'implausible — rerun'
    status=3
    continue
  fi

  ratio=$(( bytes * 100 / tokens ))
  [ -n "$tightest" ] && [ "$tightest" -le "$ratio" ] || tightest=$ratio

  note=''
  if [ "$tokens" -gt "$TARGET" ]; then
    note="OVER by $(( tokens - TARGET ))"
    [ "$status" -eq 3 ] || status=1
  fi
  row "$f" "$bytes" "$lines" "$tokens" "$(fmt_ratio "$ratio")" "$note"
done

# The bytes-per-token ratio moves with the model, so any byte-level rule of thumb
# has to be re-derived rather than remembered. Print the one this run implies.
if [ -n "$tightest" ]; then
  printf '\nTightest ratio in this run: %s bytes/token on %s.\n' "$(fmt_ratio "$tightest")" "$model"
  printf 'At that ratio %s tokens is about %s bytes — use that as the free `wc -c`\n' \
    "$TARGET" "$(( TARGET * tightest / 100 ))"
  printf 'pre-check, and re-run this to re-derive it whenever the default model changes.\n'
fi

exit "$status"
