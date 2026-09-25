---
name: avoid-unverifiable-context
description: >
  Forces the text a stranger can go and check: the rationale a reader who was never in the room can
  still trace, never the conversation that produced it, the review feedback, the discarded
  alternatives, or a past state the current code no longer shows. Applies when writing an issue, a
  PR description, a code comment, an API or design doc, or any text or code that will be read
  later. Does not apply when the material is reachable and what it costs is the trip to it, when the
  question is an issue body's sections and criteria, or when the text is an ephemeral chat reply or
  a working note.
user-invocable: false
disable-model-invocation: false
---

## Overview

This skill holds text that persists down to what a stranger can go and check. Process only replays
for the people who were there: "as pointed out in review", "we originally went with X" rest on a
timeline the reader cannot reconstruct, and an unreachable reference fails the same way — the reader
is equally stuck whether the target never existed or merely cannot be got at from here.

## When it applies

To every artifact that persists, wherever it lives: a code comment, a commit message, a PR or issue
description, an API or design doc, a Notion or docx page. Judge the artifact against this skill
before you write it.

## The test

One question about the text: **can the reader go and check what it says?**

- They can: business requirements, regulations, domain constraints, product decisions, and anything
  still present in the current code, types, or schemas. Write it.
- They cannot: the conversation, the review thread, the trial and error, the policy as it stood
  before, an argument that was removed. Drop it.

Where the target *is* reachable and the reader should still not have been sent to it, nothing is
deleted — the fact is restated at the point of use, which is a different finding.

## The rules

- **Keep the rationale, drop the process.** Why the spec or design exists is decision-making
  material; "review feedback led to", "the policy changed", "originally we went with X" depend on
  a timeline only participants can follow.
- **Describe the current shape on its own terms.** "Not A but B", "A is deprecated", "A was
  removed" each assume the reader knows A, and a reader who does not cannot tell what the sentence
  is ruling out.
- **Confine cross-issue references to short `TODO(#123): ...` notes.** That names exactly what to
  read and where, which is what makes it the one reachable form; "handled in another issue" is not.
- **Keep a deprecation note only while the implementation still exists** — while it does, the note
  describes part of the shape the reader can observe. Once the implementation is gone, the note
  refers to nothing and goes with it.
- **Put process you have to keep where process belongs** — a PR description's Background section, or
  an ADR, never source code, user-facing docs, or an API reference, where every reader afterwards
  pays to read material none of them can check.
- **Write in the reader's language** — the repository's for a code comment or PR description, the
  tracker's for an issue — and in that one language only: a second copy of the same content ages
  independently, and no reader can tell which copy is current.

## Which file to read

| The question | Read |
|---|---|
| A worked Bad → Good pair for the artifact in hand — a code comment, an issue body, or a deprecation note whose implementation is gone | [`references/examples.md`](references/examples.md) |

## Persistence

In force for every response once it is loaded, not only the one that loaded it. Still in force
while you are unsure whether what you are writing will be read later. Released when the work turns
to what nobody will read later, or when you are told to stop.

## Common Rationalizations

| Rationalization | Reality |
|---|---|
| "This is a code comment / commit message / issue / Notion page — not really a 'document,' so this doesn't apply." | It applies. Whether the artifact persists is the test, not what it is called — a commit message and a Notion page outlive the thread they came out of exactly as an API doc does. This is the failure that recurs. |
| "It reads fine to me." | You are supplying the intent the text is missing as you read it. Judge it as someone holding only the text — that is the whole failure mode. |
| "Including the conversation history gives the reader helpful context." | The reader was never in the conversation, so the log is noise to them. Keep the *why*; drop the *how it came to be*. |
| "The review asked for this change, so I'll record that." | Review feedback is process. State the resulting decision, not that a review requested it. |
| "I'll list the alternatives we rejected so it's transparent." | Discarded options are writer-only context. Omit them unless the reader genuinely must know why not. |
| "This PR description can assume the reader saw the thread." | A persistent doc outlives the thread. Write it for someone opening it cold, months later. |

## Red Flags

- "As discussed", "we originally went with", "per review feedback": a timeline only participants
  can follow.
- A contrast that assumes the reader knows the other side — "not A but B", "A was removed".
- A bare `issue: 1234`, or a link into a workspace this reader may not have.

## Verification

- [ ] Every claim is checkable from the current code, types, schemas, or a stated external rule.
- [ ] A reader with zero context meets no proper noun or premise that arrives unintroduced.
