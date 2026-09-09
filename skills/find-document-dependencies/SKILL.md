---
name: find-document-dependencies
description: >
  A document depends on whatever it would have to be rewritten for, and a link is the least of it:
  a name carried in prose, a count, a definition copied from the file that owns it, a claim about a
  structure. Assembles them into a directed graph — which end has to move when the other changes,
  one edge per direction — with each edge marked weak, a pointer a link checker already finds and
  which often survives, or strong, which always has to be fixed and which nothing but reading
  finds. Apply when reviewing or revising a document, and before writing a sentence that names
  something you do not own. DO NOT expect a verdict on whether a dependency is stale, wrong, or
  worth keeping — this reports what the text is pinned to and leaves the judgement to whoever
  asked.
user-invocable: false
disable-model-invocation: false
allowed-tools: []
---

## Scope

Point this at a document and it returns everything that document would have to be rewritten for,
assembled into a graph: what is pinned to what, which end has to move, and how loudly it breaks.
Links are in it, and are the least of it — most of what pins a document is prose.

It does not judge. A dependency is not a defect; a document with none says nothing about anything.
Whether one earns its upkeep is a question about what it buys, which the caller is holding and this
skill is not.

## Terms

### Dependency

Two texts are in a dependency when **fixing one obliges you to fix the other**, or they contradict.
A link is one shape that takes; it is not the interesting one.

### Direction

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

### Strength

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

## The pass

1. **Read for candidates.** Work through the document with
   [`references/what-counts.md`](references/what-counts.md) — the shapes a dependency takes, and
   how the strong ones surface. Spend the reading there: whatever checks links is already better at
   the weak half than you are. Report the weak ones you pass and do not go hunting for them; a span
   you are already reading gets both grades, since it is the hunting that was not worth the time,
   not the grading.
2. **Settle each arrow.** Say which end has to move, and check the opposite direction too: an edge
   running back is its own entry, not a duplicate of the one you just wrote.
3. **Assemble the graph.** Nodes are the things: this document, and each file, section, or outside
   source it touches. Edges are `A → B`, one per direction. An edge carries the spans that create
   it, the change that fires it, and its strength.
4. **Report it, strong edges first.** Quote the spans rather than describing them: the caller has
   to weigh the actual sentence, and a paraphrase is a second copy with its own dependency.

Spans are the evidence; the graph is what the caller reads a shape off —
which node everything points into, which pair points at each other, which node nothing points into
at all. None of that is visible in a list of spans, and all of it is what decides the next move.

Return the edges you found and say nothing about the ones you did not. A pass that reports "no
other dependencies" is claiming completeness it cannot have.

For worked examples — an arrow running into an architecture doc instead of away from it, and a
both-ways pair split across two systems — see
[`references/examples.md`](references/examples.md).

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

## Related skills

- `avoid-reference-detours` — the reader's side of a pointer: the trip they were made to take. This
  skill is the maintainer's side: the edit somebody will be made to make.
- `write-nice-architecture-docs` — the artifact where these dependencies cost the most, and which
  states which ones an architecture doc may take.
