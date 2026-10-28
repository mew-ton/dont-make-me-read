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
| the observation | `docs/qa-report-142.md › Observed` | source |
| the guessed cause | `docs/qa-report-142.md › Likely cause` | would be derived from the observation, but sits inside it |
| the task's statement of cause | `https://github.com/example/orderly/issues/231` | derived from the guess, stated as fact |

| From | To | Edge |
|---|---|---|
| `docs/qa-report-142.md` | `docs/qa-report-142.md › Likely cause` | **reversed**: the source carries what would explain it |
| `https://github.com/example/orderly/issues/231` | `docs/qa-report-142.md › Likely cause` | **hidden**: the guess is restated as a finding, source unnamed |

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

Rule 5: depend only on what you explain or reproduce, and say which you are. The report records
what was seen; what the page did is an observation and stays. The cause, once someone establishes
it, is its own paragraph with its own address, and it cites the report. Nobody has established it
in this case, so there is no corrected issue to show.
