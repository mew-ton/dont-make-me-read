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
| its comment | `src/retry.ts › withRetry` (same address: a comment's address is its declaration) | derived: should say what the declaration cannot |

| From | To | Edge |
|---|---|---|
| the comment | the checkout page | **reversed**, diverging: the callee's explanation depends on a caller |
| the comment | the admin refund screen | **missing**: a caller that does not exist yet |

### What is wrong

The comment makes no claim about `withRetry`. A reader learns who calls it today and who might
tomorrow, which is what a search for the name would have told them, without the staleness. What it
does is already said by its name, its signature and its body.

## Good

**Good** `src/retry.ts`

```ts
export async function withRetry<T>(fn: () => Promise<T>): Promise<T> {
  // ...
}
```

### Why

Rule 5: a declaration does not depend on who uses it; callers are found by search. Rule 4: what the
declaration does is owned by its name, signature and body, so a comment that said it again would be
a second owner (case 16). With the callers gone nothing is left for the comment to carry, so it
goes. A comment that cites a decision the declaration reproduces is case 06, and nothing in this
case calls for one.
