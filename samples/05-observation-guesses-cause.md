# 05 · An observation that guesses its cause

**Pattern.** A source document reaches forward into what would explain it. The observation now
depends on a cause nobody has established, and every reader downstream inherits the guess as fact.

## Bad

**Bad** `docs/qa-report-142.md`

```md
## Observed

The screen freezes for about ten seconds after pressing Pay, then shows "contact support".

## Likely cause

Probably the retry loop is running on the UI thread, since the whole page stops responding.
```

**Bad** `https://github.com/example/orderly/issues/231`

```md
The retry loop is blocking the main thread.
```

### Graph

| Node | Address | Source or derived |
|---|---|---|
| the report | `docs/qa-report-142.md` | **two claims**: what QA saw, and a cause QA had no means to establish, cited together as QA's report |
| the observation | `docs/qa-report-142.md › Observed` | source |
| the guessed cause | `docs/qa-report-142.md › Likely cause` | would be derived from the observation, but sits inside it |
| the task's statement of cause | `https://github.com/example/orderly/issues/231` | derived from the guess, stated as fact |

| From | To | Edge |
|---|---|---|
| `https://github.com/example/orderly/issues/231` | `docs/qa-report-142.md › Likely cause` | **missing**: the guess is restated as a finding, source unnamed |

### What is wrong

A cause is an explanation of an observation and depends on it, never the other way round. Once the
guess sits inside the report, the issue copies it without the "probably", and the engineer who
reads the issue starts from a conclusion QA never had the means to reach.

## Good

**Good** `docs/qa-report-142.md`

```md
## Observed

The screen freezes for about ten seconds after pressing Pay, then shows "contact support". The
whole page stops responding during the freeze.
```

### Why

Rule 1: one claim under an address. The issue cites the report as one thing, so a guess inside it
is read as QA's observation. The report records what was seen; what the page did is an observation
and stays. The cause, once someone establishes it, is its own paragraph with its own address, and
it cites the report. Nobody has established it in this case, so there is no corrected issue to
show.
