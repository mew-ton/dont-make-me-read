# Writing the frontmatter

Read this when setting a skill's frontmatter, or a sub-skill's.

## What is required

`name` and `description`. They are the two the agent pre-loads, on every turn, for every installed
skill. `name` is what the skill is invoked by, and it matches the directory the skill sits in.

## What the rest settles

Every other field is optional and settles how the skill runs rather than whether it is found:

| Field | What it settles |
|---|---|
| `user-invocable`, `disable-model-invocation` | which caller can reach it — a person's `/` menu, the model, or both. Set both on any skill whose reach is not both: a skill nothing is meant to type reads `user-invocable: false`, and one the model must be able to pick reads `disable-model-invocation: false` |
| `context`, `background`, `model` | whether it runs as its own execution environment, and under what |
| `allowed-tools` | what is pre-approved without a prompt, out of what is already in reach |
| `disallowed-tools` | what it may not reach for — this is the field that takes a tool away |

## A sub-skill's fields

A sub-skill a parent invokes to run one phase in its own execution environment carries, beyond
`name` and `description`:

```yaml
user-invocable: false
disable-model-invocation: false
context: fork
background: false
```

**`context: fork` is what gives it that environment.** It makes the sub-skill an execution
environment of its own rather than a stretch of the parent's turn; without it, `model` applies to
the remainder of the current turn — the main conversation.

**`background: false` holds the parent's turn** until the answer is back. It defaults to `true`,
which hands the parent back its turn before the sub-skill has produced anything.

`user-invocable: false` and `disable-model-invocation: false` together keep the parent as the only
caller: out of the user's `/` menu, in reach of the model.

A sub-skill left where its own reader finds it — one cut out because it has a leading word of its
own — takes none of this block. It belongs to the phase a parent runs.

`model` trades cost against capability, and what the fork was taken for decides it. Gathering is
usually taken for **context**; a phase that produces an artifact, for **cleanliness**; a phase run
twice where neither copy may see the other's answer, for **independence**.

| Taken for | What the fork buys | `model` |
|---|---|---|
| **context** — bulk gathering stays off the main thread | the raw material never lands in the parent's context | the cheapest model that can do it: `haiku` for pure gathering and counting, `sonnet` once light normalization is involved |
| **independence** — two runs of one phase must not see each other's output | the same phase runs twice, and neither run can reach what the other produced | whatever the phase would take on its own, for context or for cleanliness |
| **cleanliness** — the conversation that produced the brief must not reach the artifact | the exploring, the half-formed asks and the fetched material never enter the context the artifact is written in | leave unset; the sub-skill inherits the parent's |

A fork taken for its **tool set** narrows it with `allowed-tools` and `disallowed-tools`, the same
two fields any skill uses.

## No comments

Write all of it without comments. The frontmatter loads whenever the skill fires, and a field whose
*choice* needs arguing needs prose an author can argue with — the body — rather than a trailing `#`.
A sentence that only restates the setting is one a body leaves out.
