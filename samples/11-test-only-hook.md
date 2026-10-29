# 11 · State the interface does not declare

**Pattern.** A module keeps state that none of its names mention. A test discovers it, because the
second test in a file sees what the first one left behind, and the module grows a hook so the test
can reset it. The hook is the visible symptom; the hidden state is the claim nobody made.

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
| the state | `src/retry.ts › attemptsSeen` | a claim the module makes, with no address in its interface |
| the hook | `src/retry.ts › __resetForTests` | **noise** to every production reader: it exists only so the test can manage the state |
| the test file | `src/retry.test.ts` | derived: it explains `withRetry` |

| From | To | Edge |
|---|---|---|
| `src/retry.ts › withRetry` | `src/retry.ts › attemptsSeen` | **hidden**: the signature says `withRetry` is a function of `fn`; the body says it is also a function of every earlier call |
| `src/retry.test.ts` | `src/retry.ts › __resetForTests` | visible, and the only reason the hook exists |

### What is wrong

The signature claims `withRetry` depends on `fn`. The body also depends on what happened before,
and nothing says so. The test is the first reader to find out, and the module pays with an export
that means nothing in production. Every later reader of `retry.ts` meets `__resetForTests` before
they meet the state it resets, and has to work backwards to the claim the signature left out.

## Good

**Good** `src/retry.ts`

```ts
export async function withRetry<T>(fn: () => Promise<T>): Promise<T> {
  for (let attempt = 1; ; attempt++) {
    // ... no module state
  }
}
```

**Good** `src/retry.test.ts`

```ts
import { withRetry } from "./retry";
```

### Why

Rule 3: a state the body uses is named. Here nothing needed the counter, so it goes, and the hook
with it, and the test no longer resets anything. Where state is the point, a cache or a connection,
it gets an address the signature shows: a parameter, or an object the caller and the test construct,
so the test resets it by making a new one rather than through a door the module cut for it.
