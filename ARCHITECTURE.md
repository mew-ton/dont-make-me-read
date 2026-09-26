# Architecture

## Bird's eye view

Anything someone else has to read before they can act — an issue, a review finding, an architecture
doc, a `SKILL.md`, a comment, the code itself — is paid for in the range they have to hold in order
to understand it, and the writer cannot feel that range: they read their own draft while supplying
what it is missing. This plugin is the rules that follow, arranged to reach the writing rather than
wait to be consulted.

Two layers. The standing one is `dont-make-me-read` — the test, and the ways a range goes wrong —
together with the rules that hold whatever is being written. It carries no inventory of what else
exists, which is what holds it to a fixed size however many activities there are. On top of it, one
skill per activity, carrying what that activity's range does that the test alone cannot supply.
Several stand at once and nothing arbitrates between them, so their size is the only thing keeping
the pile affordable.

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
- **The standing layer holds no inventory of what else exists.** A table of artifacts and the skills
  that own them is a second place to update, and it grows with what it lists — and this is the layer
  that has to stay a fixed size. A skill is reached by its own description or not at all.
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
skill.** A rule that has to hold for a whole activity is still the second one: what makes it
always-on lives inside the skill, never in a mechanism beside it.

## How a rule stays on

**The description gets it in; the body keeps it in.** The description is the only text read before
loading, so a skill that has to be on for an activity states that activity as its `when` — not a
word the work happens to contain, because the work that needs the rule most is the work that never
names it. Once loaded, a body that does not say it is still in force drifts back out of force
inside the same turn.

The golden rule wants a property and this is not one: it is a judgment, retaken every turn. What
the mechanism does allow is an asymmetric default — in force while unsure, released only on an
explicit word — so the cheap failure is the one that keeps the rule on.

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

The test is the pair at the top of this section, not whether a file comes out. `write-nice-skills`
writes a `SKILL.md` and still stays in place: it judges a `description` against the work in front of
the model, and it hands its rules to another skill that asks for them — neither survives being cut
off from the session.

`agent` and `model` are set only on a fork whose whole job is gathering. One that produces the
artifact gets neither.

## What tools a skill gets

**What the job needs, minus anything that would let it confirm what its reader could not.** The
subtraction bites only where that footing is the product; then fetching belongs to the caller.

Writing back is not confirming, so the subtraction never reaches it. What survives the subtraction
decides whether a skill can post its own output at all, and an explicit ask from the caller decides
whether it does — never a default, and never while running as another skill's step.

Two frontmatter fields, and only one of them subtracts. `allowed-tools` pre-approves what is
already in reach, so an empty list grants nothing and withholds nothing — a subtraction written
there is not a subtraction at all. `disallowed-tools` is the removal, and it is released by the
user's next message rather than by the skill's own return, so it reaches the rest of the turn that
invoked it: a skill that subtracts is one whose caller has already finished needing what it takes.
That is the hand-off rule arriving as a mechanism, and it is what a claim of structural footing has
to be written in. Neither field decides whether one skill may invoke another; that crosses on its
own.

## Where an explanation goes

**What a contributor decides by goes here. What a reader of one artifact needs goes with that
artifact, and that artifact's own rules say where within it.**

**A skill published from here explains itself at its own root.** These go out as a plugin, so each
skill is read, installed and maintained as a unit; the explanation a person needs before adopting
one belongs beside its `SKILL.md`, not in this file and not in the root README, which would carry
thirteen of them and go stale one skill at a time. Nothing references it, so it costs the agent
nothing. `write-nice-skills` deliberately does not ask for one — that is a publishing decision
about this repository, not a rule about how skills are written.

## When an activity earns rules of its own

**One per activity, and every activity gets one.** The bar this replaces — a shape fixed enough to
need named sections, a budget, a template — was set while the standing layer routed, when one skill
loaded at a time and each new one was weighed against the menu it joined. What decides membership
now is whether someone doing this is doing something different, not whether what they produce has a
template. Writing code and writing an issue break the range in opposite directions, so they are
two, and the one with no template is not the one to drop.

## Before a skill is committed

**Its body is measured against its budget, never estimated — and the budget belongs to the set that
stands together, not to the file.** Skills no longer arrive one at a time: a file inside its own
limit can still put an activity over. The standing layer is held tightest of all, being resident
whatever the activity is. The best practice for a `SKILL.md` carries the figures and the counter
that measures them; non-zero means do not commit it yet.

---

Shape from matklad's `ARCHITECTURE.md` (Alex Kladov, 2021).
