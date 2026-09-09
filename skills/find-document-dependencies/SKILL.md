---
name: find-document-dependencies
description: >
  A document depends on whatever it would have to be rewritten for, and a link is the least of it:
  a name carried in prose, a count, a definition copied from the file that owns it, a claim about a
  structure. Surfaces each with what it is pinned to, what breaks it, and whether it is weak — a
  pointer a link checker already finds, which often survives — or strong, which always has to be
  fixed and which nothing but reading finds. Apply when reviewing or revising a document, and
  before writing a sentence that names something you do not own. DO NOT expect a verdict on whether
  a dependency is stale, wrong, or worth keeping — this reports what the text is pinned to and
  leaves the judgement to whoever asked.
user-invocable: false
disable-model-invocation: false
allowed-tools: []
---

## Scope

Two texts are in a dependency when fixing one obliges you to fix the other, or they contradict.
A link is one shape that takes; it is not the interesting one.

This skill reports what a document is pinned to. It does not judge. A dependency is not a defect —
a document with none says nothing about anything — and whether one earns its upkeep is a question
about what it buys, which the caller is holding and this skill is not.

## Two strengths, and why the weak one is not where the work is

| | Weak | Strong |
|---|---|---|
| Shape | a pointer: a link, a path, an issue number, a citation | prose: a name, a description, an explanation of what the other end says |
| Does it have to be fixed | not always — a pointer can survive the thing it points at changing | always — the sentence now says something untrue |
| How it is found | mechanically. A link checker finds every one of them | by reading. Nothing greps for "this paragraph describes something that moved" |

The two properties invert, and that is the whole reason to look. Weak dependencies are cheap to
find and often safe to leave. Strong ones always need the fix and nobody will notice them, because
the sentence still parses, still reads well, and still looks exactly as true as the day it was
written.

So the reading goes into the strong ones. Report the weak ones you pass, briefly, and do not spend
the pass on them: whatever checks links is already better at it than you are.

## What counts

| The text | Is pinned to | Breaks when | Strength |
|---|---|---|---|
| A link, a path, a line number | the location | it moves | weak |
| An issue, ticket, or PR number | that item | it is closed, moved, or renumbered | weak |
| A citation of an external source | someone else's decision | they revise it, or it goes away | weak |
| A name carried in the prose | that definition | it is renamed, removed, or its meaning moves | strong |
| A count, or a set claimed to be complete | the membership | anything joins or leaves | strong |
| A definition copied from the file that owns it | the owner | the owner changes and this copy does not | strong |
| A claim about how something is arranged | that arrangement | it is restructured | strong |
| A translation, mirror, or second copy | the whole original | any part of the original changes | strong |

One more axis costs nothing and changes what a strong dependency is worth: **role or instance.** A
name for an architectural role outlives whatever currently fills it; a name for the filler does
not. Same sentence, different upkeep, and the caller cannot tell them apart from the span alone.

## What to return

Per dependency: the span, what it is pinned to, what change breaks it, its strength, and — for a
strong one — whether it is pinned to a role or an instance. Lead with the strong ones. Quote the
span rather than describing it: the caller has to weigh the actual sentence, and a paraphrase is a
second copy with its own dependency.

Return the ones you found and say nothing about the ones you did not. A pass that reports "no other
dependencies" is claiming completeness it cannot have.

## Common Rationalizations

| Rationalization | Reality |
|---|---|
| "Only links are dependencies; the rest is just prose." | A name is a link the reader cannot click and the maintainer cannot grep for. It breaks the same way and announces it less. |
| "The link check passed, so the document is fine." | It passed on the half that was never the problem. Every dependency a tool can find is one somebody would have found anyway; the ones that always need fixing are the ones only reading finds. |
| "It is accurate right now, so it is fine." | Every dependency was accurate when it was written. What is being weighed is what happens on the day it stops being. |
| "Listing this many would be noise." | The list is the finding. Whether an entry is worth acting on is the caller's call, and they cannot make it for the entries you filtered out. |
| "This one is obviously fine, so I will leave it out." | Obviously fine is a verdict. Report it and let the caller agree with you. |
| "I will note that the rest of the document is clean." | You checked what you checked. A completeness claim is itself a dependency — on your own thoroughness, which nobody can verify later. |

## Example: the strong dependency nobody sees until it has already broken

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

**Reported as:** the span above; pinned to the membership of two layers; breaks when any module is
added, removed, or renamed; strong; pinned to instances, not to roles — every name in it is a
filler.

The same section with nothing pinned:

```markdown
## Layers

A module is in the parsing layer if it turns text into a tree without resolving a name, and in the
analysis layer if it resolves names against a tree it did not build.
```

A new module now places itself, and the file is as right the day after it lands as the day before.

## Related skills

- `avoid-reference-detours` — the reader's side of a pointer: the trip they were made to take. This
  skill is the maintainer's side: the edit somebody will be made to make.
- `write-nice-architecture-docs` — the artifact where these dependencies cost the most, and which
  states which ones an architecture doc may take.
