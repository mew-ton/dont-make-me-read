#!/usr/bin/env bash
#
# Checks the form of this tree: that every skill's description has no < or >
# and is at most 1024 characters; that every sub-skill is named
# dont-make-me-read--…; that neither what an agent loads nor the
# glossary names another sub-skill, SKILL.md, prose.md, program.md or a rule;
# the sizes of every SKILL.md, reference and agent against their snapshot; that
# each reference is linked from its own SKILL.md; links and the headings they
# name; that plugin.json carries the first sentence of the SKILL.md
# description; and that samples cite rules, sections, skills and cases that
# exist. No model call, no network.
# Whether what the tree says holds together is a review's job, as
# ARCHITECTURE.md › Reviewing says, not this script's.
#
# Usage:  bash scripts/check.sh            check
#         bash scripts/check.sh --update   rewrite the size snapshot, then check
# Exit:   0 when every check passes, 1 otherwise. Each failure is one line on stderr.

set -euo pipefail

root=$(cd "$(dirname "$0")/.." && pwd)
skill_dir="$root/skills/dont-make-me-read"
skill="$skill_dir/SKILL.md"
# A sub-skill is a step of an analysis, or the words the steps share.
sub_prefix="$(basename "$skill_dir")--"
glossary_name="${sub_prefix}glossary"
manifest="$root/.claude-plugin/plugin.json"

# The sizes of every SKILL.md, every reference and every agent, which are read
# into a model's context. A size is not capped: a change to it is recorded here by
# --update, so the diff of a change shows how much each read grew or shrank.
snapshot="$root/scripts/sizes.snapshot"
update=0
[ "${1:-}" = "--update" ] && update=1

status=0
problem() { echo "check: $*" >&2; status=1; }

# frontmatter_field FIELD [FILE]: the value of a frontmatter field of FILE,
# SKILL.md by default. A block scalar (`field: >` or `field: |`, with or
# without a chomping indicator) is joined into one line with single spaces.
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
  ' "${2:-$skill}"
}

# --- the skills' descriptions load ------------------------------------------

for f in "$root"/skills/*/SKILL.md; do
  rel=${f#"$root"/}
  d=$(frontmatter_field description "$f")
  case "$d" in *'<'*|*'>'*) problem "$rel description contains < or >, so it will not load" ;; esac
  [ "${#d}" -le 1024 ] || problem "$rel description is ${#d} characters, over 1024"
done

description=$(frontmatter_field description)

# rules: the lines of SKILL.md › Rules, where the numbered rules are.
rules() { awk '/^## /{ on = ($0 == "## Rules") ; next } on' "$skill"; }

# skill_files NAME: the files of the skill NAME, its SKILL.md and its references.
skill_files() {
  for f in "$root/skills/$1/SKILL.md" "$root/skills/$1"/references/*.md; do
    [ -e "$f" ] && echo "$f"
  done
}

# names_beyond FILE ALLOWED...: the sub-skills FILE names other than ALLOWED, and
# any SKILL.md, prose.md, program.md or rule it names, one per line.
names_beyond() {
  local file=$1; shift
  { grep -oE "${sub_prefix}[a-z-]*[a-z]" "$file" | grep -vxF -f <(printf '%s\n' "$@") || true
    grep -oE '\bSKILL\.md|\b(prose|program)\.md|\b[Rr]ule +[0-9]+' "$file" || true; } | sort -u
}

# --- every sub-skill is named by the prefix ----------------------------------

# names_beyond finds a sub-skill only by sub_prefix, so a sub-skill named
# without it goes unseen there.
for f in "$root"/skills/*/SKILL.md; do
  [ "$f" = "$skill" ] && continue
  dir=$(basename "$(dirname "$f")")
  case "$dir" in "$sub_prefix"*) ;; *) problem "${f#"$root"/} is not named $sub_prefix…" ;; esac
done

# --- what an agent loads names nothing it does not load ----------------------

# An agent loads its own sub-skill and the glossary. What it loads names no
# sub-skill it does not load, SKILL.md, prose.md, program.md or a rule.
for f in "$root"/agents/*.md; do
  [ -e "$f" ] || continue
  rel=${f#"$root"/}
  base=$(basename "$f" .md)
  for s in "$base" "$glossary_name"; do
    while IFS= read -r g; do
      while IFS= read -r name; do
        problem "${g#"$root"/}, loaded by $rel, names $name"
      done < <(names_beyond "$g" "$base" "$glossary_name")
    done < <(skill_files "$s")
  done
done

# --- the glossary names no other skill ---------------------------------------

# Every skill depends on the glossary, so it depends on none of them.
while IFS= read -r g; do
  while IFS= read -r name; do
    problem "${g#"$root"/} names $name; the glossary names no other skill"
  done < <(names_beyond "$g" "$glossary_name")
done < <(skill_files "$glossary_name")

# --- sizes --------------------------------------------------------------------

sizes() {
  for f in "$root"/skills/*/SKILL.md "$root"/skills/*/references/*.md "$root"/agents/*.md; do
    [ -e "$f" ] || continue
    printf '%s %s\n' "$(wc -c < "$f" | tr -d ' ')" "${f#"$root"/}"
  done
}
[ "$update" = 1 ] && sizes > "$snapshot"
if [ ! -f "$snapshot" ]; then
  problem "scripts/sizes.snapshot is missing; run bash scripts/check.sh --update"
elif ! diff -q <(sizes) "$snapshot" > /dev/null; then
  while IFS= read -r line; do problem "size changed: $line; run bash scripts/check.sh --update"; done \
    < <(diff <(sizes) "$snapshot" | sed -n 's/^< //p')
  while IFS= read -r line; do problem "size snapshot has a stale entry: $line"; done \
    < <(diff <(sizes) "$snapshot" | sed -n 's/^> //p' | grep -vF -f <(sizes | cut -d' ' -f2) || true)
fi

# --- references: reached from their SKILL.md ---------------------------------

for f in "$root"/skills/*/references/*.md; do
  [ -e "$f" ] || continue
  rel="references/$(basename "$f")"
  owner="$(dirname "$(dirname "$f")")/SKILL.md"
  grep -q "]($rel)" "$owner" || problem "${f#"$root"/} is not linked from its SKILL.md"
done

# --- every relative link resolves, heading included ---------------------------

# slugs FILE: the anchor GitHub gives each heading in FILE, one per line. Lines
# inside fenced code blocks are not headings, and a repeated slug gets -1, -2.
slugs() {
  awk '
    /^```/ { fenced = !fenced; next }
    fenced || !/^#{1,6} / { next }
    {
      s = tolower($0); sub(/^#+ /, "", s)
      gsub(/[^a-z0-9 _-]/, "", s); gsub(/ /, "-", s)
      print (seen[s]++ ? s "-" (seen[s] - 1) : s)
    }
  ' "$1"
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

# --- samples cite rules, sections, skills and cases that exist ---------------

rule_count=$(rules | grep -cE '^[0-9]+\. \*\*')
for f in "$root"/samples/*.md; do
  text=$(tr '\n' ' ' < "$f")
  while IFS= read -r n; do
    [ "$n" -ge 1 ] && [ "$n" -le "$rule_count" ] \
      || problem "${f#"$root"/} cites rule $n; SKILL.md has $rule_count"
  done < <(grep -oiE '\brule +[0-9]+' <<< "$text" | grep -oE '[0-9]+' || true)
  while IFS=$'\t' read -r heading ref; do
    grep -qxF -e "## $heading" -e "### $heading" "$skill_dir/$ref" \
      || problem "${f#"$root"/} cites *$heading* in $ref, which has no such heading"
  done < <(grep -oE '\*[^*]+\* +(section|table) +(of|in) +`references/[a-z-]+\.md`' <<< "$text" \
             | sed -E 's/^\*([^*]+)\* +[a-z]+ +[a-z]+ +`([^`]+)`$/\1\t\2/' || true)
  while IFS=$'\t' read -r heading name; do
    if [ ! -f "$root/skills/$name/SKILL.md" ]; then
      problem "${f#"$root"/} cites the skill $name, which does not exist"
    elif ! grep -qxF -e "## $heading" -e "### $heading" "$root/skills/$name/SKILL.md"; then
      problem "${f#"$root"/} cites *$heading* in the skill $name, which has no such heading"
    fi
  done < <(grep -oE '\*[^*]+\* +(section|table) +(of|in) +the +skill +`[a-z-]+`' <<< "$text" \
             | sed -E 's/^\*([^*]+)\* +[a-z]+ +[a-z]+ +the +skill +`([^`]+)`$/\1\t\2/' || true)
  while IFS= read -r n; do
    compgen -G "$root/samples/$n-*.md" > /dev/null \
      || problem "${f#"$root"/} cites case $n, which does not exist"
  done < <(grep -oiE '\bcases? +[0-9]{2}( +(and|to) +[0-9]{2})?' <<< "$text" | grep -oE '[0-9]{2}' || true)
done

# --- the manifest carries the description's first sentence -------------------

first_sentence="${description%%. *}."
manifest_description=$(sed -n 's/^[ \t]*"description":[ \t]*"\(.*\)",\{0,1\}[ \t]*$/\1/p' "$manifest")
[ "$manifest_description" = "$first_sentence" ] \
  || problem "plugin.json description is not the first sentence of the SKILL.md description"

exit "$status"
