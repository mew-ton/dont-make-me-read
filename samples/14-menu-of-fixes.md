# 14 · A menu of fixes

**Pattern.** The writer had what was needed to choose and handed the choice to a reader who has
less. Nothing in the paragraph changes what the reader does next, except to make them decide.

## Bad

**Bad** `https://github.com/example/orderly/issues/231`

```md
Possible fixes:

- move the retry loop off the UI thread
- lower the retry count
- show a spinner during retries
- make the provider call cancellable

Pick whichever is easiest. Handle the error states appropriately.
```

### Graph

| Node | Address | Source or derived |
|---|---|---|
| the task | `https://github.com/example/orderly/issues/231` | derived from an observation |
| the list of fixes | `https://github.com/example/orderly/issues/231` (the list) | **noise**: it hands the reader a choice and changes nothing else they do |

There are no edges in this paragraph, which is the problem: a fix is derived from a cause, and this
paragraph names none.

### What is wrong

Four fixes repair four different causes. "Lower the retry count" accepts the freeze and shortens it;
"show a spinner" keeps the freeze and decorates it; the other two remove it. The writer knew which
cause was real, or could have found out, and instead wrote a list. "Handle the error states
appropriately" tells the reader the spec is complete when it is not.

## Good

**Good** `https://github.com/example/orderly/issues/231`

```md
Cause: `withRetry` (`src/retry.ts`) waits between attempts with `sleepSync`, a busy wait that
blocks the thread that renders checkout.

Done when: the page stays responsive while `withRetry` waits between attempts, and the bound on
retries is unchanged ("Retries are bounded", `docs/architecture.md`: the provider bills per
attempt).
```

### Why

Rule 2: everything in the paragraph changes what the reader does next. The *Noise* table in
`references/glossary.md` names the menu of fixes and "handle this appropriately". State the cause,
and what done means with the constraint in it as the wall the reader would walk into. Choosing the
cause is the writer's; how to stop blocking is the implementer's, for the reason case 17 gives.
