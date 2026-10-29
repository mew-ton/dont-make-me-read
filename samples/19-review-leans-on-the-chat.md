# 19 · "You said that was intentional"

**Pattern.** A review comment leans on the conversation that produced it: what the reviewer was
asked to look at, what it flagged earlier in that session, what its operator said. The author of
the change was not in that conversation and has no way to reach it. The writer cannot feel the gap
because it reads its own draft with the whole session still in front of it; an agent reviewing
from a chat is the common case, and so is a person reviewing from a call.

## Bad

**Bad** `https://github.com/example/orderly/pull/245#discussion_r98` (a review comment on
`src/checkout.ts`)

```md
As discussed, the timer is the right fix for the hang, so that part is fine. The other thing I
flagged earlier still applies: a declined card still ends in "contact support". You said that was
intentional for now, so I am leaving it, but it needs to go in the follow-up we talked about.
```

### Graph

| Node | Address | Source or derived |
|---|---|---|
| the comment | `https://github.com/example/orderly/pull/245#discussion_r98` | derived from the diff and from the chat that produced it |
| the chat | none | not a node: it has no address and no text the author can reach |
| the follow-up | none | not a node: no issue exists |
| the first sentence | the same address | **noise**: that the timer is right changes nothing the author does next |

| From | To | Edge |
|---|---|---|
| the comment | the chat | **dangling**: "as discussed" and "I flagged earlier" happened between the reviewer and its operator |
| the comment | the chat | **hidden**, by role: "you said" is the operator; the author reads it as themselves |
| the comment | the follow-up | **dangling**: "the follow-up we talked about" has no number |

### What is wrong

The author opens the comment and finds three things they cannot follow. "As discussed" was a
discussion they were not in. "You said that was intentional" was said by someone else, so the
author either searches their memory for words they never wrote or decides the reviewer is wrong
about them. "The follow-up" has no number, so nothing tracks the message that stays. The comment
is a note from one conversation pasted into another, and the writer is the only reader who was in
both.
What the operator decided is real and the author needs it; it is the one thing the comment leans
on that is written nowhere.

## Good

**Good** `https://github.com/example/orderly/issues/231`

```md
Decided (here, 2026-10-28): #245 fixes the hang only. The message on a declined card, "contact
support" in QA report 142 (`docs/qa-report-142.md`), moves to #252.
```

**Good** `https://github.com/example/orderly/pull/245#discussion_r98`

```md
A declined card still ends in "contact support" here, which the decision on #231 (2026-10-28)
moves to #252. Add #252 to the PR description, so the next reader who finds the message here is
sent to #252 and not to #231.
```

### Graph of the added paragraph

| Node | Address | Source or derived |
|---|---|---|
| the decision | `https://github.com/example/orderly/issues/231` (2026-10-28) | source: the one place it is stated |

| From | To | Edge |
|---|---|---|
| the comment | the decision | visible, by address and date |
| the comment | `https://github.com/example/orderly/issues/252` | visible, by number |
| the decision | `https://github.com/example/orderly/issues/252` | visible, by number |

### Why

Rule 3: a dependency is named by address, and a chat has none the author can open. The *Edges*
section of `references/prose.md` lists "you said" among the hidden edges: the pronoun resolves to a
different person on each side of the comment. Rule 6: the decision made in that chat gets a place
before it is cited, and this project's instructions (`CONTRIBUTING.md › Decisions`, as in case 03)
put a decision about one task on that task's issue, so it is written there first and the comment
cites it. Rule 2: that the timer is right changes nothing the author does, so it goes; what stays
is the one thing they must do and the address that says why.
