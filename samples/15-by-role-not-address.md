# 15 · "The issue QA reported"

**Pattern.** A paragraph names what it depends on by its role, not its address. The reader who
knows the role can follow; the reader who does not, and every tool, cannot.

## Files

`pr/245.md`

```md
# Fix the checkout hang

Fixes the issue QA reported. The retry loop now yields between attempts, and the usual retry
config is read once at startup instead of on every call.

Files to look at: `src/retry.ts` and `src/checkout.ts`.
```

## Graph

| Node | Address | Source or derived |
|---|---|---|
| the change | `pr/245.md` | derived from a task |

| From | To | Edge |
|---|---|---|
| `pr/245.md` | the issue | **hidden by role**: "the issue QA reported" has no number |
| `pr/245.md` | the config | **hidden by role**: "the usual retry config" has no path |
| `pr/245.md` | the files changed | **noise**: two files offered as the set to look at; a reader takes it as complete |

## What is wrong

A reviewer who was not in the team last week cannot find the issue. An agent cannot find it at all.
"The usual retry config" is a file the writer has open and the reader does not. And "files to look
at" is read as "the files that changed", which the PR itself knows and the sentence does not say.

## What the rule says

Rule 3: by address. Rule 2: the diff already lists its files; a sentence that lists two of them
narrows the reader's attention without saying it has.

```md
# Fix the checkout hang

Fixes #231. `withRetry` (`src/retry.ts`) now yields between attempts instead of blocking the
rendering thread, and `config/retry.json` is read once at startup.
```
