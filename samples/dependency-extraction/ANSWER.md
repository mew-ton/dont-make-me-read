# Answer key

The sample is a small service, `orderly`, written so that every pathology of an explanation graph
appears at least once. This file lists the nodes, the edges they should have, and every planted
defect with the rule in `skills/dont-make-me-read/SKILL.md` that catches it.

## How to use it

Give an agent the sample directory without this file and ask:

> Extract the dependency graph of the explanations in this directory. List every node by its
> address (a heading, or a declaration's name), every edge with its direction and whether it is
> visible or hidden, and every place the graph is wrong.

Run it once with the plugin installed and once without, and compare each run to the table below.
A finding that appears only with the plugin is one the skill reached; one that appears in both
runs is one the model would have made anyway. That comparison is the check the README's
assumption table asks for.

## Nodes

| Address | Kind | Source or derived |
|---|---|---|
| `config/retry.json` | owner of `maxRetries` and `baseDelayMs` | source |
| `docs/architecture.md › Retries are bounded` | decision | source; reproduced by `withRetry` |
| `docs/architecture.md › Checkout owns the user-facing outcome` | decision | source; reproduced by `pay` |
| `docs/qa-report-142.md` | observation | source |
| `issues/231.md` | task | derived from report 142 |
| `pr/245.md` | change | derived from issue 231 |
| `README.md › Retries`, `› Running it`, `› Environment` | explanation of the service | derived from config and code |
| `src/retry.ts › withRetry` | reproduction of "Retries are bounded" | derived |
| `src/retry.ts › attemptsSeen`, `› __resetForTests` | state and a hook | see findings |
| `src/checkout.ts › pay` | reproduction of "Checkout owns the user-facing outcome" | derived |
| `src/retry.test.ts › three tests` | explanations of `withRetry` | derived |

## Edges that should exist, and their direction

- `README › Retries` → `config/retry.json`, by address (missing; the number is restated instead)
- `README › Running it` → `README › Environment`, by heading (present, but by position)
- `withRetry` → `architecture › Retries are bounded`, in the decision's words (missing)
- `pay` → `architecture › Checkout owns the user-facing outcome` (missing)
- `issues/231` → `docs/qa-report-142`, quoting the observation (missing)
- `pr/245` → `issues/231`, by number (missing)
- `retry.test.ts` → `withRetry`, by import (present, visible)
- `pay` → `withRetry`, by import (present, visible)
- `withRetry` → `config/retry.json`, by import (present, visible)

## Planted defects

| # | Where | What | Pathology | Rule |
|---|---|---|---|---|
| 1 | `README › Retries` | "up to five times"; the owner says three | duplicate node, stale | 4 |
| 2 | `README › Running it` | "the section below" | hidden edge by reading order | 3 |
| 3 | `README › Environment` | "overrides the default", default's owner unnamed | hidden edge by role | 3 |
| 4 | `architecture › Retries are bounded` | names `withRetry` and `config/retry.json` | reversed edge: a decision listing its reproductions | 5 |
| 5 | `qa-report-142 › Probably` | a guessed cause inside an observation | reversed edge: the observation depends on what would explain it | 5 |
| 6 | `issues/231` | "As discussed in standup" | dangling edge | 3 |
| 7 | `issues/231` | the report retold in the engineer's words, no quote, no link | translation without the quote; owner unnamed | 4 |
| 8 | `issues/231` | "The retry loop is blocking the main thread." | QA's guess stated as fact, source unnamed | 3, 5 |
| 9 | `issues/231` | "up to five times with a doubling wait" | third copy of the number; two of three wrong | 4 |
| 10 | `issues/231` | "See above for the numbers." | hidden edge by position | 3 |
| 11 | `issues/231` | four possible fixes, "pick whichever is easiest" | noise: a menu the writer could have weighted | 2 |
| 12 | `issues/231` | "Handle the error states appropriately." | noise: the reader concludes the spec is complete | 2 |
| 13 | `pr/245` | "the issue QA reported", no number | hidden edge by role | 3 |
| 14 | `pr/245` | "the usual retry config" | hidden edge by role | 3 |
| 15 | `pr/245` | "Files to look at", two files | noise: sampled paths read as the complete set | 2 |
| 16 | `withRetry` | parameter `fromCheckout` | reversed edge: the callee knows its caller | 5 |
| 17 | `withRetry` | decides the user-facing message | contradicts "Checkout owns the user-facing outcome" and does not cite it | 5 |
| 18 | `withRetry` | reads `process.env.RETRY_LIMIT` | hidden edge: ambient state; a second place the limit is set | 3, 6 |
| 19 | `withRetry` | the comment restates the body | duplicate node: a second owner of the claim | 4 |
| 20 | `withRetry` | no comment naming the decision it reproduces | missing edge to its source | 5 |
| 21 | `attemptsSeen`, `__resetForTests` | state and a hook only tests use | reversed edge: production code reaching toward its tests | 5 |
| 22 | `retry.test.ts › beforeEach` | `calls` and `failing` set by position | hidden edge: every test body leans on it unnamed | 3 |
| 23 | `retry.test.ts › "works correctly"` | not a claim | no claim under the address | 1 |
| 24 | `retry.test.ts › three tests` | three names, one claim | duplicate nodes | 1, 4 |
| 25 | `retry.test.ts › "configured number"` | asserts `3`, not the configured value | restates the owner's value | 4 |

## The reader's path

Ask the agent, separately: "You are reviewing `pr/245.md`. List what you had to open before you
could judge it, and what you could not find from the PR's own text."

Expected: the issue (not named, found by browsing), the QA report (not named from the PR or the
issue), the config (to learn the real retry count, since three documents give two different
numbers), both architecture decisions (to notice that `withRetry` breaks one). The closure a
reviewer must hold is the whole directory, and two of its nodes cannot be reached from the PR by
any edge at all.
