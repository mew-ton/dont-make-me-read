# 20 · An account of the change, left in the file

**Pattern.** A file that is read for what it says now tells what a change did to it: what was
removed, where it moved, what no longer holds. It leans on the diff, which its reader does not have.

## Bad

**Bad** `docs/operations.md`

```md
## Retries

A payment call is tried at most `maxAttempts` times (`config/retry.json`). The table of
per-provider limits that was here moved to #312, and the 30-second timeout no longer applies.
```

**Bad** `src/cache.test.ts`

```ts
import * as cache from "./cache";

it("no longer exports resetCache", () => {
  expect("resetCache" in cache).toBe(false);
});
```

### Graph

| Node | Address | Source or derived |
|---|---|---|
| the retry limit | `docs/operations.md › Retries` | derived from `config/retry.json` |
| the account of the change | the same address | derived from the diff that removed the table and the timeout |
| the test | `src/cache.test.ts › no longer exports resetCache` | derived from the diff that removed `resetCache` |

| From | To | Edge |
|---|---|---|
| the retry limit | `config/retry.json` | visible |
| the account of the change | the diff that removed the table and the timeout | **missing**: "was here", "moved to" and "no longer" name a diff by nothing its reader can open |
| the test | the diff that removed `resetCache` | **missing**: the reason it must stay gone was given in that change, and nothing names it |

`docs/operations.md › Retries` holds both the retry limit and the account of the change: **two
claims** in one paragraph.

### What is wrong

A reader opens `docs/operations.md` to find how retries behave now. "No longer applies" names a
30-second timeout they can find in neither the file nor `config/retry.json`, and "moved to #312"
sends them to a table they did not need. Each one says what the diff did, and only the diff gives
it a subject.

A reader of `src/cache.test.ts` finds a test whose subject exists nowhere in the tree. Why
`resetCache` must not come back was said in the change that removed it, which the test does not
name, so the reader can neither keep the test for a reason nor drop it for one.

## Good

The retry section says what holds now.

**Good** `docs/operations.md`

```md
## Retries

A payment call is tried at most `maxAttempts` times (`config/retry.json`).
```

The test goes: a call to an export that does not exist already fails the type check.

The account of the change is in the commit message, which is read with the diff it describes.

**Good** the commit that made the change

```text
Remove resetCache and the per-provider retry table

resetCache had no callers left after #298. The per-provider limits
are tracked in #312, which replaces them with one limit. The
30-second timeout went with the old client in #305.
```

### Graph of the added file

| Node | Address | Source or derived |
|---|---|---|
| the commit message | the commit | derived from its diff |

| From | To | Edge |
|---|---|---|
| the commit message | its diff | visible: the message is attached to the diff it describes |
| the commit message | #298, #305 and #312 | visible, by number |

### Why

Rule 3: a dependency is named by address. A reader of a file as it stands has the file, not the
change that made it, so an account of the change names the diff by nothing that reader can open.
The instances of *Dependency* in `dont-make-me-read--glossary` list this way of naming: "the diff
that produced the text, which a reader of the text as it stands does not have".

The instances of *Dependency* in `dont-make-me-read--glossary` list the test too: "a test that
asserts a removed declaration, flag or file is gone, which only the change that removed it gives a
reason for".

Rule 1: with the account gone, the paragraph under `docs/operations.md › Retries` holds one claim.
