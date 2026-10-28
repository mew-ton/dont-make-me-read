# 12 · Setup that runs by position

**Pattern.** A test's body leans on a block that runs before it by convention, not by being named.
The claim cannot be read from the test alone.

## Bad

**Bad** `src/retry.test.ts`

```ts
let calls: number;
let failing: () => Promise<never>;

beforeEach(() => {
  calls = 0;
  failing = async () => {
    calls++;
    throw new Error("declined");
  };
});

it("stops after the configured number of attempts", async () => {
  await expect(withRetry(failing)).rejects.toThrow("declined");
  expect(calls).toBe(3);
});
```

### Graph

| Node | Address | Source or derived |
|---|---|---|
| the claim | `src/retry.test.ts › "stops after the configured number of attempts"` | derived: explains `withRetry` |
| the setup | `src/retry.test.ts › beforeEach` | no address: it has no name |

| From | To | Edge |
|---|---|---|
| the test body | `beforeEach` | **hidden**: `calls` and `failing` arrive by position |

### What is wrong

The body says `failing` and `calls` and defines neither. A reader who landed on the test by its name
has to scroll up to learn what `failing` does, and to learn that `calls` was zero. The claim's
reproduction is split across two places and only one of them has an address.

## Good

**Good** `src/retry.test.ts`

```ts
it("stops after the configured number of attempts", async () => {
  const fn = countingFailure("declined");
  await expect(withRetry(fn)).rejects.toThrow("declined");
  expect(fn.calls).toBe(3);
});
```

### Why

Rule 3: a state the body uses is named. The *Direction* section of `references/program.md` shows the
shape: the body names what it leans on. `countingFailure` is a named helper, so the edge to it is
visible and the reader can follow it or not.
