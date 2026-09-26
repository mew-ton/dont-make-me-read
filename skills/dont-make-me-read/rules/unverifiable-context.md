# What a stranger can check

Read this when what you are writing will be read later — a code comment, a commit message, a PR or
issue description, an API or design doc, a Notion or docx page — and it is about to carry anything
that came out of how it was made. `SKILL.md` carries the test; this holds the rules for that case
and the Bad/Good pairs.

Process only replays for the people who were there: "as pointed out in review", "we originally
went with X" rest on a timeline the reader cannot reconstruct, and an unreachable reference fails
the same way — the reader is equally stuck whether the target never existed or merely cannot be
got at from here.

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

## Common Rationalizations

| Rationalization | Reality |
|---|---|
| "Including the conversation history gives the reader helpful context." | The reader was never in the conversation, so the log is noise to them. Keep the *why*; drop the *how it came to be*. |
| "The review asked for this change, so I'll record that." | Review feedback is process. State the resulting decision, not that a review requested it. |
| "I'll list the alternatives we rejected so it's transparent." | Discarded options are writer-only context. Omit them unless the reader genuinely must know why not. |
| "This PR description can assume the reader saw the thread." | A persistent doc outlives the thread. Write it for someone opening it cold, months later. |

## Red Flags

- A bare `issue: 1234`, or a link into a workspace this reader may not have.

## Verification

- [ ] Every claim is checkable from the current code, types, schemas, or a stated external rule.
- [ ] A reader with zero context meets no proper noun or premise that arrives unintroduced.

## Worked examples

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

The Background section carries the rationale — a domain-level difference in responsibilities,
verifiable by a reader who was never in the original review.

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
