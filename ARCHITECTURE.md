# Architecture

## Bird's eye view

Text that someone else has to act on costs its reader something before they can act, and the writer
cannot feel that cost — they read their own draft while supplying the context it is missing. This
plugin is the rules that follow, packaged so they reach the writing rather than waiting to be
consulted: skills the model loads on its own judgment mid-task, and commands a person types when
they have decided for themselves that they want something written or checked.

What each rule *is* lives in `README.md`. This file is what settles a decision about the plugin's
own shape, so you can make one without reading the nine skills first.

## Codemap

| Where | What belongs there |
|---|---|
| `commands/` | One file per user-facing entry point. Instruction-layer work: fetching, asking, consolidating a brief. Anything a person decides to invoke. |
| `skills/<name>/SKILL.md` | One skill. The frontmatter the model judges from, and the body every path through it needs. |
| `skills/<name>/references/` | What only some branches of that skill reach — long examples, per-branch procedure. Flat, one level deep. |
| `skills/write-nice-instructions/rules/` | The same idea under an older name: one file per rule, each with one worked example. |
| `skills/write-nice-skills/scripts/` | The one executable here. `count-tokens.sh` measures a body against the token budget. |
| `skills/write-nice-issue-description/assets/` | The issue template a skill hands to its reader whole, rather than describing. |
| `_ja/` | A temporary Japanese mirror of the tree, for reviewing content in a language the author reads faster. Deleted when the review it serves is done; nothing loads from it. |

Every heading below is a decision a contributor actually faces. If yours is not here, that is a gap
in this file, not a licence to induce the answer from what happens to be in `skills/`.

## Cross-cutting concerns and invariants

**No skill is reachable from the `/` menu, and that is a property rather than a preference.** The
rules have to land on a code comment written halfway through some other task. Anything that fires
only when named would miss the moment it is most needed, so the menu is closed and model invocation
is what carries them there.

**A skill never sees the conversation that reached it, when it writes an artifact.** `context: fork`
carries in no history, which turns "do not write what only this conversation's participants could
reconstruct" from a rule a writer can break into a property they cannot.

**A skill never holds a tool that would let it confirm what its reader could not.** The clearest
case is `review-nice-issues`, whose whole verdict is worth something only because it judges from
the same text an implementer holds.

**Nothing in `_ja/` is loaded, referenced, or depended on by anything outside it.** It is a mirror,
and a mirror that something reads becomes a second source of truth.

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
| what only some branches reach | that skill's `references/` |
| what a field means | nowhere in frontmatter |

Frontmatter is the one part of a `SKILL.md` that is parsed rather than read, and all of it loads on
every fire. A trailing `#` there explains the field to nobody who was going to be confused by it,
and every reader pays for it forever — the same argument that pushes branch detail down into
`references/`, one level up.

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

**Push what only some branches reach into that skill's `references/`, until it passes.**

```bash
bash skills/write-nice-skills/scripts/count-tokens.sh skills/*/SKILL.md
```

Non-zero means do not commit it yet. Which code means what is in the script's own header, and only
one of them is about the budget — the others say the check did not run, which is not a pass.
References have a depth rule and no size rule, so the material is not deleted, only moved off the
path every fire pays for.

---

The shape of this file — bird's eye view, then codemap, then cross-cutting concerns — is
matklad's `ARCHITECTURE.md` (Alex Kladov, 2021). `write-nice-architecture-docs` carries it, along
with what this repository adds to it.
