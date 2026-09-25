---
name: avoid-reference-detours
description: >
  Forces the fact restated at the point of use over the pointer that sends the reader away to get
  it — "the format rules at the top of this file", "same as the config", a section that defers to
  another section — leaving the original where it is and authoritative. Applies when writing a code
  comment, a docstring, a PR description, or any text that points elsewhere to be understood. Does
  not apply when the target does not exist or cannot be reached at all, when the same content is
  repeated twice inside one document, or when a module branches on which caller invoked it.
user-invocable: false
disable-model-invocation: false
---

## Overview

This skill brings the fact a reader needs to the point where they use it, instead of sending them
off to get it. A reference they can genuinely open is still a defect when following it was never
optional: the round trip is what costs them, not the fact.

## When it applies

To any sentence that cannot be understood without going somewhere else: a comment, a docstring, a
PR description, a section that defers to another section. It does not apply when:

- The target does not exist for this reader at all — a conversation, a removed declaration, a Slack
  thread. There is nothing to restate; the fix is to delete, and that question is asked first.
- The same content is stated twice inside one document. A reader reads a document in order, so the
  second statement costs them a re-read rather than a trip, and only a trip is this skill's.

## The rules

- **State the fact at the point of use, and leave the original where it is.** The file-header
  docstring, the schema, the spec, the config stays put and stays authoritative, which is why this
  subtracts rather than adds: the reader stops making the trip, and the two lines that would have
  described the trip go with it.
- **Bring the part this reader needs in order to act, in the shortest form that does the job.** The
  whole original copied to the point of use adds reading in place of the trip it removed.
- **Restate only where it removes a trip.** Of each line you add, ask: **does this change what the
  reader does next?** A line repeating what the code beside it already shows, or a background
  paragraph the reader would never have gone looking for, adds reading and removes no trip — point
  at `path:line` if the location needs naming at all.
- **Write the restated line in the language the artifact's readers already use.** A line they
  have to translate before they can act is the trip again, moved.

## Which file to read

| The question | Read |
|---|---|
| A worked Bad → Good pair for the case in hand — a doc comment deferring to its file header, or a cross-issue note in prose | [`references/examples.md`](references/examples.md) |

## Persistence

In force for every response once it is loaded, not only the one that loaded it. Still in force
while you are unsure whether the pointer you are about to write is one the reader could have done
without. Released when the work turns to text no reader comes to later, or when you are told to
stop.

## Common Rationalizations

| Rationalization | Reality |
|---|---|
| "It's reachable, so pointing to it is fine." | Reachability was never the problem; being sent there was. If the reader has to leave this comment or section to make sense of it, state it here. |
| "Restating it duplicates the source of truth." | The source of truth does not move — it stays where it is and stays authoritative. What comes here is the part this reader needs to act, not a second copy of the whole. |
| "More context at the point of use is always safer." | Only when it removes a trip. A line that repeats what the code beside it already shows adds reading and saves nothing. Run the test on every line you add, not only on the ones you cut. |
| "It reads fine to me." | You already know what is at the other end of the pointer, so the trip costs you nothing. The reader is the one paying for it. |

## Red Flags

- "See above", "same as the config", "as described in X" standing where the fact itself would fit.
- A restatement that adds a line and removes no trip, because the code beside it already showed it.
- The whole original copied to the point of use, instead of the part this reader needs.

## Verification

- [ ] Every remaining pointer is one the reader may decline to follow and still act.
- [ ] The original is still in place and still authoritative.
