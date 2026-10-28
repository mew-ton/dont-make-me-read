# 11 · A hook only tests use

**Pattern.** Production code exports something that exists so a test can reach in. The subject now
depends on what explains it.

## Bad

**Bad** `src/retry.ts`

```ts
let attemptsSeen = 0;

export async function withRetry<T>(fn: () => Promise<T>): Promise<T> {
  // ... attemptsSeen++ on every try
}

export function __resetForTests() {
  attemptsSeen = 0;
}
```

**Bad** `src/retry.test.ts`

```ts
import { withRetry, __resetForTests } from "./retry";

beforeEach(() => __resetForTests());
```

### Graph

| Node | Address | Source or derived |
|---|---|---|
| the subject | `src/retry.ts › withRetry` | source for its tests |
| the hook | `src/retry.ts › __resetForTests` | exists for the test |
| the test file | `src/retry.test.ts` | derived: it explains `withRetry` |

| From | To | Edge |
|---|---|---|
| `src/retry.test.ts` | `src/retry.ts › withRetry` | visible, by import: correct |
| `src/retry.ts › __resetForTests` | `src/retry.test.ts` | **reversed**: the subject holds a paragraph whose only reader is its test |

### What is wrong

`attemptsSeen` is module state, which is why the test needs to reset it, which is why the hook
exists. The hook is the symptom; the hidden state is the claim the module makes without saying so.
Every reader of `retry.ts` pays for a declaration that means nothing in production.

## Good

**Good** `src/retry.ts`

```ts
export async function withRetry<T>(fn: () => Promise<T>): Promise<T> {
  for (let attempt = 1; ; attempt++) {
    // ... no module state
  }
}
```

### Why

Rule 5: the subject never depends on the test. Remove the state the test had to reset, and the hook
has nothing to do.
