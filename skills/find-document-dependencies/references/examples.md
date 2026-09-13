# Worked examples

A one-way arrow running the wrong way, a both-ways pair, and an edge with both ends inside one
file.

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

## An edge with both ends in one file

A skill declares the tools it may use in its frontmatter, and says what it does in its body.

```yaml
allowed-tools:
  - Bash(git log:*)
```

```markdown
## The pass

1. **Read for candidates.** Work through the document with `references/what-counts.md` — the
   shapes a dependency takes, and how the strong ones surface.
```

The declaration was true when it was written: the pass asked git what had changed and read nothing.
Then a step was added that opens a file, and the line at the top of the same file went stale in the
commit that made it false.

**Reported as** one edge:

```
the body → the frontmatter   strong   allowed-tools
  fires on: a step being added that needs a tool the declaration does not list
  span:     "allowed-tools"
```

Nothing crossed a file boundary, so nothing outside will ever flag it: no link went stale, and a
reviewer reading the diff sees a body change. A declaration is the part of a file least likely to
be re-read while the body is being edited, which is exactly what earns it an edge.
