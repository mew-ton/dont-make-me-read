# What a callee may know

Read this when you are writing, extracting, refactoring, reviewing or designing a function, module
or component with more than one caller, or the interface between them. `SKILL.md` carries the test
and why the fix inverts in code; this holds the rule for that case.

A callee is held to what it can know on its own: whatever differs between callers arrives as data,
named in the vocabulary of what the callee does. A function that decides what to do from *who
called it* puts every caller inside the range a reader has to hold before they can change it — the
next caller included.

## When it applies

To any function, module or component with more than one caller. It does not apply when:

- The two callers were never doing the same thing. Then the extraction is what to undo, not the
  parameter — two straightforward functions cost less to read than one that serves both.
- The caller's identity is the subject matter: a logger's `source`, a metric's label, an audit
  record's actor. Nothing branches on it; it is carried, not consulted.

## The rule

**Push what differs out to the callers, not into the callee.** It is the callers' to state; the
callee takes it as data and does not know who supplied it — otherwise the extraction that was meant
to make the next change cheaper is edited again for every caller added.

**Rename the parameter into the vocabulary of what the callee does.** If it survives, the parameter
is the callee's own; if the only honest name is the caller's identity, the knowledge crossed. A
callee may branch all it likes on facts it owns.

| Parameter | Reads as | Verdict |
|---|---|---|
| `scope: 'own' \| 'team'` | what the query covers | the callee's own |
| `currency: Currency` | what the amount is in | the callee's own |
| `from: 'pageA' \| 'pageB'` | who is asking | crossed |
| `isDetailPage: boolean` | where the caller lives | crossed |
| `variant: 'list' \| 'detail'` | which screen renders it | crossed until renamed to what actually differs (`density`, `showsSummary`) |

## Common Rationalizations

| Rationalization | Reality |
|---|---|
| "They call the same endpoint, so the logic belongs in one place." | Sharing a call is not sharing a decision. Keep the call shared and give the decision back to whoever holds the reason for it. |
| "The parameter is only two values, so it is not real coupling." | Coupling is not sized by the union. Both callers are now named in the callee's type, and neither can be renamed, split, or deleted without touching it. |
| "The caller would have to pass a lot of arguments otherwise." | That list is what the difference actually is. A long parameter list is legible; a caller-shaped flag hides the same information where the reader cannot see it. |
| "I'll pass the caller's identity and branch just this once." | The second time is what makes it a pattern, and the second time always arrives — that is what a shared module is for. |

## Red Flags

- The shared function is edited every time a caller is added.
- A branch a reader can only evaluate by opening the callers.

## Verification

- [ ] Every parameter survives renaming into the vocabulary of what the callee does.
- [ ] Adding a caller needs no edit inside the callee.
