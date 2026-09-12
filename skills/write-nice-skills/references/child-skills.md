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

The test is whether the caller receives everything it needs to check the work.

**Delegate mechanical, read-only gathering, enumeration, and parsing** — fetching a PR's
comments, listing changed files, walking a package registry, grounding a design in the
repository. It passes because the answer was all the parent wanted, and the answer comes back whole.

**Delegate a phase that produces an artifact**, handing it a single written brief. It passes
because the artifact comes back whole and the reader judges the thing itself.

**Never delegate a phase whose only product is a verdict.** A review is the case: put its
substance in a child and the verdicts come back without what each one rests on, so nobody can
review the review.

## What the fork buys, and what `model` and `background` each case wants

| Motive | What the fork buys | `model` | `background` |
|---|---|---|---|
| **Context** — keep bulk gathering off the main thread | the raw material never lands in the parent's context | the cheapest model that can do it: `haiku` for pure gathering and counting, `sonnet` once light normalization is involved | `false`, since the parent uses the conclusion in the same turn |
| **Independence** — two children must not see each other's output | `context: fork` carries in no conversation history, so neither child can reach what the other produced | `sonnet`, since the work needs more than counting | leave unset — it defaults to `true` — so they run in parallel |
| **Cleanliness** — the conversation that produced the brief must not reach the artifact | the exploring, the half-formed asks and the fetched material never enter the context the artifact is written in | leave unset; the work is the artifact's own | `false`, since the caller shows the result in the same turn |

## Naming

`<parent-skill-name>-<role>`: the parent's name, a hyphen, then the role the child plays —
`-change-inventory`, `-repo-grounding`, `-version-lookup`. The prefix is what keeps the pair
together in a directory listing. Renaming the pair is an edit you own on both halves,
where a parent's name inside a `description` is an edit somebody else triggers.

## The child's frontmatter

```yaml
user-invocable: false
disable-model-invocation: false
context: fork
```

`user-invocable: false` hides the child from the user's `/` menu. `background` is left out of
the block above because the three motives do not all want the same value: set it to `false`
when the conclusion is used in the same turn, and leave it unset — it defaults to `true` — when
two children should run in parallel.

Two optional fields narrow the child further, and are the two to leave out unless you can
say why: `agent` picks the tool set (`Explore` and `Plan` are read-only) and `model` trades
cost against capability, per the table above. Narrowing is wrong for a fork that produces
the artifact itself — a read-only tool set cannot write, and the cheapest model that can
enumerate files is not the one you want drafting what a person will act on. Omit both and
the fork inherits, which is right for the `Cleanliness` row.

Leave `disable-model-invocation` at `false`: the caller here **is** a model, so `true`
severs the only path into the child.

`context: fork` is what makes the child an execution environment rather than a stretch of
the parent's turn. Without it, `model` applies to the remainder of the current turn — the
main conversation — and not to anything the skill delegates.

## Passing input

Pass the whole input as **`$ARGUMENTS`**: a multi-line free-form brief survives there, and
does not survive the shell-like quote parsing that indexed and named arguments go through.
