# 06 · A decision that names its implementation

**Pattern.** The source lists what reproduces it, and the reproduction does not cite the source.
Both edges point the wrong way.

## Bad

**Bad** `docs/architecture.md`

```md
## Retries are bounded

A payment call is retried a fixed number of times and then the order fails. The bound exists
because the provider bills per attempt, and an unbounded retry once produced a four-figure invoice
for one stuck order. The bound is implemented in `src/retry.ts` by `withRetry`, and configured
through `config/retry.json`.
```

**Bad** `src/retry.ts`

```ts
export async function withRetry<T>(fn: () => Promise<T>): Promise<T> {
  const limit = config.maxRetries;
  // ...
}
```

### Graph

| Node | Address | Source or derived |
|---|---|---|
| the decision | `docs/architecture.md › Retries are bounded` | source |
| the implementation | `src/retry.ts › withRetry` | derived: it reproduces the decision |

| From | To | Edge |
|---|---|---|
| `docs/architecture.md › Retries are bounded` | `src/retry.ts › withRetry` | **reversed**: a source naming its reproduction; goes stale on the next rename |
| `src/retry.ts › withRetry` | `docs/architecture.md › Retries are bounded` | **missing**: the code does not say what it reproduces |

### What is wrong

Rename `withRetry` and the decision is wrong. Add a second place that bounds retries and the
decision is incomplete. Meanwhile a reader of the code has no way to learn that the bound is about
billing, so the next person to "simplify" it removes the bound.

## Good

**Good** `docs/architecture.md`

```md
## Retries are bounded

A payment call is retried a fixed number of times and then the order fails. The bound exists
because the provider bills per attempt, and an unbounded retry once produced a four-figure invoice
for one stuck order.
```

**Good** `src/retry.ts`

```ts
/** Reproduces "Retries are bounded" (docs/architecture.md): the provider bills per attempt. */
export async function withRetry<T>(fn: () => Promise<T>): Promise<T> {
  const limit = config.maxRetries;
  // ...
}
```

### Why

Rule 5: the reproduction cites the source, in the source's words; the source does not list its
reproductions. The reverse direction is a search for the decision's words, which the code carries.
