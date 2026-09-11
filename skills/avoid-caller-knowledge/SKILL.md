---
name: avoid-caller-knowledge
description: >
  Forces the caller-agnostic callee that takes what differs as data, named in the domain's own
  vocabulary, over one that branches on who called it — a shared fetch taking `from: 'pageA' |
  'pageB'`, a helper with an `isDetailPage` flag, a component with a `variant` named after the
  screen it appears on. Use this skill on any coding task: writing, refactoring, extracting,
  reviewing, or designing a function, a module, a component, or the interface between them. DO NOT
  use this skill when the subject is prose, or a comment that sends its reader elsewhere to be
  understood, or when the branch is on genuine domain data.
user-invocable: false
disable-model-invocation: false
allowed-tools: []
---

## Scope

Someone reading a function has to hold whatever it depends on before they can change it. A
function that decides what to do from *who called it* puts every caller inside that range, and
puts the next one there too.

This is the same failure a reference detour is in prose, with the opposite fix. Text can restate
what the reader needs at the point of use and leave the original authoritative, because nothing
executes. Restating a caller's knowledge inside a callee copies nothing — it takes on a dependency
on that caller, permanently.

## The rule

**The knowledge goes out, not in.** What differs between callers is the callers' to state; the
callee takes it as data and does not know who supplied it.

The symptom that confirms it: extracting the shared code was supposed to make a change cheaper,
and instead the shared code is edited every time a caller is added.

## The signal is in the name

Try to rename the parameter in the vocabulary of what the function actually does. If it survives,
it is the callee's own. If the only honest name is the caller's identity, the knowledge crossed.

| Parameter | Reads as | Verdict |
|---|---|---|
| `scope: 'own' \| 'team'` | what the query covers | the callee's own |
| `currency: Currency` | what the amount is in | the callee's own |
| `from: 'pageA' \| 'pageB'` | who is asking | crossed |
| `isDetailPage: boolean` | where the caller lives | crossed |
| `variant: 'list' \| 'detail'` | which screen renders it | crossed until renamed to what actually differs (`density`, `showsSummary`) |

The test is the name, not the number of branches. A callee may branch all it likes on facts it
owns.

## When this is not the finding

- The difference **is** domain data, and the domain word for it exists. Pass that.
- The two callers were never doing the same thing. Then the extraction is what to undo, not the
  parameter — two straightforward functions cost less to read than one that serves both.
- The caller's identity is the subject matter: a logger's `source`, a metric's label, an audit
  record's actor. Nothing branches on it; it is carried, not consulted.

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

## Related skills

- `avoid-reference-detours` — the same range failure in text, where the fix is to restate the fact
  at the point of use rather than to remove it.
