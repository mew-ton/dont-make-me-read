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

The body is the claim, and the name summarises it. A comment that tells the claim again adds a
third telling that drifts the first time someone changes the backoff and forgets the comment.

The declaration reproduces a decision, "Retries are bounded" in `docs/architecture.md`, and
nothing on it names that decision. The comment had room for it and spent it on a paraphrase.

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

The two findings are fixed apart, and each fix holds without the other.

Rule 4: a claim that has an owner is cited, not restated, and what the declaration does is owned by
its name, signature and body. The *Duplicate* section of the skill `dont-make-me-read--judge` lists
such a comment as a duplicate: a second owner of the same claim. The paraphrase goes, as the
*What to do instead* table in the skill `dont-make-me-read` says for a duplicate: "the owner's copy
stays, the other cites it or goes".

Rule 3: the edge to the decision is missing, and the doc comment in the Good names the decision by
its heading and file, with the reason the body cannot show. The same *Duplicate* section counts
such a comment as no duplicate: "Not a duplicate, because it holds what the body cannot show".

Had the declaration reproduced no decision, and held nothing else the body cannot show, the Good
would carry no comment at all.
