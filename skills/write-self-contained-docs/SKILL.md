---
name: write-self-contained-docs
description: >
  Write any document that will persist on the assumption that the reader does not share your
  context. Keep the rationale (why the spec or design exists — business requirements, regulations,
  domain constraints, product decisions) and drop the process (the conversation log, review
  feedback, and discarded alternatives that produced this PR). Facts the reader can observe in the
  current code or spec (such as a still-existing deprecated API) may also be stated, since they are
  not writer-only context. Apply when writing Issues, PR descriptions, code comments, API docs,
  design docs, or any text in Markdown / Notion / docx that will be read later. DO NOT use for
  ephemeral chat replies, scratchpads, or working notes that will not be referenced again.
disable-model-invocation: false
allowed-tools: []
---

## Summary
Write any text that will persist on the assumption that the reader does not share your context. Keep the **rationale** (why the spec or design exists — business requirements, regulations, domain constraints, product decisions). Drop the **process** (the conversation log, review feedback, and discarded alternatives that produced this PR or design). This applies equally to Issues, PR descriptions, code comments, and design docs in Markdown / Notion / docx.

## Rationale
- **Rationale is verifiable by the reader** (referenceability): Business requirements, regulations, domain constraints, and product decisions are external events that persist. A reader who was not in the original conversation can still trace and verify them, so they have value as decision-making material
- **Process is reproducible only by participants** (referenceability): Phrases like "as pointed out in review" or "we originally went with X" rely on a timeline only the conversation participants can reconstruct. From the outside, *when* and *whose* discussion is undefined, and the text becomes noise as time passes
- **Observable facts are different** (time-closure): Anything still present in the current code, types, or schemas — for example a deprecated API that is still defined — is shared context. The reader can observe it, so describing it is current state, not past history
- **Reachable is not the same as in scope** (reference-scope closure): Even when a reference is something the reader genuinely can open — a class-level docstring, a config file, another section of the same document — sending them there to understand *this* sentence is still a defect if the information could have been stated where it is needed. Referenceability asks "can they check it"; scope asks "did they have to leave here to understand it." A reader forced to jump around to assemble one idea is doing the writer's integration work for them
- **Long-term value**: Persistent text may be read months or years later, when nobody on the original team remains

These three failure modes — time-closure, referenceability, reference-scope closure — are also the three conditions `review-self-contained-docs` checks mechanically when auditing a PR or a piece of text you just wrote.

## Guidance
1. **Keep the rationale**: Write down why the spec or design exists (business requirements, regulations, domain constraints, product decisions). This is decision-making material for the reader
2. **Drop the process**: Avoid phrasing like "review feedback led to", "the policy changed", or "originally we went with X" that depends on a timeline only participants of this PR or discussion can follow
3. **Be careful with contrastive phrasing**: "Not A but B", "A is deprecated", "A was removed" all assume the reader knows A. If they do not, describe B on its own
4. **Confine cross-issue references to short TODO/FIXME notes**: Phrases like "handled in another issue" or "to be addressed later" belong in `TODO(#123): ...` notes, not in prose, docstrings, or API descriptions
5. **If the process must be preserved, put it in the right place**: A PR description's "Background" section or an ADR. Keep it out of source code, user-facing docs, and API references
6. **Deprecation notes are fine when the implementation still exists**: Mark a parameter, endpoint, or function as deprecated when it is still part of the current shape that the reader can observe in code, types, or schemas. If the implementation is fully removed, the note has nothing to refer to and should be dropped
7. **Keep information where it is used, even if it is written elsewhere too**: If a reader has to leave the sentence they are on to open another section, file, or docstring to make sense of it, that information belongs at the point of use. Restate it briefly rather than pointing to it, even when the reference itself is completely valid and reachable — reachable is not the same as in scope
8. **Self-check: can it be read with no prior context?**: Imagine handing the document to someone with zero context. Look for proper nouns or premises that appear without introduction. To run this same check automatically — on a PR, or on text you just wrote — use `review-self-contained-docs` rather than relying only on your own read of it

## Common Rationalizations

The most common failure is not applying this skill at all, because the artifact in front of you did not feel like a "document." Close that off first, then the process-leak excuses:

| Rationalization | Reality |
|---|---|
| "This is a code comment / commit message / issue / Notion page — not really a 'document,' so this doesn't apply." | It applies. The target is **every artifact that persists**, wherever it lives — code comments, commit messages, PR and issue descriptions, API and design docs, and Notion / docx pages all count. This is the failure that recurs; check the artifact against this skill *before* writing it, not only when the thing is labelled "doc." |
| "Including the conversation history gives the reader helpful context." | The reader was never in the conversation, so the log is noise to them. Keep the *why* (rationale); drop the *how it came to be* (process). |
| "The review asked for this change, so I'll record that." | Review feedback is process. State the resulting decision, not that a review requested it. |
| "I'll list the alternatives we rejected so it's transparent." | Discarded options are writer-only context. Omit them unless the reader genuinely must know why not. |
| "This PR description can assume the reader saw the thread." | A persistent doc outlives the thread. Write it for someone opening it cold, months later. |
| "It's reachable, so pointing to it is fine." | Reachability is not the whole test. If the reader has to leave this comment or section to make sense of it, restate it here — a reference being valid does not mean the reference belongs at this position. |

## Examples

### Bad: Code comments dragging in the process behind the change
```typescript
// Validation used to be inline, but reviewers asked to extract it.
// The retry option is being discussed in another issue (#456) and is not implemented yet.
export function fetchUser(id: string): Promise<User> {
  validateUserId(id);
  return api.get(`/users/${id}`);
}
```

### Good: Drop the process
```typescript
export function fetchUser(id: string): Promise<User> {
  validateUserId(id);
  return api.get(`/users/${id}`);
}
```

### Bad: Mixing process into Issue body
```markdown
## What to do

Originally we were going to add a `bulk` flag to `POST /items`, but review feedback said
we should split it. So we're adding `POST /items/bulk` instead. The old `bulk` flag will
not be added.
```

### Good: State the final shape and the rationale
```markdown
## What to do

Add a new `POST /items/bulk` endpoint. The request body accepts `{ items: Item[] }` and persists items in array order.

## Background

Single creation (`POST /items`) and bulk creation have different responsibilities (different transaction boundaries, different partial-failure semantics, and different rate-limit units), so the endpoints are kept separate.
```

The `## Background` section captures the rationale (a domain-level difference in responsibilities) — verifiable by a reader who was never in the original review.

### Bad: Documenting a deprecation that no longer exists in the implementation
```markdown
## `createOrder(input)`

Creates an order. Previously this took a `currency` argument, but it has been deprecated.
The currency from account settings is used instead.
```

The `currency` argument has already been removed from the implementation; it cannot be observed in the current signature. The doc is describing an argument the reader has no way to encounter.

### Good (after removal): State the current spec and the rationale
```markdown
## `createOrder(input)`

Creates an order. The currency comes from the account settings (each account is locked to a single transaction currency by service design).
```

### Good (during transition): Keep the deprecation note while the implementation still accepts it
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

The `currency` argument is still present in the type definition, so the reader can observe it from their IDE or type checker. The deprecation note describes the current spec, not the process that produced it.

### Bad: Sending the reader elsewhere for information that belongs here
```typescript
export function validateDiscountCode(code: string): boolean {
  // Validation here follows the format rules described at the top of this file.
  return DISCOUNT_CODE_PATTERN.test(code);
}
```

The rule is reachable — it really is written at the top of the file — so this passes referenceability. It still fails reference-scope closure: a reader checking `validateDiscountCode` has to go open the file's header comment to find out what `DISCOUNT_CODE_PATTERN` is supposed to accept. Reachable was never the problem; being sent there was.

### Good: State it where it's used
```typescript
export function validateDiscountCode(code: string): boolean {
  // Discount codes: 5-8 uppercase alphanumeric characters, optional campaign-tag prefix.
  return DISCOUNT_CODE_PATTERN.test(code);
}
```

The rule now sits at its point of use. A reader no longer has to leave this function to know what the pattern is supposed to accept.
