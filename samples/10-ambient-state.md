# 10 · A precedence stated nowhere

**Pattern.** A value comes from either of two places, and one wins. That is a reasonable design:
an environment variable over a config file is how a deployment overrides a build. What is wrong is
that the rule deciding which wins has no address. It lives inside a function body, and nothing a
reader of the config, the README or the function's signature can see says it exists.

## Bad

**Bad** `config/retry.json`

```json
{ "maxAttempts": 3 }
```

**Bad** `src/retry.ts`

```ts
import config from "../config/retry.json";

export async function withRetry<T>(fn: () => Promise<T>): Promise<T> {
  const limit = Number(process.env.RETRY_LIMIT ?? config.maxAttempts);
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
| the default limit | `config/retry.json › maxAttempts` | source |
| the override | `RETRY_LIMIT` | source, set per deployment |
| the precedence, "the variable wins" | none: a line inside `withRetry`'s body | a claim with no address |
| the implementation | `src/retry.ts › withRetry` | derived |
| the README's line | `README.md` | derived |

| From | To | Edge |
|---|---|---|
| `src/retry.ts › withRetry` | `RETRY_LIMIT` | **hidden**: read from the environment, not in the signature |
| `README.md` | `config/retry.json` | **missing**: "the default" names the owner by role |
| anything | the precedence | **impossible**: it has no address to cite |

### What is wrong

A reader of `withRetry`'s signature cannot tell that the limit can come from outside. A reader of
the config cannot tell that it can be overridden. A reader of the README cannot tell what the
default is or where it lives. The rule that ties the three together is real and useful, and it is
the one thing none of them can point at.

## Good

**Good** `config/retry.ts`

```ts
import defaultConfig from "./retry.json";

/** The retry settings. `RETRY_LIMIT` in the environment overrides `maxAttempts` in retry.json,
 *  so a deployment can set it without a rebuild. */
export const retry = {
  maxAttempts: Number(process.env.RETRY_LIMIT ?? defaultConfig.maxAttempts),
  baseDelayMs: defaultConfig.baseDelayMs,
};
```

**Good** `src/retry.ts`

```ts
import { retry } from "../config/retry";

export async function withRetry<T>(fn: () => Promise<T>, limit = retry.maxAttempts): Promise<T> {
  // ...
}
```

**Good** `README.md`

```md
`RETRY_LIMIT` overrides `maxAttempts` in `config/retry.json`; the precedence is stated in
`config/retry.ts`.
```

### Why

Rule 6: a claim has one place. The precedence now has an address, `config/retry.ts › retry`, and
the README and the function both reach it. Rule 3: the body names its input as a parameter instead
of reading the environment itself. The override is kept; only its rule moved to where it can be
cited.
