# Architecture

## Bird's eye view

Text someone else has to act on costs its reader before they can act, and the writer cannot feel
that cost — they read their own draft while supplying what it is missing. This plugin is the rules
that follow, arranged to reach the writing rather than wait to be consulted.

`dont-make-me-read` is the entry: it installs the disposition and routes. Behind it, one best
practice per artifact whose shape is fixed enough to have one. Everything else is whatever a best
practice needs in order to be applied and to be checked, and takes whatever shape that job wants —
only the best practices are fixed here.

A best practice is held by a skill, so that skill is insulated from what it judges: run it inside
the session that has been arguing about the artifact and the standard bends toward what was just
said. Artifacts are produced from outside — a person through a command, an agent through a fork.

## Codemap

Follows the Claude plugin codebase standard. Revisited when we decide to ship outside that format.

## Cross-cutting concerns and invariants

### The golden rule

**A rule that has to be remembered will be broken. Build the machinery that makes it a property,
and put that machinery where the writing already happens.**

For a decision this file does not name, derive it from here: ask what would have to be remembered,
and what arrangement removes the need.

### The invariants it generates

- **Nothing is reachable by being named from a menu.** The rules have to land mid-task, and nobody
  stops mid-task to name one.
- **A skill that produces an artifact never sees the conversation that reached it.** That keeps out
  both the residue a reader could not check and the session's pull on the standard.
- **A skill never holds a tool that would let it confirm what its reader could not.** Where the
  footing is the product, anything beyond it leaves the verdict sound only while someone remembers
  not to use it.

### Out of scope

- A skill judges its own axis. Repository grounding, dependency closure, scope: the caller's.
- No general-purpose "review this" entry point.
- No toolchain, package manager, or install path assumed.
- No second-language keyword list in a description.

## Where a new entry point goes

**A person decides to invoke it → something they type. It has to reach work already underway → a
skill.**

## What a command owes the skill it calls

**Everything unsettled is settled before the hand-off; what crosses is one brief.** Pass the
conversation on instead and it lands in the context the artifact is written in, and surfaces there.

## What context a skill runs in

**Produces an artifact from a brief → outside the session. Acts on work already in front of the
model → in place.**

Isolating the second would cut it off from what it acts on: routing needs the work present, a
constraint has to apply where the writing happens, and findings are worth nothing without their
grounds.

Every skill:

```yaml
user-invocable: false
disable-model-invocation: false
```

One that produces an artifact adds:

```yaml
context: fork
background: false
```

`agent` and `model` are set only on a fork whose whole job is gathering. One that produces the
artifact gets neither.

## What tools a skill gets

**What the job needs, minus anything that would let it confirm what its reader could not.** The
subtraction bites only where that footing is the product; then fetching belongs to the caller.

## Where an explanation goes

**What a contributor decides by goes here. What a reader of one artifact needs goes with that
artifact, and that artifact's own rules say where within it.**

## When an artifact earns rules of its own

**When its shape is fixed enough that a general rule cannot supply it: named sections, a budget, a
template.** Below that bar the entry's test and the always-on rules serve it, and another skill only
adds a description every future turn has to judge.

## Before a skill is committed

```bash
bash skills/write-nice-skills/scripts/count-tokens.sh skills/*/SKILL.md
```

---

Shape from matklad's `ARCHITECTURE.md` (Alex Kladov, 2021).
