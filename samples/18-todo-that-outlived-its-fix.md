# 18 · A TODO that outlived its fix

**Pattern.** A comment records what is wrong with the body and which issue tracks it. The body is
fixed; the comment is not. The comment is a derived explanation of the body that nobody re-derived.

## Files

`src/retry.ts`

```ts
// FIXME(#231): this blocks the rendering thread while it waits; see the issue for the plan.
export async function withRetry<T>(fn: () => Promise<T>, limit = config.maxRetries): Promise<T> {
  for (let attempt = 1; ; attempt++) {
    try {
      return await fn();
    } catch (err) {
      if (attempt >= limit) throw err;
      await yieldThen(backoff(attempt));
    }
  }
}
```

`https://github.com/example/orderly/issues/231`

```md
# Checkout hangs when the payment provider is slow   · closed, fixed by #245
```

## Graph

| Node | Address | Source or derived |
|---|---|---|
| the body | `src/retry.ts › withRetry` | source for its comment |
| the comment | the same address | derived: it explains the body, and no longer describes it |
| the issue | `https://github.com/example/orderly/issues/231` | closed |

| From | To | Edge |
|---|---|---|
| the comment | the body | **stale**: it claims a defect the body no longer has |
| the comment | `https://github.com/example/orderly/issues/231` | visible, by number, and therefore checkable: the issue is closed |

## What is wrong

A reader lands on `withRetry` and the first line tells them it blocks rendering. They either trust
it and avoid the function, or distrust it and now distrust every other comment in the file. The
body changed in a PR that cited the issue; the comment was two lines above the diff and nobody
re-read it, because a comment that describes the body has to be remembered, and rules that have to
be remembered are broken.

## What the rule says

Rule 4: the issue owns what is wrong and whether it still is; a comment that restates it is a second
owner, and the one that goes stale. A comment earns its place only when the reader of the body
needs something the body cannot say: a workaround that must come out, with the condition for taking
it out stated so a script can check it. Since the number is a visible edge, "a `TODO(#n)` whose
issue is closed" is a check, not a review.

Here the comment has nothing to carry once the fix is in, so it goes:

```ts
/** Reproduces "Retries are bounded" (docs/architecture.md). Yields to the event loop before
 *  each wait so a slow provider never blocks rendering. */
export async function withRetry<T>(fn: () => Promise<T>, limit = config.maxRetries): Promise<T> {
```

A comment that does have something to carry names the condition for its own removal:

```ts
// Remove with #231: holds the Pay button in its loading state until the provider's
// timeout lands, because the fix for the hang is not in yet.
```
