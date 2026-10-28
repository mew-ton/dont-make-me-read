# orderly

A small service that places orders and retries the payment call when the provider is slow.

## Retries

Payment calls are retried up to five times before the order is marked failed. The wait between
tries doubles each time.

## Running it

Set the environment as described in the section below, then run `npm start`.

## Environment

`PAYMENT_URL` must point at the provider. `RETRY_LIMIT` overrides the default.
