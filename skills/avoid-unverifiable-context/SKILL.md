---
name: avoid-unverifiable-context
description: >
  Forces the text a stranger can go and check: the rationale a reader who was never in the room can
  still trace, never the conversation that produced it, the review feedback, the discarded
  alternatives, or a past state the current code no longer shows. Applies when writing an issue, a
  PR description, a code comment, an API or design doc, or any text or code that will be read
  later. Does not apply when the reader genuinely can reach the reference but should not have been
  sent to it, when the question is an issue body's sections and criteria, or when the text is an
  ephemeral chat reply or a working note.
user-invocable: false
disable-model-invocation: false
allowed-tools: []
---

## Overview

Text that persists is read by someone who was not there when it was written, and process only
replays for participants: "as pointed out in review", "we originally went with X" rely on a
timeline they cannot reconstruct. An unreachable reference fails the same way — the reader is
equally stuck whether the target never existed or merely cannot be got at from here.

## The rule

One question about the text: **can the reader go and check what it says?**

- They can: business requirements, regulations, domain constraints, product decisions, and anything
  still present in the current code, types, or schemas. Write it.
- They cannot: the conversation, the review thread, the trial and error, the policy as it stood
  before, an argument that was removed. Drop it.

Where the target *is* reachable and the reader should still not have been sent to it, nothing is
deleted — the fact is restated at the point of use, which is a different finding.

## Guidance

1. **Keep the rationale, drop the process.** Why the spec or design exists is decision-making
   material; "review feedback led to", "the policy changed", "originally we went with X" depend on
   a timeline only participants can follow
2. **Watch contrastive phrasing.** "Not A but B", "A is deprecated", "A was removed" all assume the
   reader knows A. If they do not, describe B on its own
3. **Confine cross-issue references to short `TODO(#123): ...` notes.** That names exactly what to
   read and where, which is what makes it the one reachable form; "handled in another issue" is not
4. **Deprecation notes are fine while the implementation exists** — it is still part of the shape
   the reader can observe. Once it is gone, the note refers to nothing and goes with it
5. **If the process must be kept, put it where process belongs.** A PR description's Background
   section, or an ADR. Not source code, not user-facing docs, not an API reference
6. **Write in the reader's language** — the repository's for a code comment or PR description, the
   tracker's for an issue. Never restate the same content in a second language: the translation
   ages independently and no reader can tell which copy is current

## Common Rationalizations

The most common failure is not applying this at all, because the artifact did not feel like a
"document." Close that off first, then the process-leak excuses:

| Rationalization | Reality |
|---|---|
| "This is a code comment / commit message / issue / Notion page — not really a 'document,' so this doesn't apply." | It applies. The target is **every artifact that persists**, wherever it lives — code comments, commit messages, PR and issue descriptions, API and design docs, and Notion / docx pages all count. This is the failure that recurs; check the artifact against this skill *before* writing it, not only when the thing is labelled "doc." |
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
- [ ] No sentence depends on when it was written or who was in the room.
- [ ] Cross-issue references are `TODO(#123): …`, naming what to read.
- [ ] A reader with zero context meets no proper noun or premise that arrives unintroduced.

## Persistence

In force for every response once it is loaded, not only the one that loaded it. Still in force
while you are unsure whether what you are writing will be read later. Released when the work turns
to what nobody reads to act on, or when you are told to stop.

## Examples

Bad/Good pairs for a code comment, an issue body, and a deprecation note that outlived its
implementation: [`references/examples.md`](references/examples.md).

## Related skills

- `avoid-reference-detours` — the other half of the same split: a target that *is* reachable, and
  the reader was still sent to it.
- `review-self-contained-docs` — audits written text against both, per unit, from the reader's side.
