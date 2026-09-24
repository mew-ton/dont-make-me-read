---
name: find-document-dependencies
description: >
  Reports what a document would have to be rewritten for — a link, a name carried in prose, a count,
  a definition copied from the file that owns it, a claim about a structure — as a directed graph of
  weak and strong edges. Applies when reviewing or revising a document, and before writing a
  sentence that names something the writer does not own. Does not apply when what is wanted is a
  verdict on whether a dependency is stale, wrong, or worth keeping, or a judgement of the document
  itself.
user-invocable: false
disable-model-invocation: false
allowed-tools:
  - Read
---

## Overview

This skill returns everything a document would have to be rewritten for as a graph — what is pinned
to what, which end has to move, how loudly it breaks — and judges none of it. A dependency nobody
drew is an edit somebody will be made to make, in a file they were not looking at.

## How to work

- **Spend the reading on the prose, not the pointers.** Whatever checks links is already better at
  the weak half than you are: report the weak ones you pass, and do not go hunting for them.
- **A span you are already reading gets both grades.** Only the hunting for weak ones was not worth
  the time.
- **Quote the span; never paraphrase it.** The caller has to weigh the actual sentence, and a
  paraphrase is a second copy with its own dependency.

## What a dependency is

Two texts are in a dependency when **fixing one obliges you to fix the other**, or they contradict.
A link is one shape it takes, and the cheapest one to find.

## Direction

Write it as an arrow: **A → B means fixing A obliges fixing B.** B is the end that has to move, and
the shape of a span does not say which end that is.

Between two texts the arrow can run either way, or both.

- **One way.** A → B and not B → A. B describes A, and A is free to move without it. Most of what
  you find is this, and the arrow is the whole finding: it says which of the two goes stale, and
  therefore which one a reader can trust.
- **Both ways.** A → B and B → A. Neither can be edited alone, so they are one thing wearing two
  filenames — a different entry with a different fix, not two one-way edges reported side by side.
  Two systems holding the same plan is the everyday case: the tracker the engineers work from and
  the page the schedule is planned on, each restating the other. Edit either and the other is
  wrong, and neither system can see that it happened.

For a name, the arrow's direction is the whole difference between a role the document defines and
the instance currently filling it. Same sentence, opposite upkeep.

## Strength

| | Weak | Strong |
|---|---|---|
| What is pinned | where the other end is | what the other end says |
| Shape | a pointer: a link, a path, an issue number, a citation | prose: a name, a description, a restatement of what the other end holds |
| It breaks when | the other end moves | the other end's content changes |
| Fixing it | repoint it, and the reader could usually still get there anyway | rewrite it: the sentence now says something untrue |
| How it is found | mechanically. A link checker finds every one of them | by reading. Nothing greps for "this paragraph describes something that moved" |

**One span can carry both, and they are graded separately.** "See the rollout plan in Notion" is a
pointer and nothing else. "The rollout is three phases, per the Notion plan" pins the location
*and* the content: the link survives a rewrite of the plan, and the sentence does not.

The columns invert, and that is the whole reason to look. Weak is the cheaper half twice over: a
tool finds every one of them, and the far end is rarely in the same session as the text pointing at
it, so the inconsistency sits there without being acted on. Strong has neither property. It always
needs the fix, and nobody notices, because the sentence still parses, still reads well, and still
looks exactly as true as the day it was written.

## The shapes on the page

| The text | Is pinned to | Breaks when | Strength |
|---|---|---|---|
| A link, a path, a line number | the location | it moves | weak |
| An issue, ticket, or PR number | that item | it is closed, moved, or renumbered | weak |
| A citation of an external source | someone else's decision | they revise it, or it goes away | weak |
| A name carried in the prose | that definition | it is renamed, removed, or its meaning moves | strong |
| A count, or a set claimed to be complete | the membership | anything joins or leaves | strong |
| A definition or plan copied from wherever it is owned | the owner | the owner changes and this copy does not | strong |
| A claim about how something is arranged | that arrangement | it is restructured | strong |
| A translation, mirror, or second copy | the whole original | any part of the original changes | strong |
| A declaration about the file it sits in | what the rest of that file says | the body gains or loses something the declaration has to cover | strong |

The list is not closed. A shape that is not here still counts if fixing the other end obliges a fix
here — that definition is the test, and the table is only the part of it that recurs.

### Spotting the strong ones

They do not announce themselves, so read for the shape of the sentence rather than for a marker.

- **Every proper noun is a question: who owns this name?** If the answer is somewhere else, the
  sentence is pinned to that somewhere else.
- **Every present-tense claim about something outside this file** — what it does, what it contains,
  how it is put together — is a claim about that thing's current state, and it expires when the
  state does.
- **Every enumeration.** "A and B", "the three phases", "each of the modules": a set is a
  membership claim whether or not it says how many.
- **Every sentence you could only have written with the other thing open.** That is the tell for a
  copied definition. If writing it required reading the source, keeping it true will too.
- **Every "as described in", "per", "same as".** The pointer is weak; what the sentence asserts
  around the pointer usually is not.
- **Both ends can be in the same file.** A header declares, a body describes, and editing the body
  can leave the header saying something the file no longer does. Nothing crossed a file boundary,
  so nothing external will ever flag it — and the header is the part least likely to be re-read
  while the body is being changed.

### What is not a dependency

- Vocabulary the whole field shares. Naming HTTP, or a merge conflict, pins nothing.
- An example invented for the page, which nothing outside it owns — which is also why an example
  written against the tree you are documenting is worth more scrutiny than one that is not.

## The pass

1. **Read for candidates.** Work through the document against the shapes above, reading for the
   strong ones, since nothing extracts those for you.
2. **Settle each arrow.** Say which end has to move, and check the opposite direction too: an edge
   running back is its own entry, not a duplicate of the one you just wrote.
3. **Assemble the graph.** Nodes are the things: this document, and each file, section, or outside
   source it touches. Edges are `A → B`, one per direction. An edge carries the spans that create
   it, the change that fires it, and its strength.
4. **Report it, strong edges first.**

Spans are the evidence; the graph is what the caller reads a shape off — which node everything
points into, which pair points at each other, which node nothing points into at all. None of that
is visible in a list of spans, and all of it is what decides the next move.

Return the edges you found and say nothing about the ones you did not. A pass that reports "no
other dependencies" is claiming completeness it cannot have.

## Which file to read

| The question | Read |
|---|---|
| What a reported edge looks like written out — an arrow running into a document instead of away from it, a both-ways pair split across two systems, an edge with both ends inside one file | [`references/examples.md`](references/examples.md) |

## Common Rationalizations

| Rationalization | Reality |
|---|---|
| "Only links are dependencies; the rest is just prose." | A name is a link the reader cannot click and the maintainer cannot grep for. It breaks the same way and announces it less. |
| "It is only a link, so it is weak." | The link is. What the sentence says *about* the other end is not, and the two sit in the same span. Grade them separately, or the strong half rides in unreported on the weak half's verdict. |
| "The other end is somebody else's system, so it is not mine to worry about." | That is where a both-ways pair hides: two places restating one plan, each invisible to the other's tooling. It is the least likely thing to surface on its own, which is the argument for reporting it, not against. |
| "The link check passed, so the document is fine." | It passed on the half that was never the problem. Every dependency a tool can find is one somebody would have found anyway; the ones that always need fixing are the ones only reading finds. |
| "It is accurate right now, so it is fine." | Every dependency was accurate when it was written. What is being weighed is what happens on the day it stops being. |
| "Listing this many would be noise." | The graph is the finding. Whether an entry is worth acting on is the caller's call, and they cannot make it for the entries you filtered out. |
| "This one is obviously fine, so I will leave it out." | Obviously fine is a verdict. Report it and let the caller agree with you. |
| "I will note that the rest of the document is clean." | You checked what you checked. A completeness claim is itself a dependency — on your own thoroughness, which nobody can verify later. |
| "The spans are all there; drawing the arrows is presentation." | The arrows are the finding. A span says two texts touch; only the direction says which of them is about to be wrong, and a caller cannot derive that from a list they were handed instead. |

## Red Flags

- A report that says "no other dependencies" — completeness it cannot have.
- Spans paraphrased instead of quoted.
- A verdict — "this is stale", "drop it" — where an edge belongs.
- Links only, when most of what pins a document is prose.
- A span reported without an arrow on it, or an arrow with neither end named as the one that moves.

## Verification

Each box is here because what it catches leaves the caller unable to act on the report or to check
it. The rest of the rules are met by reading them where they live.

- [ ] Every edge names which end has to move, and the opposite direction was checked too.
- [ ] Every edge carries the span that creates it, quoted.
- [ ] Strong edges come first, and nothing is claimed about what was not found.
