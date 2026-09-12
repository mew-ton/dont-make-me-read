# Delegating a phase to a child skill

Read this when a phase of one skill should run somewhere else: its own model, its own
tool set, its own context.

## Contents

- What may be delegated, and what may not
- Naming
- The child's frontmatter
- Passing input
- Two motives, and how each picks `model`

## What may be delegated, and what may not

Splitting by sequence decides **whether one skill becomes two**. Delegation decides
**whether a phase leaves this execution environment**. A delegated phase is still the
parent's work — it just runs somewhere cheaper and narrower, and hands back a conclusion
instead of the material it was derived from.

**Delegate mechanical, read-only gathering, enumeration, and parsing** — anything whose
output collapses into a conclusion. Fetching a PR's comments, listing changed files,
walking a package registry, grounding a design in the repository: the parent needs the
answer, not the transcript that produced it.

**Never delegate work whose grounds would not come back with it** — a review that returns
verdicts, a call that returns only its answer. Put a review's substance in a subagent and
the grounds for each finding never reach the main thread, so nobody can review the review.
When context is the problem there, split the **session**, not the judgment.

The test is not judgment versus gathering. It is whether the caller receives everything
needed to check the work. A skill that *writes an artifact* passes it: the artifact comes
back whole and the reader judges the thing itself, so nothing is distilled away behind the
fork.

## Naming

`<parent-skill-name>-<role>`: the parent's name, **one** hyphen, the role the child plays
— `-change-inventory`, `-repo-grounding`, `-version-lookup`. A single hyphen is the only
separator available, so do not reach for `--` to mark the boundary.

The name is not what hides the child. Keeping it out of the user's `/` menu is
`user-invocable`'s job, below.

## The child's frontmatter

```yaml
user-invocable: false
disable-model-invocation: false
context: fork
agent: Explore
model: haiku
background: false
```

`user-invocable: false` hides the child from the user's `/` menu. `background: false` is
required when the conclusion is used in the same turn; it defaults to `true`. `agent` and
`model` are optional: `agent` picks the tool set (`Explore` and `Plan` are read-only), and
`model` trades cost against capability — gathering only is `haiku`, gathering plus light
normalization is `sonnet`.

`agent` and `model` are the two to leave out unless you can say why. They narrow a child to
what a gathering run needs, and narrowing is wrong for a fork that produces the artifact
itself: a read-only tool set cannot write, and the cheapest model that can enumerate files
is not the one you want drafting the thing a person will act on. Omit both and the fork
inherits, which is the right default for the `Cleanliness` motive below.

`disable-model-invocation: true` is the field that looks right and is wrong. The caller
here **is** a model, so `true` severs the only path into the child. Hiding it from the
human is `user-invocable: false`, and that is the whole requirement.

`context: fork` is what makes the child an execution environment rather than a stretch of
the parent's turn. Without it, `model` applies to the remainder of the current turn — the
main conversation — and not to anything the skill delegates.

## Passing input

Pass the whole input as **`$ARGUMENTS`**. Indexed and named arguments go through
shell-like quote parsing, so a multi-line free-form brief cannot survive as a single
argument.

## Two motives, and how each picks `model`

| Motive | What the fork buys | `model` | `background` |
|---|---|---|---|
| **Context** — keep bulk gathering off the main thread | the raw material never lands in the parent's context | the cheapest model that can do it: `haiku` for pure gathering and counting, `sonnet` once light normalization is involved | `false`, since the parent uses the conclusion in the same turn |
| **Independence** — two workers must not see each other's output | `context: fork` carries in no conversation history, so the isolation is structural rather than requested | `sonnet`: the work is design-quality, so narrow it with `effort` rather than by dropping the model | leave unset when the workers should run in parallel |
| **Cleanliness** — the conversation that produced the brief must not reach the artifact | the exploring, the half-formed asks and the fetched material never enter the context the artifact is written in | leave unset; the work is the artifact's own | `false`, since the caller shows the result in the same turn |

The last two rows replace prose. "Do not show either subagent the other's output" is a
prohibition the reader can violate; `context: fork` not carrying conversation history is a
property they cannot. The same move applies one axis over: "do not write what only this
conversation's participants could reconstruct" is `avoid-unverifiable-context`'s rule and a
writer can break it, but a skill that never saw the conversation cannot.

So a skill that writes an artifact forks and is handed one brief, while a skill that routes
or constrains stays on the main thread: both need the property, and only the first can have
it without losing the work it acts on.
