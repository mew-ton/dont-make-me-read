#!/usr/bin/env bash
#
# Every consistency this tree promises, checked. No model call, no network.
# A consistency this script does not check is not promised anywhere.
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

# frontmatter_field FIELD: the value of a frontmatter field. A folded scalar
# (`field: >`) is joined into one line with single spaces.
frontmatter_field() {
  awk -v field="$1" '
    /^---[ \t]*$/ { fence++; next }
    fence != 1 { next }
    on && /^[^ \t]/ { on = 0 }
    on { sub(/^[ \t]+/, ""); out = out (out == "" ? "" : " ") $0; next }
    $0 ~ "^" field ":" {
      v = $0; sub("^" field ":[ \t]*", "", v)
      if (v == ">" || v == "|") { on = 1 } else { out = v }
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
  if grep -q '](references/' "$f"; then problem "$rel links to another reference"; fi
done

# --- every relative link resolves --------------------------------------------

while IFS= read -r file; do
  dir=$(dirname "$file")
  while IFS= read -r target; do
    case "$target" in ''|http://*|https://*|mailto:*|'#'*) continue ;; esac
    path=${target%%#*}
    [ -e "$dir/$path" ] || problem "${file#"$root"/} links to $target, which does not exist"
  done < <(grep -o '\]([^)]*)' "$file" | sed 's/^](//; s/)$//' || true)
done < <(find "$root" -name '*.md' -not -path '*/.git/*')

# --- README quotes the description verbatim ----------------------------------

squeeze() { tr -d ' \t\n>'; }
if ! squeeze < "$readme" | grep -qF "$(printf '%s' "$description" | squeeze)"; then
  problem "README.md does not quote the SKILL.md description verbatim"
fi

# --- the manifest carries the description's first sentence -------------------

first_sentence="${description%%. *}."
manifest_description=$(sed -n 's/^[ \t]*"description":[ \t]*"\(.*\)",\{0,1\}[ \t]*$/\1/p' "$manifest")
[ "$manifest_description" = "$first_sentence" ] \
  || problem "plugin.json description is not the first sentence of the SKILL.md description"

exit "$status"
