# Writing the frontmatter

Read this when setting a skill's frontmatter, or a child skill's.

## What is required

`name` and `description`. They are the two the agent pre-loads, on every turn, for every installed
skill.

## What the rest settles

Every other field is optional and settles how the skill runs rather than whether it is found:

| Field | What it settles |
|---|---|
| `user-invocable`, `disable-model-invocation` | which caller can reach it — a person's `/` menu, the model, or both |
| `context`, `background`, `model` | whether it runs as its own execution environment, and under what |
| `allowed-tools` | what is pre-approved without a prompt, out of what is already in reach |
| `disallowed-tools` | what it may not reach for — this is the field that takes a tool away |

## A child skill's fields

A skill a parent invokes to run one phase carries, beyond `name` and `description`:

```yaml
user-invocable: false
disable-model-invocation: false
context: fork
background: false
```

**`context: fork` is what makes it a child.** It makes the child an execution environment of its
own rather than a stretch of the parent's turn; without it, `model` applies to the remainder of the
current turn — the main conversation.

**`background: false` holds the parent's turn** until the answer is back. It defaults to `true`,
which hands the parent back its turn before the child has produced anything.

The other two are reachability choices any skill makes: `user-invocable: false` keeps the child out
of the user's `/` menu, and `disable-model-invocation: false` lets the model in, which is the
child's only caller.

`model` trades cost against capability, and what the fork was taken for decides it. Gathering is
usually `Context`; a phase that produces an artifact is usually `Cleanliness`; `Independence` is
either of them run twice, where neither copy may see the other's answer.

| Motive | What the fork buys | `model` |
|---|---|---|
| **Context** — keep bulk gathering off the main thread | the raw material never lands in the parent's context | the cheapest model that can do it: `haiku` for pure gathering and counting, `sonnet` once light normalization is involved |
| **Independence** — two children must not see each other's output | the same phase runs twice, and neither run can reach what the other produced | as the underlying case, `Context` or `Cleanliness` |
| **Cleanliness** — the conversation that produced the brief must not reach the artifact | the exploring, the half-formed asks and the fetched material never enter the context the artifact is written in | leave unset; the child inherits the parent's |

A fork taken for its **tool set** narrows it with `allowed-tools` and `disallowed-tools`, the same
two fields any skill uses.

## No comments

Write all of it without comments. The frontmatter loads whenever the skill fires, and a field whose
*choice* needs arguing needs prose an author can argue with — the body — rather than a trailing `#`.
A sentence that only restates the setting is one a body leaves out.
