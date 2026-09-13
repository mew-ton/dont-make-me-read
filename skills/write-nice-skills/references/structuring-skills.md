# Sizing and splitting a skill

Read this when a skill is growing: what it may cost, how to measure it, what moves into a bundled
file, and whether to split one skill into two.

## What this settles

Every installed skill's `name` and `description` are pre-loaded, on every turn, whether or not the
skill is ever used. A bundled file is not: it is read on the branch that needs it, and by nobody
else.

So the two cuts cost different things. A second skill pays a description on every turn, forever,
for everyone who has it installed, where a file is paid for only by the reader who opens it. This
file settles which one a growing skill has earned.

## The decision

```text
Measure.
├ inside the budget                       → nothing to do
└ over →
    ├ only some branch needs the material → split it into a file
    ├ one of the three cuts applies       → split it into a sub-skill
    └ neither                             → look at the skill itself
```

The last branch is the one worth naming. Nothing to move and no cut to make means the weight is in
the sections that have to stay inline, and that is mostly the guards — but Common Rationalizations
and Red Flags are filled from what actually happened: one row per excuse you had to answer, one
bullet per defect you found in the output. A thick pair is a count of how often this skill has been
talked out of, or got it wrong. Cutting rows deletes the record and leaves the cause, so the thing
to look at is the skill: a scope too wide to hold at once, a rule whose cost is never stated, a
description that fires it on work it does not cover. Verification is the one of the three that can
simply move out.

## Measuring it, and the figures

The budget belongs to the **set of skills that stand together**. Skills do not arrive one at a
time: a rule that is on for a whole activity is resident while another skill fires for the artifact
in hand, and the reader pays for both. A file inside its own limit can still put the activity over.

| The skill | Budget | Because |
|---|---|---|
| Always on for a whole activity — its body keeps it in force past the response that loaded it | **2000 tokens for every such `SKILL.md` added up** | every turn of every activity pays for them |
| Reached for one artifact or one branch | **5000 tokens per file** | only the reader who needs it pays |

So check the always-on skills you ship together — the ones you can measure — summed against the
first figure, and each file reached for the artifact in hand against the second. Someone else's
always-on skill may be resident too, which is why the first figure is a ceiling to stay under rather
than one to fill. Both figures are this skill's own, set against what a turn can afford to carry.

Line count is a weak proxy for either figure — a body can look short by line count and still cost
well over its budget — so measure tokens:

```bash
# files reached for one artifact or one branch, each against 5000
bash <this skill's directory>/scripts/count-tokens.sh path/to/SKILL.md path/to/other-file.md
# every always-on SKILL.md, to add up against 2000
bash <this skill's directory>/scripts/count-tokens.sh <every always-on SKILL.md>
```

The script sends each file to whichever model is currently default and subtracts a baseline request
without it, so the figure is that model's own count and stays correct as models change. It prints a
count and a bytes-per-token ratio per file, and exits non-zero when any one file is over `TARGET` —
an environment variable, defaulting to 5000 — so the first command checks an artifact-reached file
outright. The always-on figure is a total, which no per-file exit code can test: run the second line
and add the counts up yourself.

For a free pre-check, count bytes with `wc -c`: bytes per token is the stable ratio, which is why a
byte figure stands in for a token budget at all. **Under about 15 KB stands in for 5000 tokens, and
6 KB for 2000.** Both come from the ratio the script last reported here, rounded to 3 bytes per
token. Work them out again whenever it reports a ratio more than about half a byte from that, since
a stale figure that is too low sends you splitting files that were never over budget.

## Splitting the files

Each piece of material goes to one of three places.

- **Inline** in `SKILL.md` what **every path needs**: the overview, how to work, the condition that
  routes to each file, the `## When it applies` section where the description does not settle
  scope, the `## Persistence` section if the skill is always-on, and all three guards — Common
  Rationalizations, Red Flags, and Verification.
- **Move out**, behind a pointer that names the condition reaching it, what **only some branches
  reach**: deep detail, long examples, per-branch procedure.
- **Leave unlinked** what no branch reaches: a file beside `SKILL.md` that nothing points at is
  never loaded, so it costs the agent nothing at all — the design rationale, the skill explained to
  a person, where its rules came from.

Two files carry a standing role of the skill and their names are fixed, both beside `SKILL.md`, so
the same path holds each of them in every skill and one grep finds all of them:

- **`GLOSSARY.md`** — the terms the rules use
- **`VERIFICATION.md`** — the checks, once they are moved out

Neither is required; the name is fixed for a skill that has one.

**Everything else the agent loads is branch material, and its name is yours.** `references/`,
`scripts/`, `workflows/`, `assets/`, or a bare file beside `SKILL.md`. Use whatever the skill's
other folders already use, and spend no further thought on it.

## The principles of splitting a file

**One level deep.** A file reached from another file is read *partially* — the agent previews it
with something like `head -100` instead of reading it whole — so a rule on line 150 of that second
hop is a rule nobody read. Every file the agent loads points directly from `SKILL.md`, and is read
whole on the branch that needed it, so a rule anywhere in it is a rule that was read.

**A pointer names the condition or the question that reaches the file**: "Read
`references/api-errors.md` when the API returns a non-200 status", or "What an error code means".
The file loads only when the reader is in that case.

**Leave the rules to the file that owns each.** An author who can settle a rule from `SKILL.md`
will not open the file it came from.

**Two things stay inline however little context the agent has to spare.** A fact that defies a
reasonable assumption, because an agent cannot recognise the condition that would have sent it to a
file whose content it has no reason to expect. And the answer an agent needs at the very moment it
is about to skip — the Common Rationalizations row, the Red Flag — because in a file it never loads,
that answer is advice nobody applies.

**Verification is the one guard that may move.** Move it once running it takes more than reading
the list — steps in a fixed order, an expected output to compare each against — and it goes to
`VERIFICATION.md`, reached by "before calling the artifact done". Keep it inline while every box is
answered by looking or by one command, and keep a box run once for the whole skill rather than once
per artifact inline too, procedure and all: the reader meets it once.

## Splitting into a second skill, and its principles

Scope first. A skill covers a coherent unit of work, the way a function does: narrow it further and
one task loads several skills with instructions to reconcile against each other, widen it and
nothing activates it precisely. Querying a database and formatting the result is one unit; adding
database administration makes it two.

Then split only when the cut earns its cost, and the cost is the one at the top of this file: a
second skill pays a description on every turn, forever, for everyone who installs it. Three cuts
justify that.

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
settles which skill the steps live in. Whether a given phase may be delegated at all is a further
test, and `SKILL.md` routes to the file that settles it.

### What the sub-skill is

A skill like any other: write it to the rules this one holds.

If no cut applies, keep it as one skill and read its guards as the measurement they are.

Splitting for its own sake multiplies either context load (one more description on every turn) or
cognitive load (more files an author must hold) and buys nothing.
