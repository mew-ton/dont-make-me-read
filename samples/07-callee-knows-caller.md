# 07 · A callee that knows its caller

**Pattern.** A declaration takes a parameter that names who is calling it. The lower layer now
depends on the upper one, and every new caller edits the callee.

## Bad

**Bad** `src/retry.ts`

```ts
export async function withRetry<T>(fn: () => Promise<T>, fromCheckout: boolean): Promise<T> {
  // ...
  if (attempt >= limit) {
    throw fromCheckout ? new Error("contact support") : err;
  }
  // ...
}
```

**Bad** `src/checkout.ts`

```ts
await withRetry(() => charge(orderId, amount), true);
```

### Graph

| Node | Address | Source or derived |
|---|---|---|
| the retry layer | `src/retry.ts › withRetry` | source for its callers |
| checkout | `src/checkout.ts › pay` | derived: it depends on `withRetry` |

| From | To | Edge |
|---|---|---|
| `src/checkout.ts › pay` | `src/retry.ts › withRetry` | visible, by import: correct |
| `src/retry.ts › withRetry` | `src/checkout.ts › pay` | **reversed**, diverging: `fromCheckout` is checkout's knowledge inside the callee |

### What is wrong

The callee cannot be read without knowing what checkout is. The next caller adds `fromAdmin`, and
the one after that adds a third flag, and the callee becomes a switch over its callers. The
user-facing message, which belongs to checkout, has moved into the retry layer.

## Good

**Good** `src/retry.ts`

```ts
export async function withRetry<T>(fn: () => Promise<T>): Promise<T> {
  // ...
}
```

**Good** `src/checkout.ts`

```ts
try {
  await withRetry(() => charge(orderId, amount));
  return "paid";
} catch {
  return "contact-support";
}
```

### Why

Rule 5, and the *Saying which you are* section of `references/program.md`: a declaration never
names what calls it. What the body would need to know about the caller crosses as a value the body
does not interpret, or, as here, stays with the caller.
