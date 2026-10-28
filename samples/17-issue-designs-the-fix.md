# 17 · An issue that designs the fix

**Pattern.** To hand the work to an agent, the issue spells out the implementation. Some of that
detail is a wall, derived from things that exist and will not move; some of it is a sketch, derived
from nothing but the writer's guess at a shape. The two look alike on the page. The sketch is what
goes stale: the implementation takes its own shape, and the issue is left claiming a design that
nothing reproduces.

The test for each line is: what is this derived from? A line with an owner is cited and kept. A
line with no owner is a choice, and a choice is made where the code is written or is given an
address of its own first.

## Files: the sketch

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
| the designed fix | `issues/231.md › Fix` | written as a source for the code; derived from nothing that exists |
| the code | `src/retry.ts › withRetry` | reproduces "Retries are bounded" and the problem, not `› Fix` |
| the change | `pr/245.md` | derived from the problem |

| From | To | Edge |
|---|---|---|
| `issues/231.md › Fix` | anything | **none**: no line of it can be cited from an existing paragraph |
| `src/retry.ts › withRetry` | `issues/231.md › Fix` | **absent**: the code does not reproduce it, and says so only in a PR line the issue's reader never sees |
| `pr/245.md` | `issues/231.md` | visible ("Fixes #231"), and now asserts a reproduction of `› Fix` that did not happen |

## What is wrong

Ask of each line in `› Fix` what it is derived from. `RetryScheduler`: nothing; no caller needs a
scheduler, no decision names one. `src/retry/scheduler.ts`: nothing. `schedule(fn, attempt)`:
nothing. The macrotask hop: this one has an owner, the observation, since the hop is what keeps
the page responsive, but it is stated as a mechanism rather than as the condition the observation
sets. Nothing in the section is a wall. All of it is one shape the writer imagined, written with
less in hand than the implementer had, and when the implementer found a smaller shape the section
became a claim nobody reproduces. Six months later a search for the scheduler finds the issue and
not the code.

The detail was written so an agent could act without asking. It did, and produced something
better. What it needed was the problem, the condition for being done, and the walls.

## Files: the wall

The same amount of detail, derived from things that exist, is the done condition and belongs.

`issues/248.md`

```md
# Replace the hand-rolled retry with `p-retry`

`withRetry` in `src/retry.ts` reimplements what `p-retry` provides. Replace it.

Done when every line below holds. Each names what it is derived from.

- `withRetry(fn, limit?)` keeps its signature. Owner: its callers, `src/checkout.ts › pay` and
  `src/refund.ts › refund`, which this change does not touch.
- When every attempt fails, the error thrown is the last attempt's error. Owner: the test
  "throws the last error once the configured limit is reached" in `src/retry.test.ts`, which
  stays green unchanged.
- Backoff timing is whatever `p-retry` defines for its `factor` and `minTimeout` options; our
  `baseDelayMs` maps to `minTimeout`. Owner: `p-retry`'s README, section "Options".
- An attempt that throws `AbortError` stops retrying. `p-retry` retries on any error, so the
  wrapper has to map it. Owner: "Checkout owns the user-facing outcome" in
  `docs/architecture.md`, which is what the abort exists for; pinned by the test
  "stops at once on AbortError".
- The bound on attempts stays. Owner: "Retries are bounded", `docs/architecture.md`.

How the wrapper is written, and whether `withRetry` stays a function or becomes a thin module, is
the implementer's.
```

## Graph

| Node | Address | Source or derived |
|---|---|---|
| the done condition | `issues/248.md` | derived: every line cites its owner |
| the signature | `src/checkout.ts › pay`, `src/refund.ts › refund` | sources: the callers own it |
| the last-error rule | `src/retry.test.ts › "throws the last error…"` | source |
| the timing | `p-retry` README › Options | source, outside the tree |
| the abort rule | `docs/architecture.md › Checkout owns the user-facing outcome` | source |
| the bound | `docs/architecture.md › Retries are bounded` | source |

| From | To | Edge |
|---|---|---|
| each line of `issues/248.md` | its owner | visible, by address |
| the code, when written | the same owners | will be visible: the issue has already named them |

The issue is longer than 231's and nothing in it can go stale on its own, because nothing in it is
its own. When a caller changes, the first line is wrong, and the line says where to look.

## What the rule says

Rule 5: a paragraph depends on what it explains or reproduces, and says which it is. Rule 4: a
claim with an owner is cited. The done condition of an issue may be as detailed as its owners
make it. A line with no owner is a sketch: the *What noise does* table in `references/prose.md`
calls it the implementation method in an issue, and the reader concludes the shape you saw while
writing is the shape today. If a shape has to be fixed before the code is written, it is a decision
with its own address that the code will cite, so a divergence is a defect between two addressed
paragraphs, as in case 09, and not a stale wish in a closed issue.

Issue 231, cut to what it owns and what it can cite:

```md
# Checkout hangs when the payment provider is slow

Paying with the test card ending 0002 freezes the page for about ten seconds (QA report 142).

Done when: the page stays responsive while `withRetry` waits between attempts, and the bound on
retries is unchanged ("Retries are bounded", `docs/architecture.md`: the provider bills per
attempt).
```
