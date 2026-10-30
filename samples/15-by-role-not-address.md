# 15 · "The issue QA reported"

**Pattern.** A paragraph names what it depends on by its role, not its address. The reader who
knows the role can follow; the reader who does not, and every tool, cannot.

## Bad

**Bad** `https://github.com/example/orderly/pull/245`

```md
# Fix the checkout hang

Fixes the issue QA reported. The retry loop now waits on a timer between attempts, and the usual
retry config is read once at startup instead of on every call.

Files to look at: `src/retry.ts` and `src/checkout.ts`.
```

### Graph

| Node | Address | Source or derived |
|---|---|---|
| the change | `https://github.com/example/orderly/pull/245` | derived from a task |
| the file list | `https://github.com/example/orderly/pull/245` (last line) | **noise**: two files offered as the set to look at; a reader takes it as complete |

| From | To | Edge |
|---|---|---|
| `https://github.com/example/orderly/pull/245` | the issue | **missing**, by role: "the issue QA reported" has no number |
| `https://github.com/example/orderly/pull/245` | the config | **missing**, by role: "the usual retry config" has no path |

### What is wrong

A reviewer who was not in the team last week cannot find the issue. An agent cannot find it at all.
"The usual retry config" is a file the writer has open and the reader does not. And "files to look
at" is read as "the files that changed", which the PR itself knows and the sentence does not say.

## Good

**Good** `https://github.com/example/orderly/pull/245`

```md
# Fix the checkout hang

Fixes #231. `withRetry` (`src/retry.ts`) now waits on a timer between attempts instead of blocking
the rendering thread with `sleepSync`, and `config/retry.json` is read once at startup.
```

### Why

Rule 3: by address. Rule 2: the diff already lists its files; a sentence that lists two of them
narrows the reader's attention without saying it has.
