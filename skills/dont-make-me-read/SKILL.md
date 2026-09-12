---
name: dont-make-me-read
description: >
  Forces the narrowest range a reader has to hold before they can act — the range its writer cannot
  feel, since a writer reads their own draft while supplying what it is missing, so it reads small
  to them and only to them. Applies while writing or revising anything another person or an agent
  reads in order to act: drafting, documenting, commenting, specifying, explaining, reviewing, or
  writing the code itself, and it stays in force for the rest of that work. Does not apply in place
  of the rules that own the artifact in hand — it carries no template, no budget, and no section
  list — nor when nobody acts on the text later: chat replies, scratchpads, working notes.
user-invocable: false
disable-model-invocation: false
allowed-tools: []
---

## The range

The range is everything the reader has to hold in order to act on what is in front of them. It is
not the length of what they are reading: a short paragraph that only means something once you have
opened two other files has a wide range.

It goes wrong in three ways.

| What went wrong | What the reader pays | The fix |
|---|---|---|
| Something in the range does not bear on the decision | reads it, and decides confidently on it | cut it |
| The range reaches something this reader cannot get to at all | a dead end | cut it |
| The range reaches something they can get to, and they have to go | a round trip | state the part they need, here |

The third inverts in code. Text can restate a fact and leave the original authoritative, because
nothing executes: the reader stops travelling and the original stays where it is. A module that
restates what its callers know copies nothing — it takes on a dependency on them, and every caller
after that is inside its range. There the fix is to take the knowledge out, not to bring it in.

## The test

Inside the range, at every granularity — a word, a sentence, a section, a file:

> **Does this change what the reader does next?**

No: cut it. Yes, and it is missing: add it. Shorter and longer are both outcomes, never goals.

What noise costs is not reading time. It is a **wrong decision, made confidently**:

| Noise | What the reader concludes |
|---|---|
| A menu of fixes you could have weighted yourself | that the choice is theirs — to be made with less information than you had |
| The paths you happened to sample, given as the fix | that those files are the complete set to touch |
| "handle this appropriately" | that the spec is complete |
| The implementation method, in an issue | that the shape you saw while writing is still the shape today |

## Who the reader is

A person or an agent, always both, and they do not fail the same way. A list of the paths you
happened to sample reads to a person as "at least these, and probably others like them"; a coding
agent takes it as the complete set to touch, and stops there. Same text, same range, two different
wrong decisions.

## What must never be cut

Whatever the decision depends on and the reader cannot reconstruct:

- the rationale behind a spec or design — the business requirement, the regulation, the domain
  constraint, the product decision
- the constraint that rules out the obvious wrong move, stated as the wall they would walk into
  rather than as an option offered to them
- the fact that makes the ask defensible at all

Cutting one of these does not narrow the range. It hands a decision to someone with less to decide
on, which is the failure this whole set exists to prevent. A line that is expensive to read and
that the decision needs, stays.

## Where the length cap applies

Only to the path a reader must take to find out what to do. Backing material is fetched by whoever
needs it and is not capped.

| | Capped | Because |
|---|---|---|
| The mandatory path | yes | everyone pays for it, every time |
| Backing material — worked examples, evidence, the original a pointer leads to | no | only the reader who needs it pays |

## Persistence

In force for every response once it is loaded, not only the one that loaded it. Still in force
while you are unsure whether what you are about to write counts as something someone acts on.
Released when the work turns to what nobody reads to act on, or when you are told to stop.

## Common Rationalizations

| Rationalization | Reality |
|---|---|
| "I have the principle now, so I can write this without the rules for the artifact." | The principle does not carry the section list, the budgets, or the gates. It says what to aim at, never what the artifact must contain. Having this in force is not a substitute for loading that. |
| "Shorter is better, so cut it." | Shorter is a result, never the goal. A line the decision depends on stays however much it costs to read. |
| "More context is safer." | Context the decision does not use is exactly what makes a reader confident about the wrong thing. Safety is the list above, not volume. |
| "This is code, not text, so the range is not my problem." | Code is read before it is changed, by someone who has to hold whatever it depends on. The range is the same measure; only the third row's fix inverts. |
| "It reads fine to me." | You are supplying the intent the text is missing as you read it. Judge it as someone holding only the text — that is the whole failure mode. |
| "This has been in force a while, so it has done its job." | It is retaken every response. The turn where it lapses is the turn you write the paragraph nobody can act on. |
