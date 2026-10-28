# 10 · A limit set in two places

**Pattern.** A body reads state it does not name in its signature, and that state is a second place
the same claim is set.

## Bad

**Bad** `config/retry.json`

```json
{ "maxRetries": 3 }
```

**Bad** `src/retry.ts`

```ts
import config from "../config/retry.json";

export async function withRetry<T>(fn: () => Promise<T>): Promise<T> {
  const limit = Number(process.env.RETRY_LIMIT ?? config.maxRetries);
  // ...
}
```

**Bad** `README.md`

```md
`RETRY_LIMIT` overrides the default.
```

### Graph

| Node | Address | Source or derived |
|---|---|---|
| the retry limit | `config/retry.json › maxRetries` | source |
| the environment variable | `RETRY_LIMIT` | a second source for the same claim |
| the implementation | `src/retry.ts › withRetry` | derived |

| From | To | Edge |
|---|---|---|
| `src/retry.ts › withRetry` | `config/retry.json` | visible, by import: correct |
| `src/retry.ts › withRetry` | `RETRY_LIMIT` | **hidden**: read from the environment, not in the signature |
| `README.md` | `config/retry.json` | **missing**: "the default" names the owner by role |

### What is wrong

A reader of `withRetry` cannot tell from its signature that the limit can come from outside. A
reader of the config cannot tell that it can be overridden. A reader of the README cannot tell what
the default is or where it lives. Three paragraphs, one claim, and no two of them agree on where it
is set.

## Good

Only the part that holds whichever way the second question goes.

**Good** `src/retry.ts`

```ts
import config from "../config/retry.json";

export async function withRetry<T>(fn: () => Promise<T>, limit = config.maxRetries): Promise<T> {
  // ...
}
```

### Why

Rule 3: a state the body uses is named, as a parameter; where the limit comes from is then the
caller's, and the body no longer reads the environment. Rule 6: a claim has one place. Whether
the override survives is a decision this case does not make: either it exists and the config is
the one place that says so, with the README citing that, or it does not exist and the README and
the variable go. The corrected README depends on that decision, so it is not shown.
