# Delegating a phase to a child skill

Read this when a phase of one skill should run somewhere else: its own model, its own
tool set, its own context.

## Contents

- What may be delegated, and what may not
- What the fork buys, and how each case picks `model`
- Naming
- The child's frontmatter
- Passing input

## What may be delegated, and what may not

Splitting by sequence decides **whether one skill becomes two**. Delegation decides
**whether a phase leaves this execution environment**. A delegated phase is still the
parent's work — it just runs somewhere cheaper and narrower, and hands back a conclusion
instead of the material it was derived from.

**Delegate mechanical, read-only gathering, enumeration, and parsing** — anything whose
output collapses into a conclusion. Fetching a PR's comments, listing changed files,
walking a package registry, grounding a design in the repository: the parent needs the
answer, not the transcript that produced it.

**Delegate only work whose grounds come back with it.** Never a review that returns
verdicts, nor a call that returns only its answer: put a review's substance in a child and
the grounds for each finding never reach the main thread, so nobody can review the review.

The test is whether the caller receives everything it needs to check the work. A skill that
*writes an artifact* passes it — the artifact comes back whole and the reader judges the
thing itself — so a skill that writes forks and is handed one brief, while a skill that
routes or constrains stays on the main thread.

## What the fork buys, and how each case picks `model`

| Motive | What the fork buys | `model` | `background` |
|---|---|---|---|
| **Context** — keep bulk gathering off the main thread | the raw material never lands in the parent's context | the cheapest model that can do it: `haiku` for pure gathering and counting, `sonnet` once light normalization is involved | `false`, since the parent uses the conclusion in the same turn |
| **Independence** — two children must not see each other's output | `context: fork` carries in no conversation history, so the isolation is structural rather than requested | `sonnet`, since the work is design-quality | leave unset when they should run in parallel |
| **Cleanliness** — the conversation that produced the brief must not reach the artifact | the exploring, the half-formed asks and the fetched material never enter the context the artifact is written in | leave unset; the work is the artifact's own | `false`, since the caller shows the result in the same turn |

The last two rows replace prose with a property. "Do not show either child the other's
output" is a prohibition the reader can violate; `context: fork` carrying no conversation
history is a fact they cannot.

## Naming

`<parent-skill-name>-<role>`: the parent's name, **one** hyphen, the role the child plays
— `-change-inventory`, `-repo-grounding`, `-version-lookup`. A single hyphen is the only
separator the naming rule leaves available.

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
inherits, which is the right default for the `Cleanliness` row above.

Leave `disable-model-invocation` at `false`: the caller here **is** a model, so `true`
severs the only path into the child. `user-invocable: false` is what hides it from the
human, and that is the whole requirement.

`context: fork` is what makes the child an execution environment rather than a stretch of
the parent's turn. Without it, `model` applies to the remainder of the current turn — the
main conversation — and not to anything the skill delegates.

## Passing input

Pass the whole input as **`$ARGUMENTS`**. Indexed and named arguments go through
shell-like quote parsing, so a multi-line free-form brief cannot survive as a single
argument.
