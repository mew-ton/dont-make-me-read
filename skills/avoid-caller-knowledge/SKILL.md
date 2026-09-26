---
name: avoid-caller-knowledge
description: >
  Forces the caller-agnostic callee that takes what differs as data, named in the domain's own
  vocabulary, over one that branches on who called it — a shared fetch taking
  `from: 'pageA' | 'pageB'`, a helper with an `isDetailPage` flag, a component with a `variant`
  named after the screen it appears on. Applies to any coding task: writing, refactoring,
  extracting, reviewing, or designing a function, a module, a component, or the interface between
  them. Does not apply when the subject is prose, or a comment that sends its reader elsewhere to
  be understood, or when the branch is on genuine domain data.
user-invocable: false
disable-model-invocation: false
---

## Overview

This skill holds a callee to what it can know on its own: whatever differs between callers arrives
as data, named in the vocabulary of what the callee does. A function that decides what to do from
*who called it* puts every caller inside the range a reader has to hold before they can change
it — the next caller included — and code is where restating does not repair that, because a callee
that takes on a caller's knowledge takes on a dependency, permanently.

## When it applies

To any function, module or component with more than one caller — writing it, extracting it,
reviewing it, or designing the interface between them. It does not apply when:

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

## Persistence

In force for every response once it is loaded, not only the one that loaded it. Still in force
while you are unsure whether a parameter names the caller or the domain. Released when the work
turns to something other than code, or when you are told to stop.

## Common Rationalizations

| Rationalization | Reality |
|---|---|
| "A flag on the shared function is a smaller diff than changing both callers." | It is smaller today. The flag puts both callers in the callee's range, and the next one too, so the shared function is edited once per caller from here on — the diff you avoided arrives again and again. |
| "They call the same endpoint, so the logic belongs in one place." | Sharing a call is not sharing a decision. Keep the call shared and give the decision back to whoever holds the reason for it. |
| "The parameter is only two values, so it is not real coupling." | Coupling is not sized by the union. Both callers are now named in the callee's type, and neither can be renamed, split, or deleted without touching it. |
| "The caller would have to pass a lot of arguments otherwise." | That list is what the difference actually is. A long parameter list is legible; a caller-shaped flag hides the same information where the reader cannot see it. |
| "I'll pass the caller's identity and branch just this once." | The second time is what makes it a pattern, and the second time always arrives — that is what a shared module is for. |

## Red Flags

- A parameter whose only honest name is a caller's: `isDetailPage`, `from: 'pageA'`, a `variant`
  named after a screen.
- The shared function is edited every time a caller is added.
- A branch a reader can only evaluate by opening the callers.

## Verification

- [ ] Every parameter survives renaming into the vocabulary of what the callee does.
- [ ] Adding a caller needs no edit inside the callee.
