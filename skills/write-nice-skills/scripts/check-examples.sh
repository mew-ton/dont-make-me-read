#!/usr/bin/env bash
# Every Good block in references/examples.md claims to be a description that ships.
# This asserts it: each one has to match some skill's live description, byte for byte.
#
#   bash <this skill's directory>/scripts/check-examples.sh [skills-dir]
#
# Exits non-zero and prints the first line that differs when one has gone stale.
set -uo pipefail

here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
examples="$here/../references/examples.md"
skills="${1:-$here/../..}"

python3 - "$examples" "$skills" <<'PY'
import re, sys, pathlib

examples, skills = pathlib.Path(sys.argv[1]), pathlib.Path(sys.argv[2])
text = examples.read_text()

def norm(s):
    return " ".join(s.split())

live = {}
for p in sorted(skills.glob("*/SKILL.md")):
    parts = p.read_text().split("---\n")
    if len(parts) < 3:
        continue
    m = re.search(r"^description: >\n((?:  .*\n)+)", parts[1], re.M)
    if m:
        live[p.parent.name] = norm(m.group(1))

# A Good block is the fenced block after a **Good** line.
goods = re.findall(r"\*\*Good\*\*\n\n```text\n(.*?)```", text, re.S)
if not goods:
    print("no Good blocks found in", examples)
    sys.exit(1)

bad = 0
for i, g in enumerate(goods, 1):
    g = norm(g)
    if g in live.values():
        continue
    bad += 1
    owner = max(live, key=lambda k: len(set(live[k].split()) & set(g.split())))
    print(f"Good block {i} matches no live description. Closest is {owner}:")
    a, b = live[owner].split(". "), g.split(". ")
    for s in a:
        if s not in b:
            print(f"  live only: {s[:100]}")
    for s in b:
        if s not in a:
            print(f"  examples only: {s[:100]}")

# Where a Bad is longer than its Good, the Bad is that Good with something added
# and nothing else changed. Assert it, so editing one copy and not the other fails.
pairs = re.findall(r"\*\*Bad\*\*\n\n```text\n(.*?)```.*?\*\*Good\*\*\n\n```text\n(.*?)```", text, re.S)
added = 0
for i, (b, g) in enumerate(pairs, 1):
    b, g = norm(b), norm(g)
    if len(b) <= len(g):
        continue
    added += 1
    if not b.startswith(g):
        print(f"pair {i}: the Bad is longer than its Good but no longer opens with it")
        print(f"  Good: {g[:100]}")
        print(f"  Bad:  {b[:100]}")
        bad += 1

print(f"{len(goods)} Good blocks and {added} added-to Bad blocks checked, {bad} stale.")
sys.exit(1 if bad else 0)
PY
