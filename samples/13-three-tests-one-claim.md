# 13 · Three tests, one claim

**Pattern.** Three names, one assertion. Two of the names are copies of the third, and one of them
is not a claim at all.

## Bad

**Bad** `src/retry.test.ts`

```ts
it("works correctly", async () => {
  await expect(withRetry(failing)).rejects.toThrow();
  expect(calls).toBe(3);
});

it("stops after the configured number of attempts", async () => {
  await expect(withRetry(failing)).rejects.toThrow("declined");
  expect(calls).toBe(3);
});

it("gives up after three tries", async () => {
  await expect(withRetry(failing)).rejects.toThrow();
  expect(calls).toBe(3);
});
```

### Graph

| Node | Address | Source or derived |
|---|---|---|
| `"works correctly"` | that string | **noise**: the name says nothing that could be false |
| `"stops after the configured number of attempts"` | that string | derived: explains `withRetry` |
| `"gives up after three tries"` | that string | **duplicate** of the one above |

| From | To | Edge |
|---|---|---|
| each test | `src/retry.ts › withRetry` | visible, by import: correct |
| `"gives up after three tries"` | `config/retry.json › maxAttempts` | **missing**: restates the value `3`, so the name goes stale when the config changes |

### What is wrong

A reader scanning the test names learns one fact three times and one of the three tellings is
empty. When the limit becomes four, one name is wrong, one is right, and one still says "correctly".

## Good

**Good** `src/retry.test.ts`

```ts
it("throws the last error once the limit is reached", async () => {
  const fn = countingFailure("declined");
  await expect(withRetry(fn, 3)).rejects.toThrow("declined");
  expect(fn.calls).toBe(3);
});
```

### Why

Rule 2: a test's name summarises its body, and a name that could not be false changes nothing the
reader does. Rule 6: a claim has one place; the other two go. The `3` is now passed in, so the test
owns it.
