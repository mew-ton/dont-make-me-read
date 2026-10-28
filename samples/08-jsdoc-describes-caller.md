# 08 · A doc comment that describes the caller

**Pattern.** A declaration's comment explains where it is used instead of what it claims. The
comment is a reversed edge in prose form, and it goes stale with the first new caller.

## Bad

**Bad** `src/retry.ts`

```ts
/**
 * Used by the checkout page to keep the Pay button in its loading state while the
 * payment provider is retried. The admin refund screen will use this too once it ships.
 */
export async function withRetry<T>(fn: () => Promise<T>): Promise<T> {
  // ...
}
```

### Graph

| Node | Address | Source or derived |
|---|---|---|
| the declaration | `src/retry.ts › withRetry` | source for its callers |
| its comment | `src/retry.ts › withRetry` (same address: a comment's address is its declaration) | should explain the declaration |

| From | To | Edge |
|---|---|---|
| the comment | the checkout page | **reversed**: the callee's explanation depends on a caller |
| the comment | the admin refund screen | **dangling**: a caller that does not exist yet |

### What is wrong

The comment makes no claim about `withRetry`. It says nothing about the bound, the backoff, or
what is thrown. A reader learns who calls it today and who might tomorrow, which is what a search
for the name would have told them, without the staleness.

## Good

**Good** `src/retry.ts`

```ts
/**
 * Calls `fn` up to the configured limit, waiting twice as long before each try, and throws the
 * last error when the limit is hit.
 */
export async function withRetry<T>(fn: () => Promise<T>): Promise<T> {
  // ...
}
```

### Why

Rule 1: one claim under the address, and the comment is part of the paragraph under the name, so
it says what the declaration claims. Rule 5: not who uses it; callers are found by search. Whether
the comment should also cite a decision the declaration reproduces is case 06, and nothing in this
case calls for one.
