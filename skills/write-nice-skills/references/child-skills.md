# Delegating a phase to a child skill

Read this when a phase of one skill should run somewhere else: its own model, its own
tool set, its own context.

## Contents

- What may be delegated, and what may not
- What the fork buys, and which `model` each case wants
- Naming
- The fields a child carries
- Passing input

## What may be delegated, and what may not

Delegation decides **whether a phase leaves this execution environment**. A delegated phase is
still the parent's work; it runs somewhere cheaper and narrower, and hands back what the parent
needs instead of the material that produced it.

The test is whether the caller receives everything it needs to check the work.

**Delegate mechanical, read-only gathering, enumeration, and parsing** — fetching a PR's
comments, listing changed files, walking a package registry, grounding a design in the
repository. It passes because the answer was all the parent wanted, and the answer comes back whole.

**Delegate a phase that produces an artifact**, handing it a single written brief. It passes
because the artifact comes back whole and the reader judges the thing itself.

**Never delegate a phase whose only product is a verdict.** A review is the case: put its
substance in a child and the verdicts come back without what each one rests on, so nobody can
review the review.

## What the fork buys, and which `model` each case wants

The motives below say what a fork buys, and they apply to the two delegable cases above:
gathering is usually `Context`, a phase that produces an artifact is usually `Cleanliness`, and
`Independence` is either of them delegated twice, where neither copy may see the other's answer.

| Motive | What the fork buys | `model` |
|---|---|---|
| **Context** — keep bulk gathering off the main thread | the raw material never lands in the parent's context | the cheapest model that can do it: `haiku` for pure gathering and counting, `sonnet` once light normalization is involved |
| **Independence** — two children must not see each other's output | the same phase runs twice, and neither run can reach what the other produced | as the underlying case, `Context` or `Cleanliness` |
| **Cleanliness** — the conversation that produced the brief must not reach the artifact | the exploring, the half-formed asks and the fetched material never enter the context the artifact is written in | leave unset; the child inherits the parent's |

## Naming

`<parent-skill-name>-<role>`: the parent's name, a hyphen, then the role the child plays —
`review-nice-issues-change-inventory`, `write-nice-architecture-docs-repo-grounding`. The prefix is
what keeps the pair together in a directory listing, and a rename touches only files you own: the
directory and the frontmatter `name`, on each half.

## The fields a child carries

Beyond the `name` and `description` every skill carries:

```yaml
user-invocable: false
disable-model-invocation: false
context: fork
background: false
```

`user-invocable: false` hides the child from the user's `/` menu.

`background: false` is what keeps the parent's turn waiting for the answer. It defaults to `true`,
which hands the parent back its turn before the child has produced anything, and every motive above
wants the answer inside the turn that asked for it.

`model` is the one field left to choose, and the table above chooses it. Omit it and the fork
inherits the parent's, which is right for the `Cleanliness` row.

`disable-model-invocation: false` keeps the model's path into the child open, and the caller here
**is** a model.

`context: fork` is what makes the child an execution environment rather than a stretch of
the parent's turn. Without it, `model` applies to the remainder of the current turn — the
main conversation.

## Passing input

The parent reaches the child the way it reaches any skill — by name, through the `Skill` tool — and
what it passes arrives in the child's body as **`$ARGUMENTS`**. Write the brief there as one blob:
a multi-line free-form brief reaches the child intact.
