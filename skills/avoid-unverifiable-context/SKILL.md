---
name: avoid-unverifiable-context
description: >
  Forces the text a stranger can go and check: the rationale a reader who was never in the room
  can still trace, never the conversation that produced it, the review feedback, the discarded
  alternatives, or a past state the current code no longer shows. Use this skill when writing an
  issue, a PR description, a code comment, an API or design doc, or any text or code that will be
  read later. DO NOT use for a reference the reader genuinely can reach but should not have been
  sent to (that is avoid-reference-detours), for an issue body's sections and criteria (that is
  write-nice-issue-description), or for ephemeral chat replies and working notes.
user-invocable: false
disable-model-invocation: false
allowed-tools: []
---

## Scope

Text that persists is read by someone who was not there when it was written. This skill governs one
question about that text: **can the reader go and check what it says?**

- They can: business requirements, regulations, domain constraints, product decisions, and anything
  still present in the current code, types, or schemas. Write it.
- They cannot: the conversation, the review thread, the trial and error, the policy as it stood
  before, an argument that was removed. Drop it.

A reference the reader genuinely *can* open, but should not have been sent to, is a different
defect — `avoid-reference-detours` owns it. Here the target does not exist for this reader at all,
so there is nothing to restate and the fix is always the same: delete.

## Why

- **Process only replays for participants.** "As pointed out in review", "we originally went with
  X", "the policy changed" rely on a timeline only the people in that discussion can reconstruct.
  From outside, *when* and *whose* are undefined, and the text ages into noise
- **An unreachable reference is the same failure.** A Notion page, a Slack thread, a decision made
  in this session, or a bare `issue: 1234` that does not say which system it belongs to: the reader
  ends up equally stuck whether the target never existed or merely cannot be got at from here

## Guidance

1. **Keep the rationale.** Write down why the spec or design exists. That is decision-making
   material for the reader
2. **Drop the process.** Avoid "review feedback led to", "the policy changed", "originally we went
   with X" — phrasing that depends on a timeline only participants can follow
3. **Watch contrastive phrasing.** "Not A but B", "A is deprecated", "A was removed" all assume the
   reader knows A. If they do not, describe B on its own
4. **Confine cross-issue references to short `TODO(#123): ...` notes.** A `TODO(#123)` names
   exactly what to read and where, which is what makes it the one reachable form of this; "handled
   in another issue" in prose or an API description is not
5. **Deprecation notes are fine while the implementation exists.** Mark a parameter, endpoint, or
   function deprecated when it is still part of the shape the reader can observe. Once the
   implementation is gone, the note refers to nothing and goes with it
6. **If the process must be kept, put it where process belongs.** A PR description's Background
   section, or an ADR. Not source code, not user-facing docs, not an API reference
7. **Write in the reader's language.** Use the language the artifact's readers already use — the
   repository's for a code comment or PR description, the tracker's for an issue. This skill is
   about what context the text carries, not which language carries it. Never restate the same
   content in a second language: the translation ages independently and no reader can tell which
   copy is current
8. **Self-check against a reader with nothing.** Hand the text to someone with zero context and
   look for proper nouns or premises that arrive unintroduced

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
