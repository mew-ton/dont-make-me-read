# Delegating a phase to a child skill

Read this when a phase of one skill should run somewhere else: its own model, its own
tool set, its own context.

## Contents

- What may be delegated, and what may not
- What the fork buys, and what `model` and `background` each case wants
- Naming
- The child's frontmatter
- Passing input

## What may be delegated, and what may not

Delegation decides **whether a phase leaves this execution environment**. A delegated phase is
still the parent's work; it runs somewhere cheaper and narrower, and hands back what the parent
needs instead of the material that produced it.

**Delegate mechanical, read-only gathering, enumeration, and parsing** — anything whose
output collapses into a conclusion. Fetching a PR's comments, listing changed files,
walking a package registry, grounding a design in the repository: the parent needs the
answer, not the transcript that produced it.

**Never delegate work whose grounds would not survive the trip.** A review is the case: put
its substance in a child and the verdicts come back without what each one rests on, so
nobody can review the review.

The test is whether the caller receives everything it needs to check the work. A skill that
*writes an artifact* passes it — the artifact comes back whole and the reader judges the
thing itself — so a skill that writes forks and is handed one brief, while a skill that
routes or constrains stays on the main thread.

## What the fork buys, and what `model` and `background` each case wants

| Motive | What the fork buys | `model` | `background` |
|---|---|---|---|
| **Context** — keep bulk gathering off the main thread | the raw material never lands in the parent's context | the cheapest model that can do it: `haiku` for pure gathering and counting, `sonnet` once light normalization is involved | `false`, since the parent uses the conclusion in the same turn |
| **Independence** — two children must not see each other's output | `context: fork` carries in no conversation history, so the isolation is structural rather than requested | `sonnet`, since the work is design-quality | leave unset when they should run in parallel |
| **Cleanliness** — the conversation that produced the brief must not reach the artifact | the exploring, the half-formed asks and the fetched material never enter the context the artifact is written in | leave unset; the work is the artifact's own | `false`, since the caller shows the result in the same turn |

## Naming

`<parent-skill-name>-<role>`: the parent's name, a hyphen, then the role the child plays —
`-change-inventory`, `-repo-grounding`, `-version-lookup`. The prefix is what keeps the pair
together in a directory listing.

## The child's frontmatter

```yaml
user-invocable: false
disable-model-invocation: false
context: fork
background: false
```

`user-invocable: false` hides the child from the user's `/` menu. `background: false` is
required when the conclusion is used in the same turn, and left unset when two children should
run in parallel; it defaults to `true`.

Two optional fields narrow the child further, and are the two to leave out unless you can
say why: `agent` picks the tool set (`Explore` and `Plan` are read-only) and `model` trades
cost against capability, per the table above. Narrowing is wrong for a fork that produces
the artifact itself — a read-only tool set cannot write, and the cheapest model that can
enumerate files is not the one you want drafting what a person will act on. Omit both and
the fork inherits, which is right for the `Cleanliness` row.

Leave `disable-model-invocation` at `false`: the caller here **is** a model, so `true`
severs the only path into the child. `user-invocable: false` is what hides it from the
human, and that is the whole requirement.

`context: fork` is what makes the child an execution environment rather than a stretch of
the parent's turn. Without it, `model` applies to the remainder of the current turn — the
main conversation — and not to anything the skill delegates.

## Passing input

Pass the whole input as **`$ARGUMENTS`**: a multi-line free-form brief survives there, and
does not survive the shell-like quote parsing that indexed and named arguments go through.
