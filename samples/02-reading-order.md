# 02 · "See the section below"

**Pattern.** A paragraph leans on another by position. The reader who arrives at it from the top
has what it needs; the reader who lands on it by search does not.

## Files

`README.md`

```md
## Running it

Set the environment as described in the section below, then run `npm start`.

## Environment

`PAYMENT_URL` must point at the provider. `RETRY_LIMIT` overrides the default.
```

## Graph

| Node | Address | Source or derived |
|---|---|---|
| how to run the service | `README.md › Running it` | derived |
| what the environment must hold | `README.md › Environment` | derived |

| From | To | Edge |
|---|---|---|
| `README.md › Running it` | `README.md › Environment` | **hidden**: "the section below" is a position, not an address |

## What is wrong

An agent that searched for "npm start" landed on *Running it* and has no "below". The edge exists
in the writer's head and in the human reader's scroll position, and nowhere a tool can follow.

## What the rule says

Rule 3: a dependency is named by address. The heading is the address.

```md
## Running it

Set the variables listed under [Environment](#environment), then run `npm start`.
```
