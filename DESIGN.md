# Design

What settles a decision about this plugin's own shape, so you can make one without reading the
eight skills first. What the skills are *for* is in [`README.md`](README.md); what each one says is
in its own `SKILL.md`.

Every heading below is a decision a contributor actually faces. If yours is not here, that is a gap
in this file, not a licence to induce the answer from what happens to be in `skills/`.

## Where a new entry point goes

**A person decides to invoke it → `commands/`. It has to reach work already underway → a skill.**

The rules have to land on a code comment written halfway through some other task. Nobody stops
there to name a writing skill, so anything that fires only when named would miss the moment it is
most needed. That is what model invocation buys, and it is why every skill here is hidden from the
`/` menu: a skill in the menu invites being typed, and being typed is the case `commands/` already
serves better.

So the two routes are not alternatives for the same thing. A command is what a person types once
they have decided for themselves that they want something written or checked. A skill is what
reaches them when they have decided nothing.

## What a command owes the skill it calls

**Everything unsettled gets settled in the command. What crosses is one brief.**

The same request arrives in several shapes — for an issue: the content is already written; or an
issue exists and needs fetching; or what the issue should even be is still a conversation. Sorting
that out is real work, and all of it is conversation: half-formed asks, fetched material, options
raised and dropped.

A command that hands the skill its raw conversation has put that conversation into the context the
artifact gets written in, and it surfaces in the artifact. Consolidating first is what keeps it
out — and `context: fork` below is what makes that structural rather than remembered.

## What context a skill runs in

**It produces an artifact from a brief → a fork. It acts on work already in front of the model →
the main thread.**

A fork carries in no conversation history, so a skill that never saw the conversation cannot write
from it. "Do not write what only this conversation's participants could reconstruct" stops being a
rule a writer can break and becomes a property they cannot —
`structuring-skills.md` makes the same move to keep two subagents from seeing each other's output.

The criterion cuts the other way just as hard: forking a skill that acts on work already present
would cut it off from the thing it acts on. Routing needs the work in front of it. Constraining
writing has to happen where the writing happens. And a review returns findings, which are worth
nothing without their grounds attached — put a review behind a fork and nobody can review the
review.

All nine, by that criterion:

| Runs in | Skills |
|---|---|
| A fork | `write-nice-issue-description`, `write-nice-instructions`, `write-nice-skills`, `write-nice-design-md` |
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
footing made structural. It cannot resolve a reference or check the repository, which is exactly
the position its reader is in. Granting it `gh` "for convenience" would remove the one property
that makes its verdict mean anything, and fetching therefore belongs to whoever calls it.

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
and every reader pays for it forever. That is the same argument that pushes branch detail down into
`references/`, one level up.

## When an artifact earns rules of its own

**When its shape is fixed enough that a general rule cannot supply it: named sections, a budget, a
template.**

Most writing has no such shape — a code comment, a commit message, a PR description. Those are
served by the test in `dont-make-me-read` plus the two `avoid-*` skills, which is why those two
carry the broadest triggers here.

An issue body, a review finding, a `SKILL.md` and a design doc each cleared that bar, and each got
one `write-*` skill. A new artifact type clears it or it does not; adding a skill for one that does
not costs every future turn the weight of another description to judge.

## What to do when a body is over budget

**Push what only some branches reach into that skill's `references/`, until it passes.**

```bash
bash skills/write-nice-skills/scripts/count-tokens.sh skills/*/SKILL.md
```

Non-zero means do not commit it yet. Which code means what is in the script's own header, and only
one of them is about the budget — the others say the check did not run, which is not a pass.
References have a depth rule and no size rule, so the material is not deleted, only moved off the
path every fire pays for.
