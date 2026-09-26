---
name: dont-make-me-read
description: >
  Forces the narrowest range a reader has to hold before they can act — the range its writer cannot
  feel. Applies while writing or revising anything another person or an agent reads in order to act:
  drafting, documenting, commenting, specifying, explaining, reviewing, or writing, refactoring and
  designing the code itself. Does not apply in place of the rules that own the artifact in hand — it
  carries no template, no budget, and no section list — nor when nobody acts on the text later: chat
  replies, scratchpads, working notes.
user-invocable: false
disable-model-invocation: false
---

## Overview

This skill holds anything written to be acted on down to the narrowest range its reader has to hold
before they can act: the writer is the one person who cannot tell how much they are asking for.

## The range

The range is everything the reader has to hold in order to act on what is in front of them. It is
not the length of what they are reading: a short paragraph that only means something once you have
opened two other files has a wide range.

| What went wrong | What the reader pays | The fix |
|---|---|---|
| Something in the range does not bear on the decision | reads it, and decides confidently on it | cut it |
| The range reaches something this reader cannot get to at all | a dead end | cut it |
| The range reaches something they can get to, and they have to go | a round trip | state the part they need, here |

In code, the round-trip fix inverts: a module that restates what its callers know takes on a
dependency on them, and every later caller is inside its range. Take the knowledge out instead.

## Which file to read

| The question | Read |
|---|---|
| The text leans on what its reader cannot reach: a discussion, a review, a past state | [`rules/unverifiable-context.md`](rules/unverifiable-context.md) |
| The text sends its reader somewhere they can get to | [`rules/reference-detours.md`](rules/reference-detours.md) |
| Code with more than one caller, or the interface between them | [`rules/caller-knowledge.md`](rules/caller-knowledge.md) |
| The text is finished | [`VERIFICATION.md`](VERIFICATION.md) |

## The test

At every granularity of the range — word, sentence, section, file:

> **Does this change what the reader does next?**

No: cut it. Yes, and it is missing: add it. Shorter and longer are both outcomes, never goals.

What noise costs is not reading time. It is a **wrong decision, made confidently** — and the reader
is a person or an agent, always both, who do not fail the same way:

| Noise | What the reader concludes |
|---|---|
| A menu of fixes you could have weighted yourself | that the choice is theirs — to be made with less information than you had |
| The paths you happened to sample, given as the fix | an agent: that those files are the complete set to touch; a person: "at least these" |
| "handle this appropriately" | that the spec is complete |
| The implementation method, in an issue | that the shape you saw while writing is still the shape today |

## What must never be cut

Whatever the decision depends on and the reader cannot reconstruct:

- the rationale behind a spec or design — the business requirement, the regulation, the domain
  constraint, the product decision
- the constraint that rules out the obvious wrong move, stated as the wall they would walk into
  rather than as an option offered to them
- the fact that makes the ask defensible at all

Cutting one of these does not narrow the range; it hands a decision to someone with less to decide
on. A line that is expensive to read and that the decision needs, stays. The length cap reaches only
the path a reader must take to find out what to do — backing material, such as worked examples,
evidence, or the original a pointer leads to, is fetched by whoever needs it and is not capped.

## Persistence

In force for every response once it is loaded, not only the one that loaded it, and so is a rule
file once read. Still in force while you are unsure whether what you are about to write counts as
something someone acts on. Released when the work turns to what nobody reads to act on, or when you
are told to stop.

## Common Rationalizations

| Rationalization | Reality |
|---|---|
| "I have the principle now, so I can write this without the rules for the artifact." | The principle says what to aim at, never what the artifact must contain — its section list, budgets and gates. Load those too. |
| "Shorter is better, so cut it." | Cutting is one of two outcomes; the other is adding what the decision needs. Ask which the line is. |
| "More context is safer." | Context the decision does not use is what makes a reader confident about the wrong thing. |
| "This is code, not text, so the range is not my problem." | Code is read before it is changed, by someone holding whatever it depends on. |
| "It reads fine to me." | You are supplying the intent the text is missing as you read it. Judge it as someone holding only the text — that is the whole failure mode. |
| "It's reachable, so pointing to it is fine." | Being sent there is the cost, whether or not it can be reached. |
| "It's only a comment / commit message / issue, not a document." | Whether it outlives the thread is the test, not what it is called. |
| "A flag on the shared function is the smaller diff." | Today. From here on the callee is edited once per caller. |
| "This has been in force a while, so it has done its job." | It is retaken every response; the turn it lapses is the turn you write the paragraph nobody can act on. |

## Red Flags

- A sentence that only means something with another file open: "see above", "same as the config".
- "As discussed", "we originally went with", "not A but B": a past only participants can follow.
- A parameter whose only honest name is a caller's: `isDetailPage`, `from: 'pageA'`.
- A paragraph kept because it is true rather than because it changes what the reader does next.
- A constraint offered as an option — "you could also…" — instead of as the wall they would walk
  into.
- A draft that got shorter by losing the rationale, the constraint, or the fact that makes the ask
  defensible.
