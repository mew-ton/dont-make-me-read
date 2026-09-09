# Worked examples

The examples below are in English because this skill is. Write the artifact in the language its
own readers already use.

Read this when you want the contrast for a case you are looking at: a code comment, an issue
body, or a deprecation note. `SKILL.md` carries the rule; this holds the Bad/Good pairs.

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
