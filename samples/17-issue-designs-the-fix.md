# 17 · An issue that designs the fix

**Pattern.** To hand the work to an agent, the issue spells out the implementation. Some of that
design is part of what solving the problem requires; some of it is one way of solving it. The two
look alike on the page. The second kind is what goes stale: the implementation takes its own shape,
and the issue is left claiming a design that nothing reproduces.

The test for each line is: is it derived from the problem? Would the problem be unsolved without
it? If so it is a requirement, however detailed, and it belongs. If not it is one shape the writer
imagined, and the choice is made where the code is written.

## Files: design the problem did not require

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
| the designed fix | `issues/231.md › Fix` | not derived from the problem: the problem is solved without any of it |
| the code | `src/retry.ts › withRetry` | reproduces "Retries are bounded" and the problem, not `› Fix` |
| the change | `pr/245.md` | derived from the problem |

| From | To | Edge |
|---|---|---|
| `issues/231.md › Fix` | the problem | **none**: no line of it is something the problem requires |
| `src/retry.ts › withRetry` | `issues/231.md › Fix` | **absent**: the code does not reproduce it, and says so only in a PR line the issue's reader never sees |
| `pr/245.md` | `issues/231.md` | visible ("Fixes #231"), and now asserts a reproduction of `› Fix` that did not happen |

## What is wrong

Ask of each line in `› Fix` whether the problem stays unsolved without it. A `RetryScheduler`
class: no, the page can stay responsive without one. Its file, its method, its default instance,
its test file: no. The macrotask hop is the one line close to a requirement, since yielding is
what keeps the page responsive, but it is stated as a mechanism, and the requirement it stands
for, "the page stays responsive while retries wait", is not stated at all. The section is one
shape the writer imagined, with less in hand than the implementer had, and when the implementer
found a smaller shape the section became a claim nobody reproduces. Six months later a search
for the scheduler finds the issue and not the code.

The detail was written so an agent could act without asking. It did, and produced something
better. What it needed was the problem, what solving it requires, and the walls.

## Files: design the problem requires

Replacing a hand-rolled implementation with a standard one is a problem whose solution has to say
where compatibility breaks and how it is kept. That design is a requirement, and it belongs in the
issue, with its owners named where they exist.

`issues/248.md`

```md
# Replace the hand-rolled retry with `p-retry`

`withRetry` in `src/retry.ts` reimplements what `p-retry` provides. Replace it.

Done when every line below holds.

- `withRetry(fn, limit?)` keeps its signature; its callers, `src/checkout.ts › pay` and
  `src/refund.ts › refund`, are not touched.
- When every attempt fails, the error thrown is the last attempt's error, as the test "throws
  the last error once the configured limit is reached" in `src/retry.test.ts` pins.
- Backoff timing is whatever `p-retry` defines for `factor` and `minTimeout`; our `baseDelayMs`
  maps to `minTimeout`.
- Where compatibility breaks: `p-retry` retries on any error, and ours stops on `AbortError`
  ("Checkout owns the user-facing outcome", `docs/architecture.md`). It is kept by a wrapper that
  keeps the signature above and converts `AbortError` into `p-retry`'s own abort, so the caller
  sees the same stop. The wrapper is the interface; its internals are the implementer's.
- The bound on attempts stays ("Retries are bounded", `docs/architecture.md`).
```

## Graph

| Node | Address | Source or derived |
|---|---|---|
| the problem | `issues/248.md` (title and first paragraph) | source for the change |
| the done condition | `issues/248.md` (the list) | derived from the problem: each line is something "replaced" cannot mean without |
| the wrapper | `issues/248.md › fourth line` | a design decision, required by the problem, given its address here |
| the signature, the last-error rule, the abort rule, the bound | their owners, named in each line | sources the condition cites |

| From | To | Edge |
|---|---|---|
| each line of the condition | the problem | visible: "replaced" is not met if the line fails |
| the lines that cite a caller, a test, a decision | those owners | visible, by address |
| the code, when written | `issues/248.md › fourth line` | will be visible: the wrapper now has an address to cite |

The issue is longer than 231's and nothing in it is one way among several: drop any line and the
replacement is not a replacement. The wrapper is new, so no earlier paragraph owns it; the issue
is where it gets its address, and the code will cite it. What the issue does not say is how the
wrapper is built, because the problem does not care.

## What the rule says

Rule 5: a paragraph depends on what it explains, and an issue explains a problem, so each of its
lines is derived from the problem or is not the issue's. That decides how much design an issue
holds: as much as solving the problem requires, and no line of what merely solves it one way. The
*What noise does* table in `references/prose.md` names the second kind: the implementation method
in an issue, from which the reader concludes the shape you saw while writing is the shape today.
Where a required design is new, the issue is its address, and the code cites it; where a shape has
to be fixed for reasons outside the problem, it is a decision with an address of its own, so a
divergence is a defect between two addressed paragraphs, as in case 09.

Issue 231, cut to what the problem requires:

```md
# Checkout hangs when the payment provider is slow

Paying with the test card ending 0002 freezes the page for about ten seconds (QA report 142).

Done when: the page stays responsive while `withRetry` waits between attempts, and the bound on
retries is unchanged ("Retries are bounded", `docs/architecture.md`: the provider bills per
attempt).
```
