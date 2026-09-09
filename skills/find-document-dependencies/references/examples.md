# Worked examples

Two, one per direction case: a one-way arrow running the wrong way, and a both-ways pair.

## A one-way arrow, pointing at the doc instead of away from it

An architecture doc, describing where the code lives:

```markdown
## Layers

The parsing layer is `lexer` and `parser`. The analysis layer is `resolver` and `typeck`.
```

Every one of those four modules is now in a strong dependency with this file: rename one and the
file is wrong. So is the fifth, the day somebody writes it — it will simply be missing, and the
section will go on reading like a complete answer.

Nothing here links, so nothing checks it. The sentence stays grammatical, stays confident, and
gives no sign at all. The way it gets found is that a contributor believes it and puts something in
the wrong place — which is to say, after it has already cost what it was going to cost.

**Reported as** one edge:

```
the modules → the doc   strong   §Layers
  fires on: any module added, removed, or renamed
  span:     "The parsing layer is `lexer` and `parser`. …"
```

An arrow pointing into the doc, from the thing the doc exists to govern. Whether that is allowed
here is the caller's question; that it is there at all is this skill's answer.

The same section with nothing pinned:

```markdown
## Layers

A module is in the parsing layer if it turns text into a tree without resolving a name, and in the
analysis layer if it resolves names against a tree it did not build.
```

The arrow now runs the other way — the doc → any module — and nothing runs back. A new module
places itself, and one that fits neither definition is the thing that has to give.

## A both-ways pair, split across two systems

One rollout, planned on a page and worked from a tracker. The page:

```markdown
## Rollout

Three phases. Phase 2 begins once the migration ships.
```

The tracker item:

```markdown
Blocked until the migration ships — phase 2 of the rollout plan (link).
```

The link is weak, and it is the only part any tool can see. Everything that actually breaks is the
prose either side of it, and it breaks in both directions:

- Change the phase count on the page, or what starts phase 2, and the tracker item is wrong.
- Split phase 2 in the tracker, or change what blocks it there, and the page is wrong.

**Reported as** a pair, not two findings:

```
the page → the tracker item   strong   "Blocked until the migration ships — phase 2 …"
  fires on: the phase count or phase 2's trigger changing on the page
the tracker item → the page   strong   "Three phases. Phase 2 begins once the migration ships."
  fires on: the blocking condition or the phase's shape changing in the tracker
both ways: one plan in two places, neither system able to see the other
weak, same span: the link to the page — still resolving long after the two disagree
```

The pair is the finding. Reported as two one-way edges it reads as two small inconsistencies to
tidy; reported as a pair it is what it is — one plan with two owners, and a caller who now has to
decide which place holds it.
