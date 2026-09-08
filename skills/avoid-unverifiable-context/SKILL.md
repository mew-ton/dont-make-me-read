---
name: avoid-unverifiable-context
description: >
  Persistent text must not carry what its reader cannot go and check — the conversation that
  produced it, review feedback, discarded alternatives, or a past state the current code no longer
  shows. Keep the rationale (business requirements, regulations, domain constraints, product
  decisions): those are external events a reader who was never in the room can still trace. Drop
  the process: only the people in that room can reconstruct it. Apply when writing an issue, a PR
  description, a code comment, an API or design doc, or any text that will be read later. DO NOT
  use for a reference the reader genuinely can reach but should not have been sent to (that is
  avoid-reference-detours), for an issue body's sections and criteria (that is
  write-nice-issue-description), or for ephemeral chat replies and working notes.
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

- **Rationale survives the room.** Business requirements, regulations, domain constraints, and
  product decisions are external events. A reader who was never in the original conversation can
  still trace them, so they are worth the lines they take
- **Process only replays for participants.** "As pointed out in review", "we originally went with
  X", "the policy changed" rely on a timeline only the people in that discussion can reconstruct.
  From outside, *when* and *whose* are undefined, and the text ages into noise
- **Observable facts are not history.** Anything still in the current code, types, or schemas — a
  deprecated API that is still declared, for instance — is shared context. The reader can see it,
  so describing it is current state
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
4. **Confine cross-issue references to short `TODO(#123): ...` notes.** "Handled in another issue"
   or "to be addressed later" belongs in a TODO that names the issue, never in prose, docstrings,
   or API descriptions. A `TODO(#123)` names exactly what to read and where, which is what makes it
   the one reachable form of this
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
8. **Self-check against a reader with nothing.** Hand the text to someone with zero context and look
   for proper nouns or premises that arrive unintroduced. To run this mechanically rather than by
   impression, use `review-self-contained-docs`

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
| "The examples in this skill are in English, so the doc should be." | The examples are in English because the skill is. Write in the language the readers of *that* artifact already use. |

## Examples

### Bad: a code comment dragging in the process behind the change
```typescript
// Validation used to be inline, but reviewers asked to extract it.
// The retry option is being discussed in another issue (#456) and is not implemented yet.
export function fetchUser(id: string): Promise<User> {
  validateUserId(id);
  return api.get(`/users/${id}`);
}
```

### Good: drop the process
```typescript
export function fetchUser(id: string): Promise<User> {
  validateUserId(id);
  return api.get(`/users/${id}`);
}
```

### Bad: process mixed into an issue body
```markdown
## What to do

Originally we were going to add a `bulk` flag to `POST /items`, but review feedback said
we should split it. So we're adding `POST /items/bulk` instead. The old `bulk` flag will
not be added.
```

### Good: the final shape, and the rationale behind it
```markdown
## What to do

Add a new `POST /items/bulk` endpoint. The request body accepts `{ items: Item[] }` and persists items in array order.

## Background

Single creation (`POST /items`) and bulk creation have different responsibilities (different transaction boundaries, different partial-failure semantics, and different rate-limit units), so the endpoints are kept separate.
```

The Background section carries the rationale — a domain-level difference in responsibilities, verifiable by a reader who was never in the original review.

### Bad: documenting a deprecation that no longer exists in the implementation
```markdown
## `createOrder(input)`

Creates an order. Previously this took a `currency` argument, but it has been deprecated.
The currency from account settings is used instead.
```

The `currency` argument is already gone from the implementation; it cannot be observed in the
current signature. The doc describes an argument the reader has no way to encounter.

### Good (after removal): the current spec, and the rationale
```markdown
## `createOrder(input)`

Creates an order. The currency comes from the account settings (each account is locked to a single transaction currency by service design).
```

### Good (during transition): the note stays while the implementation still accepts it
```typescript
interface CreateOrderInput {
  items: Item[];
  /** @deprecated The currency from account settings is used. This argument is ignored. */
  currency?: string;
}
```

```markdown
## `createOrder(input)`

Creates an order. The currency comes from the account settings (each account is locked to a single transaction currency by service design).

`input.currency` is deprecated (still accepted for backward compatibility, but ignored).
```

The argument is still in the type definition, so the reader can observe it from their IDE or type
checker. The note describes the current spec, not the process that produced it.

## Related skills

- `avoid-reference-detours` — the other half of the same split: a target that *is* reachable, and
  the reader was still sent to it.
- `review-self-contained-docs` — audits written text against both, per unit, from the reader's side.
