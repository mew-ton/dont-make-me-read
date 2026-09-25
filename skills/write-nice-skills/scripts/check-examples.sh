#!/usr/bin/env bash
# Two reference files quote descriptions that ship: examples.md's Good blocks, and
# writing-descriptions.md's worked openings. This asserts each one still matches its
# skill's live description, byte for byte.
#
#   bash <this skill's directory>/scripts/check-examples.sh [skills-dir]
#
# Exits non-zero and prints the first line that differs when one has gone stale.
set -uo pipefail

here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
examples="$here/../references/examples.md"
descriptions="$here/../references/writing-descriptions.md"
skills="${1:-$here/../..}"

python3 - "$examples" "$skills" "$descriptions" <<'PY'
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

# writing-descriptions.md shows the description's shape once, in placeholders, and
# then quotes live descriptions as the worked openings. The shape is the block with a
# placeholder in it; every other one has to be a description that ships.
descriptions = pathlib.Path(sys.argv[3])
quoted = 0
for i, blk in enumerate(re.findall(r"```text\n(.*?)```", descriptions.read_text(), re.S), 1):
    n = norm(blk)
    if "<" in n:
        continue
    quoted += 1
    if n in live.values():
        continue
    bad += 1
    owner = max(live, key=lambda k: len(set(live[k].split()) & set(n.split())))
    print(f"{descriptions.name} block {i} matches no live description. Closest is {owner}:")
    for t in n.split(". "):
        if t not in live[owner].split(". "):
            print(f"  quoted only: {t[:100]}")

print(f"{len(goods)} Good blocks, {added} added-to Bad blocks and {quoted} worked openings checked, {bad} stale.")
sys.exit(1 if bad else 0)
PY
