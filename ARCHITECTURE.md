# Architecture

## Bird's eye view

Text that someone else has to act on costs its reader something before they can act, and the writer
cannot feel that cost — they read their own draft while supplying the context it is missing. This
plugin is the rules that follow, packaged so they reach the writing rather than waiting to be
consulted: skills the model loads on its own judgment mid-task, and commands a person types when
they have decided for themselves that they want something written or checked.

Nine skills carry the rules and six commands are the surface a person types. This file is what
settles a decision about that shape — where a new part goes, what context it runs in, what it may
hold — so you can make one without reading the nine first.

## Codemap

| Where | What belongs there |
|---|---|
| `commands/` | One file per user-facing entry point. Instruction-layer work: fetching, asking, consolidating a brief. Anything a person decides to invoke. |
| `skills/<name>/` | One skill. `SKILL.md` is the part that loads; everything else in the directory is there because `SKILL.md` points at it, and is reached no other way. |
| `_ja/` | A temporary Japanese mirror of the tree, for reviewing content in a language the author reads faster. Deleted when the review it serves is done; nothing loads from it. |

Every heading below is a decision a contributor actually faces. If yours is not here, that is a gap
in this file, not a licence to induce the answer from what happens to be in `skills/`.

## Cross-cutting concerns and invariants

### The golden rule

**A rule that has to be remembered will be broken, so build the machinery that makes it a property
instead — and put that machinery where the writing already happens, not where someone would have
to go and fetch it.**

Every decision below is an instance of it. When a new one arrives and this file does not name it,
derive it from here: ask what would have to be remembered, and what arrangement would make
remembering unnecessary.

### The invariants it generates

**No skill is reachable from the `/` menu.** The rules have to land on a code comment written
halfway through some other task. Anything that fires only when named would miss the moment it is
most needed, so the menu is closed and model invocation is what carries them there.

**A skill that writes an artifact never sees the conversation that reached it.** `context: fork`
carries in no history, which turns "do not write what only this conversation's participants could
reconstruct" from a rule a writer can break into a property they cannot.

**A skill never holds a tool that would let it confirm what its reader could not.** The clearest
case is `review-nice-issues`, whose verdict is worth something only because it judges from the same
text an implementer holds. Granting it more would leave the judgment sound only as long as someone
remembered not to use it.

**Nothing outside `_ja/` loads, references, or depends on anything inside it.** A mirror that
something reads becomes a second source of truth, and then staying correct is a thing to remember.

### Out of scope

Deliberately absent, so a contributor does not spend a day rediscovering it:

- No skill judges repo-groundedness, dependency closure, scope, or design — those belong to
  whatever calls one.
- No skill is a general-purpose "review this PR" or "review this issue" entry point.
- No toolchain, package manager, or install path is assumed. A skill that needs a command says to
  read it out of the repository it is running in.
- No description carries a second-language keyword list; a published skill cannot know which
  language its users prompt in.
- No child skills ship here. `write-nice-skills` documents how to write one, which is not the same
  as this plugin having any.

## Where a new entry point goes

**A person decides to invoke it → `commands/`. It has to reach work already underway → a skill.**

That is the invariant above, applied. The two routes are not alternatives for the same thing: a
command is what a person types once they have decided for themselves that they want something
written or checked, and a skill is what reaches them when they have decided nothing.

## What a command owes the skill it calls

**Everything unsettled gets settled in the command. What crosses is one brief.**

The same request arrives in several shapes — for an issue: the content is already written; or an
issue exists and needs fetching; or what the issue should even be is still a conversation. Sorting
that out is real work, and all of it is conversation: half-formed asks, fetched material, options
raised and dropped.

A command that hands the skill its raw conversation has put that conversation into the context the
artifact gets written in, and it surfaces in the artifact. Consolidating first is what keeps it out
— and `context: fork` is what makes that structural rather than remembered.

## What context a skill runs in

**It produces an artifact from a brief → a fork. It acts on work already in front of the model →
the main thread.**

The criterion cuts both ways. Forking a skill that acts on work already present would cut it off
from the thing it acts on: routing needs the work in front of it, constraining writing has to
happen where the writing happens, and a review returns findings, which are worth nothing without
their grounds attached — put a review behind a fork and nobody can review the review.

All nine, by that criterion:

| Runs in | Skills |
|---|---|
| A fork | `write-nice-issue-description`, `write-nice-instructions`, `write-nice-skills`, `write-nice-architecture-docs` |
| The main thread | `dont-make-me-read`, `avoid-unverifiable-context`, `avoid-reference-detours`, `review-nice-issues`, `review-self-contained-docs` |

Which settles the frontmatter. Every skill here:

```yaml
user-invocable: false
disable-model-invocation: false
```

and a fork adds:

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

The subtraction is the part that is easy to miss. `review-nice-issues` judges an issue body the way
an implementer holding only that text would, so `allowed-tools: []` is not thrift: it is that
footing made structural. Granting it `gh` "for convenience" would remove the one property that
makes its verdict mean anything, and fetching therefore belongs to whoever calls it.

Where no such subtraction applies, the skill takes what the job needs — `review-self-contained-docs`
reads the pull request it is judging.

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
and every reader pays for it forever — the same argument that pushes branch detail down into
a file the body points at, one level up.

## When an artifact earns rules of its own

**When its shape is fixed enough that a general rule cannot supply it: named sections, a budget, a
template.**

Most writing has no such shape — a code comment, a commit message, a PR description. Those are
served by the test in `dont-make-me-read` plus the two `avoid-*` skills, which is why those two
carry the broadest triggers here.

An issue body, a review finding, a `SKILL.md` and an architecture doc each cleared that bar, and
each got one `write-*` skill. Adding a skill for an artifact that has not cleared it costs every
future turn the weight of another description to judge.

## What to do when a body is over budget

**Push what only some branches reach into a file beside that `SKILL.md`, until it passes.**

```bash
bash skills/write-nice-skills/scripts/count-tokens.sh skills/*/SKILL.md
```

Non-zero means do not commit it yet. Which code means what is in the script's own header, and only
one of them is about the budget — the others say the check did not run, which is not a pass.
What the body points at has a depth rule and no size rule, so the material is not deleted, only
moved off the path every fire pays for.

The names those files take are not settled here, because nothing settles them: a supporting file is
found by being referenced from `SKILL.md`, and the platform requires no directory and no naming.
`references/`, `rules/`, `scripts/` and `assets/` are what this tree happens to use. Match a
neighbour when one fits and pick a name that reads when none does — neither choice is a decision
this file has any business making for you.

---

The shape of this file — bird's eye view, then codemap, then cross-cutting concerns — is
matklad's `ARCHITECTURE.md` (Alex Kladov, 2021). `write-nice-architecture-docs` carries it, along
with what this repository adds to it.
