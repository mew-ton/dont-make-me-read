#!/usr/bin/env bash
#
# Every consistency in this tree that can be checked without a model, checked.
# No model call, no network. What needs a model, the cases in samples/, is run
# by hand as README.md says; any other consistency this script does not check
# is not promised anywhere.
#
# Usage:  bash scripts/check.sh
# Exit:   0 when every check passes, 1 otherwise. Each failure is one line on stderr.

set -euo pipefail

root=$(cd "$(dirname "$0")/.." && pwd)
skill_dir="$root/skills/dont-make-me-read"
skill="$skill_dir/SKILL.md"
readme="$root/README.md"
manifest="$root/.claude-plugin/plugin.json"

# The size limits. This is the one place they are stated; a document that
# wants to say what they are links here.
limit_skill=4096
limit_reference=8192

status=0
problem() { echo "check: $*" >&2; status=1; }

# frontmatter_field FIELD: the value of a frontmatter field. A block scalar
# (`field: >` or `field: |`, with or without a chomping indicator) is joined
# into one line with single spaces.
frontmatter_field() {
  awk -v field="$1" '
    /^---[ \t]*$/ { fence++; next }
    fence != 1 { next }
    on && /^[^ \t]/ { on = 0 }
    on { sub(/^[ \t]+/, ""); out = out (out == "" ? "" : " ") $0; next }
    $0 ~ "^" field ":" {
      v = $0; sub("^" field ":[ \t]*", "", v)
      if (v ~ /^[>|][-+]?$/) { on = 1 } else { out = v }
    }
    END { print out }
  ' "$skill"
}

# --- the skill's frontmatter ------------------------------------------------

name=$(frontmatter_field name)
[ "$name" = "$(basename "$skill_dir")" ] \
  || problem "SKILL.md name '$name' is not its directory '$(basename "$skill_dir")'"

description=$(frontmatter_field description)
[ -n "$description" ] || problem "SKILL.md has no description"
case "$description" in *'<'*|*'>'*) problem "SKILL.md description contains < or >, so it will not load" ;; esac
[ "${#description}" -le 1024 ] || problem "SKILL.md description is ${#description} characters, over 1024"

# --- sizes --------------------------------------------------------------------

check_size() {
  local file=$1 limit=$2 bytes
  bytes=$(wc -c < "$file")
  [ "$bytes" -le "$limit" ] || problem "${file#"$root"/} is $bytes bytes, over $limit"
}
check_size "$skill" "$limit_skill"
for f in "$skill_dir"/references/*.md; do check_size "$f" "$limit_reference"; done

# --- references: reached from SKILL.md, and from nowhere else ----------------

for f in "$skill_dir"/references/*.md; do
  rel="references/$(basename "$f")"
  grep -q "]($rel)" "$skill" || problem "$rel is not linked from SKILL.md"
  if grep -qE '\]\((\./)?[^/)#]+\.md(#[^)]*)?\)|\]\(\.\./references/' "$f"; then
    problem "$rel links to another reference"
  fi
done

# --- every relative link resolves, heading included ---------------------------

# slugs FILE: the anchor GitHub gives each heading in FILE, one per line.
slugs() {
  sed -n 's/^#\{1,6\} \(.*\)$/\1/p' "$1" \
    | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9 _-]//g; s/ /-/g'
}

while IFS= read -r file; do
  dir=$(dirname "$file")
  while IFS= read -r target; do
    case "$target" in ''|http://*|https://*|mailto:*|'#'*) continue ;; esac
    path=${target%%#*}
    if [ ! -e "$dir/$path" ]; then
      problem "${file#"$root"/} links to $target, which does not exist"
    elif [ "$path" != "$target" ] && ! slugs "$dir/$path" | grep -qxF "${target#*#}"; then
      problem "${file#"$root"/} links to $target, whose file has no such heading"
    fi
  done < <(grep -o '\]([^)]*)' "$file" | sed 's/^](//; s/)$//' || true)
done < <(find "$root" -name '*.md' -not -path '*/.git/*')

# --- samples cite rules, sections and cases that exist -----------------------

rule_count=$(grep -cE '^[0-9]+\. \*\*' "$skill")
for f in "$root"/samples/*.md; do
  text=$(tr '\n' ' ' < "$f")
  while IFS= read -r n; do
    [ "$n" -ge 1 ] && [ "$n" -le "$rule_count" ] \
      || problem "${f#"$root"/} cites rule $n; SKILL.md has $rule_count"
  done < <(grep -oiE '\brule +[0-9]+' <<< "$text" | grep -oE '[0-9]+' || true)
  while IFS=$'\t' read -r heading ref; do
    grep -qxF "## $heading" "$skill_dir/$ref" \
      || problem "${f#"$root"/} cites *$heading* in $ref, which has no such heading"
  done < <(grep -oE '\*[^*]+\* +(section|table) +(of|in) +`references/[a-z-]+\.md`' <<< "$text" \
             | sed -E 's/^\*([^*]+)\* +[a-z]+ +[a-z]+ +`([^`]+)`$/\1\t\2/' || true)
  while IFS= read -r n; do
    compgen -G "$root/samples/$n-*.md" > /dev/null \
      || problem "${f#"$root"/} cites case $n, which does not exist"
  done < <(grep -oiE '\bcases? +[0-9]{2}( +(and|to) +[0-9]{2})?' <<< "$text" | grep -oE '[0-9]{2}' || true)
done

# --- README quotes the description verbatim ----------------------------------

squeeze() { tr -d ' \t\n>'; }
squeeze_lines() { tr -d ' \t>'; }
if ! squeeze < "$readme" | grep -qF "$(printf '%s' "$description" | squeeze)"; then
  problem "README.md does not quote the SKILL.md description verbatim"
fi

# --- README quotes SKILL.md, and only SKILL.md -------------------------------

skill_squeezed=$(squeeze < "$skill")
while IFS= read -r quote; do
  [[ "$skill_squeezed" == *"$quote"* ]] \
    || problem "README.md quotes text that is not in SKILL.md: ${quote:0:60}…"
done < <(awk '
  /^> / { sub(/^> /, ""); q = q $0; next }
  q != "" { print q; q = "" }
  END { if (q != "") print q }
' "$readme" | squeeze_lines)

while IFS= read -r rule; do
  grep -qF "$rule" "$skill" || problem "README.md lists a rule SKILL.md does not have: $rule"
done < <(grep -E '^[0-9]+\. \*\*.*\*\*$' "$readme" || true)

# --- the manifest carries the description's first sentence -------------------

first_sentence="${description%%. *}."
manifest_description=$(sed -n 's/^[ \t]*"description":[ \t]*"\(.*\)",\{0,1\}[ \t]*$/\1/p' "$manifest")
[ "$manifest_description" = "$first_sentence" ] \
  || problem "plugin.json description is not the first sentence of the SKILL.md description"

exit "$status"
