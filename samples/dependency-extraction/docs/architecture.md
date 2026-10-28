# Architecture

## Retries are bounded

A payment call is retried a fixed number of times and then the order fails. The bound exists
because the provider bills per attempt, and an unbounded retry once produced a four-figure invoice
for one stuck order. The bound is implemented in `src/retry.ts` by `withRetry`, and configured
through `config/retry.json`.

## Checkout owns the user-facing outcome

Whether a failed payment is shown as "try again" or "contact support" is decided in checkout, not
in the retry layer. The retry layer reports what happened; checkout decides what to say.
