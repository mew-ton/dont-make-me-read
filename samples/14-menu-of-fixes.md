# 14 · A menu of fixes

**Pattern.** The writer had what was needed to choose and handed the choice to a reader who has
less. Nothing in the paragraph changes what the reader does next, except to make them decide.

## Files

`issues/231.md`

```md
Possible fixes:

- move the retry loop off the UI thread
- lower the retry count
- show a spinner during retries
- make the provider call cancellable

Pick whichever is easiest. Handle the error states appropriately.
```

## Graph

| Node | Address | Source or derived |
|---|---|---|
| the task | `issues/231.md` | derived from an observation |

There are no edges in this paragraph, which is the problem: a fix is derived from a cause, and this
paragraph names none.

## What is wrong

Four fixes repair four different causes. "Lower the retry count" accepts the freeze and shortens it;
"show a spinner" keeps the freeze and decorates it; the other two remove it. The writer knew which
cause was real, or could have found out, and instead wrote a list. "Handle the error states
appropriately" tells the reader the spec is complete when it is not.

## What the rule says

Rule 2: everything in the paragraph changes what the reader does next. The *What noise does* table
in `references/prose.md` names both of these. State the cause, the one fix, and the constraint as
the wall the reader would walk into.

```md
Cause: `withRetry` awaits its delays on the thread that renders checkout. Fix: run the retry off
that thread. Constraint: the bound on retries stays (see "Retries are bounded" in
`docs/architecture.md`); the provider bills per attempt.
```
