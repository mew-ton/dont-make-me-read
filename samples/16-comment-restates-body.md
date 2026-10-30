# 16 · A comment that restates the body

**Pattern.** The comment says what the body does, in other words. The claim now has two owners,
and the one nothing checks is the one readers read first.

## Bad

**Bad** `src/retry.ts`

```ts
// Retries the given function until it succeeds or the limit is reached,
// waiting longer between each try.
export async function withRetry<T>(fn: () => Promise<T>): Promise<T> {
  let delay = config.baseDelayMs;
  for (let attempt = 1; ; attempt++) {
    try {
      return await fn();
    } catch (err) {
      if (attempt >= config.maxAttempts) throw err;
      await new Promise((r) => setTimeout(r, delay));
      delay *= 2;
    }
  }
}
```

### Graph

| Node | Address | Source or derived |
|---|---|---|
| the declaration | `src/retry.ts › withRetry` | source for its callers; derived from the decision it reproduces |
| the comment | the same address | **duplicate**: a second telling of the body's claim |

| From | To | Edge |
|---|---|---|
| the declaration | the decision it reproduces | **missing**: the comment had room for it and spent it on a paraphrase |

### What is wrong

The body is the reproduction; the name is the claim. A comment that tells the claim again adds a
third telling that drifts the first time someone changes the backoff and forgets the comment. What
the comment could have carried, and the body cannot, is *why*: the decision this reproduces.

## Good

**Good** `src/retry.ts`

```ts
/** Reproduces "Retries are bounded" (docs/architecture.md): the provider bills per attempt. */
export async function withRetry<T>(fn: () => Promise<T>): Promise<T> {
  let delay = config.baseDelayMs;
  for (let attempt = 1; ; attempt++) {
    try {
      return await fn();
    } catch (err) {
      if (attempt >= config.maxAttempts) throw err;
      await new Promise((r) => setTimeout(r, delay));
      delay *= 2;
    }
  }
}
```

### Why

Rule 4: a claim that has an owner is cited, not restated, and what the declaration does is owned
by its name, signature and body. The *Duplicate* section of `references/glossary.md` lists such a
comment as a duplicate: a second owner of the same claim. A comment on a declaration cites
what the declaration reproduces, and says nothing the body already says.
