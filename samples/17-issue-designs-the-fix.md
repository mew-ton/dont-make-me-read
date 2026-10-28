# 17 · An issue that designs the fix

**Pattern.** To hand the work to an agent, the issue spells out the implementation. The
implementation then takes a different shape, as implementations do, and the issue is left claiming
a design that nothing reproduces. Every later reader of the issue inherits the wrong picture.

## Files

`issues/231.md`

```md
# Checkout hangs when the payment provider is slow

Paying with the test card ending 0002 freezes the page for about ten seconds (QA report 142).

## Fix

Add a `RetryScheduler` class in `src/retry/scheduler.ts` with a `schedule(fn, attempt)` method
that posts each attempt to a `setTimeout(0)` macrotask. Change `withRetry` to take a scheduler
as its second argument, defaulting to a module-level `defaultScheduler`. Add
`src/retry/scheduler.test.ts` covering the macrotask hop. Update `checkout.ts` to pass
`defaultScheduler` explicitly.
```

`src/retry.ts`, as merged

```ts
/** Reproduces "Retries are bounded" (docs/architecture.md). Yields to the event loop before
 *  each wait so a slow provider never blocks rendering. */
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

`pr/245.md`

```md
Fixes #231. No scheduler class: a one-line `yieldThen` was enough.
```

## Graph

| Node | Address | Source or derived |
|---|---|---|
| the observation | `docs/qa-report-142.md` | source |
| the problem | `issues/231.md` (title and first paragraph) | derived from the observation: correct |
| the designed fix | `issues/231.md › Fix` | written as a source for the code, which nothing reproduces |
| the code | `src/retry.ts › withRetry` | reproduces "Retries are bounded" and the problem, not `› Fix` |
| the change | `pr/245.md` | derived from the problem |

| From | To | Edge |
|---|---|---|
| `src/retry.ts › withRetry` | `issues/231.md › Fix` | **absent**: the code does not reproduce it, and says so nowhere the issue's reader looks |
| `pr/245.md` | `issues/231.md` | visible ("Fixes #231"), but it now asserts a reproduction of `› Fix` that did not happen |

## What is wrong

The issue owns the problem and the condition for being done. It does not own the shape of the
code; the code does. A paragraph that describes `RetryScheduler`, its file, its method and its
test is a claim about a reproduction that had not been written yet, and the one who wrote it had
less in hand than the one who implemented it. When the implementation diverged, the only place
that said so was a PR comment the issue's reader never sees. Six months later, someone searching
for the scheduler finds the issue, and not the code.

The detail was written so an agent could act without asking. It did act without asking, and
produced something better. What the agent needed was the problem, the done condition and the
walls, which is what an issue holds for a person too.

## What the rule says

Rule 5: a paragraph depends on what it explains or reproduces and says which it is. The issue
explains the problem. Rule 2 and the *What noise does* table in `references/prose.md`: the
implementation method in an issue makes the reader conclude the shape you saw while writing is the
shape today. If a design has to be written before the code, it is a decision with its own address
that the code will cite, so a divergence is a defect between two addressed paragraphs, as in case
09, and not a stale wish in a closed issue.

```md
# Checkout hangs when the payment provider is slow

Paying with the test card ending 0002 freezes the page for about ten seconds (QA report 142).

Done when: the page stays responsive while `withRetry` waits between attempts, and the bound on
retries is unchanged ("Retries are bounded", `docs/architecture.md`: the provider bills per
attempt).
```
