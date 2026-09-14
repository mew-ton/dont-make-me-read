# Sizing and splitting a skill

Read this when a skill is growing: what it may cost, how to measure it, what moves into a bundled
file, and whether to split one skill into two.

## What this settles

Every installed skill's `name` and `description` are pre-loaded, on every turn, whether or not the
skill is ever used. A bundled file is not: it is read on the branch that needs it, and by nobody
else.

So a sub-skill and a bundled file cost different things. A sub-skill pays a description on every
turn, forever, for everyone who has it installed, where a file is paid for only by the reader who
opens it. This file settles which one a growing skill has earned.

## The decision

```text
Measure.
├ inside the budget                       → nothing to do
└ over →
    ├ only some branch needs the material → split it into a file
    ├ a cut earns its cost                → split it into a sub-skill
    └ neither                             → look at the skill itself
```

The chapters below run in this order: measuring first, then each way out as the flowchart lists it.

## Measuring it, and the figures

The budget belongs to the **set of skills that stand together**. Skills do not arrive one at a
time: a rule that is on for a whole activity is resident while another skill fires for the artifact
in hand, and the reader pays for both. A file inside its own limit can still put the activity over.

| The skill | Budget | Because |
|---|---|---|
| Always on for a whole activity — its body keeps it in force past the response that loaded it | **2000 tokens for every such `SKILL.md` added up** | every turn of every activity pays for them |
| Reached for one artifact or one branch | **5000 tokens per file** | only the reader who needs it pays |

So check the always-on skills you ship together — the ones you can measure — summed against the
first figure, and each file reached for the artifact in hand against the second. **That sum is the
test, and 2000 is where it fails.** Someone else's always-on skill may be resident alongside yours
and nothing you ship can measure it, so a sum that passes at 1999 still puts the activity over.
Passing is the floor, not the goal. Both figures are this skill's own.

Line count is a weak proxy for either figure — a body can look short by line count and still cost
well over its budget — so measure tokens:

```bash
# files reached for one artifact or one branch, each against 5000
bash <this skill's directory>/scripts/count-tokens.sh path/to/SKILL.md path/to/other-file.md
# every always-on SKILL.md, to add up against 2000
TARGET=2000 bash <this skill's directory>/scripts/count-tokens.sh <every always-on SKILL.md>
```

The script sends each file to whichever model is currently default and subtracts a baseline request
without it, so the figure is that model's own count and stays correct as models change. It prints a
count and a bytes-per-token ratio per file, and exits non-zero when any one file is over `TARGET` —
an environment variable, defaulting to 5000 — so the first command checks an artifact-reached file
outright. The always-on figure is a total, which no per-file exit code can test: run the second line
and add the counts up yourself.

For a free pre-check, count bytes with `wc -c`: bytes per token is the stable ratio, which is why a
byte figure stands in for a token budget at all. **Under about 15 KB stands in for 5000 tokens, and
6 KB for 2000.** Each figure here is a run of the script, rounded: it prints one byte equivalent,
for the model it has just measured on and for the `TARGET` it ran under, so the first command above
prints the 15 KB figure and the second the 6 KB one. Read each off a fresh run once the default
model has changed, since a stale figure that is too low sends you splitting files that were never
over budget. The second command's exit code is not the always-on test — that total is still yours
to add up.

## Splitting the files

Each piece of material goes to one of these places.

- **Inline** in `SKILL.md` what **every path needs**: the body's own sections, and of the guards the
  two an agent has to have in its head — Common Rationalizations and Red Flags.
- **Move out**, behind a pointer that names the condition reaching it, what **only some branches
  reach**: deep detail, long examples, per-branch procedure.
- **Leave unlinked** what no branch reaches: a file beside `SKILL.md` that nothing points at is
  never loaded, so it costs the agent nothing at all — the design rationale, the skill explained to
  a person, where its rules came from.

A file that carries a standing role of the skill has a fixed name, beside `SKILL.md`, so the same
path holds it in every skill and one grep finds all of them:

- **`GLOSSARY.md`** — the terms the rules use
- **`VERIFICATION.md`** — the checks, once they are moved out

Neither is required; the name is fixed for a skill that has one.

**Everything else the agent loads is branch material, and its name is yours.** `references/`,
`scripts/`, `workflows/`, `assets/`, or a bare file beside `SKILL.md`. Use whatever the skill's
other folders already use, and spend no further thought on it.

## The principles of splitting a file

**One level deep.** A file reached from another file is not reliably read whole — the agent may
preview the top of it and move on — so a rule far down that second hop is a rule nobody can be
counted on to have read. Every file the agent loads points directly from `SKILL.md`, and is read on
the branch that needed it.

**A pointer names the condition or the question that reaches the file**: "Read
`references/api-errors.md` when the API returns a non-200 status", or "What an error code means".
The file loads only when the reader is in that case.

**Leave the rules to the file that owns each.** An author who can settle a rule from `SKILL.md`
will not open the file it came from.

**These stay inline however little context the agent has to spare.** A fact that defies a
reasonable assumption, because an agent cannot recognise the condition that would have sent it to a
file whose content it has no reason to expect. And the answer an agent needs at the very moment it
is about to skip — the Common Rationalizations row, the Red Flag — because in a file it never loads,
that answer is advice nobody applies.

**Verification is the guard that may move.** It is the one the agent does not need in its head: the
other two have to catch it mid-thought, where this one is read at the end against a finished
artifact. So there is no condition to meet — when `SKILL.md` is heavy, move the checklist to
`VERIFICATION.md` and reach it by "before calling the artifact done".

## Splitting into a second skill, and its principles

Scope first. A skill covers a coherent unit of work, the way a function does: narrow it further and
one task loads several skills with instructions to reconcile against each other, widen it and
nothing activates it precisely. Querying a database and formatting the result is one unit; adding
database administration makes it two.

Then split only when the cut earns its cost, and the cost is the one at the top of this file: a
sub-skill pays a description on every turn, forever, for everyone who installs it. Splitting for its
own sake multiplies either context load (one more description on every turn) or cognitive load (more
files an author must hold) and buys nothing. These are the cuts that earn it.

### By leading word

A situation has its *own* leading word, and arrives without this skill having fired first. A word
that only ever turns up once the skill is already loaded gates a file inside it, and buys nothing by
becoming a second description on every turn.

### By sequence

A run of steps a caller should be able to reach as one unit, whose intermediate steps nothing after
it needs to see. A sequence that looks like it needs a skill of its own usually has one vague
completion condition instead, and the agent drifts past it rather than stopping — so sharpen each
step's condition until it is checkable and leaves no part of the step unaccounted for ("the
validator exits zero"), and see whether the cut is still wanted.

### By delegation

A phase that should run in a *different execution environment*: its own model, its own tool set, its
own context. This cut settles which execution environment the phase runs in, where the sequence cut
settles which skill the steps live in.

A delegated phase is still the parent's work; it runs somewhere cheaper and narrower, and hands
back what the parent needs instead of the material that produced it. **The test is whether the
caller receives everything it needs to check the work.**

**Delegate mechanical, read-only gathering, enumeration, and parsing** — fetching a PR's comments,
listing changed files, walking a package registry, grounding a design in the repository. It passes
because the answer was all the parent wanted, and the answer comes back whole.

**Delegate a phase that produces an artifact**, handing it a single written brief. It passes because
the artifact comes back whole and the reader judges the thing itself.

**Never delegate a phase whose only product is a verdict.** A review is the case: put its substance
in a sub-skill and the verdicts come back without what each one rests on, so nobody can review the
review.

This is the one cut that puts the sub-skill in its own execution environment, so it is the one whose
frontmatter differs. `SKILL.md` routes to the file that sets those fields, and to the one that says
where the sub-skill's body takes the brief.

### What the sub-skill is

A skill like any other: write it to the rules this one holds. A cut by leading word leaves a
sibling, reached on its own; a cut by sequence or by delegation leaves a phase its parent invokes.

A sub-skill that only ever runs as a phase of its parent takes its name from it:
`<parent-skill-name>-<role>` — `review-nice-issues-change-inventory`,
`write-nice-architecture-docs-repo-grounding`. The prefix is what keeps the pair together in a
directory listing, and a rename touches only files you own: the directory and the frontmatter
`name` on each half, and the parent's body where it invokes the sub-skill by name.

## Looking at the skill itself

Nothing to move and no cut to make means the weight is in the sections that have to stay inline,
and that is mostly the guards — but Common Rationalizations and Red Flags are filled from what
actually happened: one row per excuse you had to answer, one bullet per defect you found in the
output. A thick pair is a count of how often this skill has been talked out of, or got it wrong.
Cutting rows deletes the record and leaves the cause, so the thing to look at is the skill. What to
split out, and what to cut, depends on what that skill holds: the table says something is wrong,
not what.

One worked case. A skill that reviewed a pull request ran a workflow, and every step in that run
had its own reason to be skipped, so the table grew a column saying which step each row answered.
That column was the finding: Rationalization against Reality has no room for a third axis, and
needing one meant the rows belonged to several skills. The answer was a skill per step — the cut
the measurement could not see, which is what this branch is for. Sharpening the steps' conditions
would not have reached it, because none of them was vague; each excuse was about its own step.
