# Architecture

## Bird's eye view

Text that someone else has to act on costs its reader something before they can act, and the writer
cannot feel that cost — they read their own draft while supplying the context it is missing. This
plugin is the rules that follow from that, arranged so they reach the writing rather than waiting
to be consulted.

Two things carry the weight. An **entry point** installs the disposition: the test to apply, what
may never be cut to satisfy it, and where the rules for the artifact in hand are. A **best practice
per artifact** holds the shape that one kind of artifact takes — its sections, its budgets, the
conditions it has to satisfy — for artifacts whose shape is fixed enough to have one.

Everything else exists to serve the second: the fine-grained rules that hold whatever the text is
and so apply underneath every artifact, and those same conditions run backwards over text already
written, because a writer cannot judge their own draft. Neither is a separate concern with its own
reason to exist; both are what a best practice needs in order to be applied, and to be checked.

**A best practice is held by a skill, so that skill has to be insulated from what it judges.**
Running it inside the session that has been arguing about the artifact lets that session's context
reach the thing meant to be holding the standard, and the standard bends toward whatever was just
said. So an artifact is produced from outside the working session — a person arrives through a
command, an agent through a fork. That is what the fork protects, and it is why a producing skill
is not simply called in place.

## Codemap

The layout is the plugin format's, and nothing here invents one: entry points and skills sit where
that format puts them. A skill is a directory whose `SKILL.md` is the part that loads; every other
file in it is reached by being referenced from `SKILL.md` and by no other route, which is why the
names those files take are the author's to pick.

Every heading below is a decision a contributor actually faces. If yours is not here, that is a gap
in this file, not a licence to induce the answer from whatever happens to be in the tree today.

## Cross-cutting concerns and invariants

### The golden rule

**A rule that has to be remembered will be broken, so build the machinery that makes it a property
instead — and put that machinery where the writing already happens, not where someone would have
to go and fetch it.**

Every decision below is an instance of it. When a new one arrives and this file does not name it,
derive it from here: ask what would have to be remembered, and what arrangement would make
remembering unnecessary.

### The invariants it generates

**No skill is reachable by being named from a menu.** The rules have to land on a code comment
written halfway through some other task. Anything that fires only when named would miss the moment
it is most needed, so being chosen by the model on its own judgment is the only way in.

**A skill that produces an artifact never sees the conversation that reached it.** Carrying in no
history keeps out two things at once: the residue a reader could never check, and the pressure a
session puts on the standard meant to judge its output. Both would otherwise be things someone had
to remember to resist.

**A skill never holds a tool that would let it confirm what its reader could not.** Where a verdict
is worth something precisely because it was reached from what the reader holds, any tool beyond
that leaves it sound only as long as someone remembers not to use it.

### Out of scope

Deliberately absent, so a contributor does not spend a day rediscovering it:

- A skill judges its own axis and nothing else. Whether a claim is grounded in the repository,
  whether the dependencies close, whether the scope is right — those belong to whatever called it.
- Nothing here is a general-purpose "review this" entry point. A pass names the conditions it
  applies and answers for those.
- No toolchain, package manager, or install path is assumed. A skill that needs a command says to
  read it out of the repository it is running in.
- No description carries a second-language keyword list. A published skill cannot know which
  language its users prompt in.

## Where a new entry point goes

**A person decides to invoke it → something they can type. It has to reach work already underway →
a skill.**

That is the first invariant, applied. The two routes are not alternatives for the same thing: one
is what a person reaches for once they have decided for themselves that they want something written
or checked, and the other is what reaches them when they have decided nothing.

## What a command owes the skill it calls

**Everything unsettled gets settled before the hand-off. What crosses is one brief.**

The same request arrives in several shapes: the content is already written; or it exists somewhere
and needs fetching; or what it should even be is still a conversation. Sorting that out is real
work, and all of it is conversation — half-formed asks, fetched material, options raised and
dropped.

Handing that conversation on puts it into the context the artifact gets written in, and it surfaces
in the artifact. Consolidating first is what keeps it out; producing the artifact outside the
session is what makes that structural rather than remembered.

## What context a skill runs in

**It produces an artifact from a brief → outside the session. It acts on work already in front of
the model → in place.**

The insulation argument above is one direction of this. The criterion cuts the other way just as
hard: isolating a skill that acts on work already present would cut it off from the thing it acts
on. Routing needs the work in front of it. Constraining writing has to happen where the writing
happens. A pass that returns findings returns them worth nothing without their grounds attached —
isolate it and nobody can review the review.

Which settles the frontmatter. Every skill here:

```yaml
user-invocable: false
disable-model-invocation: false
```

and one that produces an artifact adds:

```yaml
context: fork
background: false
```

`background: false` because the caller shows the result in the same turn. Leave `agent` and `model`
unset: both narrow a fork to what a *gathering* run needs, and a read-only tool set cannot write
the artifact the fork exists to produce.

## What tools a skill gets

**Whatever its own job needs — minus anything that would let it confirm what its reader could
not.**

The subtraction is the part that is easy to miss, and it bites only where the skill's whole value
is the footing it judges from. A pass that has to reach a verdict the way someone holding only the
text would gets nothing that resolves a reference or checks a repository, because that footing is
the product; fetching then belongs to whoever calls it. Where no such footing is at stake, the
skill takes what the job needs.

## Where an explanation goes

**By who has to hold it, and how often.**

| The explanation is | It goes |
|---|---|
| what a contributor decides by | here |
| what every path through a skill needs | that skill's body |
| what only some branches reach | a file beside that skill's `SKILL.md`, pointed at from it |
| what a field means | nowhere in frontmatter |

Frontmatter is the one part of a `SKILL.md` that is parsed rather than read, and all of it loads on
every fire. A trailing `#` there explains the field to nobody who was going to be confused by it,
and every reader pays for it forever — the same argument that pushes branch detail one level down,
one level up.

## When an artifact earns rules of its own

**When its shape is fixed enough that a general rule cannot supply it: named sections, a budget, a
template.**

Most writing has no such shape, and is served by the entry point's test plus the rules that hold
whatever the text is. Adding a best practice for an artifact that has not cleared the bar costs
every future turn the weight of another description to judge, and buys a template nobody needed.

## What to do when a body is over budget

**Push what only some branches reach into a file beside that `SKILL.md`, until it passes.**

```bash
bash skills/write-nice-skills/scripts/count-tokens.sh skills/*/SKILL.md
```

Non-zero means do not commit it yet. Which code means what is in the script's own header, and only
one of them is about the budget — the others say the check did not run, which is not a pass. What
the body points at has a depth rule and no size rule, so the material is not deleted, only moved
off the path every fire pays for.

---

The shape of this file — bird's eye view, then codemap, then cross-cutting concerns — is matklad's
`ARCHITECTURE.md` (Alex Kladov, 2021).
