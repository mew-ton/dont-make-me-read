# 19 · The last line of a conversation

**Pattern.** A review comment carries only the instruction that ended the conversation it came
from. The observation, the judgment that the change may stay, and the decision on what the real
fix is were said between the reviewer and its operator, and the comment leans on all three. The
conversation has an address, and it is one the author cannot open. The writer cannot feel the gap,
because it reads its draft with the whole session in front of it; an agent reviewing from a chat
is the common case, and so is a person reviewing from a call.

## Bad

**Bad** `https://claude.ai/code/session_7f3a` (the chat that produced the comment; its operator
and the reviewer can open it, the author cannot)

```
Operator: The change adds an N+1: one request per line item. A backend endpoint is the permanent
fix, but this PR can go in as the provisional one. Ask the author to open an issue for the
permanent fix.

Reviewer: Agreed. A batch endpoint, `GET /api/products?ids=`, so the cart loads in one request.
```

**Bad** `https://github.com/example/orderly/pull/260#discussion_r112` (a review comment on
`src/cart.ts`)

```md
Please open an issue to implement the `GET /api/products?ids=` endpoint.
```

### Graph

| Node | Address | Source or derived |
|---|---|---|
| the comment | `https://github.com/example/orderly/pull/260#discussion_r112` | derived from the chat |
| the observation, one request per line item | the chat, and the diff as behaviour | source: written nowhere the author can read |
| the judgment, this PR may go in as provisional | the chat | derived from the observation; written nowhere the author can read |
| the permanent fix, a batch endpoint | the chat | derived from the observation; a name the chat coined |

| From | To | Edge |
|---|---|---|
| the comment | the chat | **dangling**: the address exists and the author cannot open it |
| the comment | the observation | **missing**: the ask is derived from an N+1 the comment never names |
| the comment | the judgment | **missing**: the author cannot tell whether the comment blocks the PR |
| the comment | the permanent fix | **dangling**: an endpoint that exists only as words in the chat |

### What is wrong

The author receives an order with nothing in front of it. They cannot tell what in their change
called for it, whether it blocks the PR, or why that endpoint, so they either ask, which is the
round trip the comment was meant to save, or open an issue that says what the comment says and no
more. Whoever picks that issue up gets even less. Everything the ask stands on is written in a
place with a precise URL, and the only reader who can open it is the one who wrote the comment.

## Good

**Good** `https://github.com/example/orderly/pull/260#discussion_r112`

```md
`src/cart.ts` line 40 calls `GET /api/products/:id` once per line item, so a cart of n lines
loads in n+1 requests. Not blocking: carts are under ten lines today.

Please open an issue for the permanent fix, a batch endpoint on the backend such as
`GET /api/products?ids=`, citing this thread, and link it here. This PR is the provisional fix, and
nothing records that yet.
```

### Why

Rule 3: a dependency is named by address, and the *Edges* section of `references/prose.md` says
an address counts only if this paragraph's readers can open it; the chat's URL is exact and the
author cannot open it, so what the comment leans on is said here instead. Rule 5: the ask is
derived from an observation and a judgment, so the comment names both, by line, and says which is
which. Rule 1: the observation and the ask are two claims, so they are two paragraphs. Rule 6: the
decision that this PR is provisional needs a place; the issue the author opens is that place, and
the comment says so rather than leaving the decision in the chat. Case 03 is the neighbour: there
the conversation has no address at all; here it has one, for the wrong reader.
