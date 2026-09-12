# Structuring and splitting a skill

Read this when the body is growing, when you are deciding what goes in `SKILL.md`
versus a reference, or when you are wondering whether to split one skill into two.

## Contents

- What is free and what is not
- The body budget
- Naming
- Staying in force
- Write the description and the body for different purposes
- Progressive disclosure: what to inline, what to disclose
- Guard it three ways
- Leave out what the structure already settles
- Sharpen the bound before you split a sequence
- When to split
- This skill as the worked example

## What is free and what is not

Every installed skill's `name` and `description` are pre-loaded, on every turn, whether
or not the skill is ever used. A bundled file costs nothing until it is read.

That asymmetry settles most structural questions before they are asked. Moving a branch
into a reference is free until the branch is taken. Moving the same branch into a second
skill buys reach and pays a description on every turn, forever, for everyone who has it
installed. So size alone is never a reason to split one skill into two — that is what a
reference is for.

## The body budget

The budget belongs to the **set of skills that stand together**, not to one file.
Skills do not arrive one at a time: a rule that is on for a whole activity is
resident while another skill fires for the artifact in hand, and the reader pays for
both. A file inside its own limit can still put the activity over.

| The skill | Budget | Because |
|---|---|---|
| On for a whole activity — it is resident whatever the reader is doing | **2000 tokens** | every turn of every activity pays for it |
| Reached for one artifact or one branch | **5000 tokens / 500 lines** | only the reader who needs it pays |

The set to check is every skill that will be standing at once: the ones on for this
activity, plus whichever is reached for the artifact in hand. Its ceiling is the sum
of theirs. Measure the set, not the file you happen to be editing.

- What the body points at sits **one level deep**. A reference reached from another
  reference is read *partially* — the agent previews it with something like `head -100`
  instead of reading it whole — so a rule on line 150 of that second hop is a rule nobody
  read. Every supporting file links directly from `SKILL.md`.
- A reference over **100 lines opens with a list of its own headings**, for the same
  reason: a partial read still shows what the file contains.
- A supporting file is found by being referenced from `SKILL.md`, so its name and
  whether it sits in a directory at all are yours to pick. `references/`, `rules/`,
  `scripts/` and `assets/` are conventions borrowed from example layouts, not
  requirements — match whichever neighbour fits and spend no further thought on it.

### Measuring the token half of that budget

Line count is a weak proxy: 5000 tokens buys around 250 lines of English prose but
only around 150 in a non-Latin script such as Japanese or Chinese, so a body can sit
inside 500 lines and still cost several times the budget. Measure instead of
estimating:

```bash
bash <this skill's directory>/scripts/count-tokens.sh path/to/SKILL.md
TARGET=2000 bash <this skill's directory>/scripts/count-tokens.sh <every always-on SKILL.md>
```

The second line is the always-on budget; sum the reported figures to check the set.

"This skill's directory" is wherever this file was loaded from — a plugin's
install path, `~/.claude/skills/write-nice-skills/`, or a repository's
`.claude/skills/write-nice-skills/`. There is no one absolute path to hard-code,
so resolve it from where you read this file rather than assuming a location.

It diffs the input-side token count of two runs against whichever model is
currently default, so no API key is needed and nothing is pinned to a model
generation. Each file costs one round trip, and it exits non-zero over budget.

For a free pre-check use `wc -c`, not `wc -m` — bytes per token barely move between
scripts, where characters per token nearly double between a Latin script and a
non-Latin one. **Under about 15 KB stands in for 5000 tokens today, and 6 KB for
2000.** The
script's closing line re-derives that figure from your own run; recompute it there
rather than trusting this number once the default model has moved on — a stale
figure that is too low sends you splitting files that were never over budget.

### Measuring the other half: whether it fires

Size says what the skill costs, never whether it is reached. Write the cases that should
reach it before you write the body — a handful of prompts a user would really send — and
run them against the models it will run under, with the skill installed and without. A
skill the cases do not reach has a `description` problem, and no amount of rewriting the
body fixes it.

## Naming

Lowercase letters, digits and hyphens; at most 64 characters; no leading, trailing or
consecutive hyphen; and the frontmatter `name` equal to the directory name. `anthropic`
and `claude` are reserved and may not appear in it.

## Staying in force

A skill that has to be on for a whole activity is loaded once and then competes with
everything that arrives after it. A body that never says it is still in force reads
as advice already given, and the work drifts back to what it was doing.

Say it, in the body, in three parts: it is in force every response and not only the
one that loaded it; it stays in force while you are unsure whether the case in front
of you counts; it is released only on an explicit condition — the work turning to
something the skill does not cover, or being told to stop.

The default is asymmetric on purpose. This is a judgment retaken every response
rather than a property of the system, so the cheap failure has to be the one that
leaves the rule on.

## Write the description and the body for different purposes

**DO**

- Write the `description` as material for one judgment: whether to fire.
- Explain the skill in the body, for the reader who has to understand it once it has fired.
- Let the two overlap; their purposes differ, so the overlap is intended.

**DON'T**

- Cut anything from either because the other already carries it.

## Progressive disclosure: what to inline, what to disclose

- **Inline** in `SKILL.md` what **every path needs**: why the skill exists, how to
  work, the condition that routes to each reference, and the Common Rationalizations
  guard. Not the rules themselves — an author who can settle one from `SKILL.md` will
  not open the reference it came from, which is what a leaked description does to a
  body, one level up.
- **Disclose** behind a context pointer what **only some branches reach**: deep
  detail, long examples, per-branch procedure.
- **Move out of the skill entirely** what no branch reaches: a `README.md` beside
  `SKILL.md` is not referenced from it, so nothing loads it and it costs the agent nothing.
  Put one there when a person needs this skill explained; what it owes that person is the
  README rules' business, not this file's.

A context pointer names the **condition**, not the subject: "Read
`references/api-errors.md` when the API returns a non-200 status" is reachable, and "see
`references/` for details" is not. The reference loads only when that condition is met.

A rule's *operative* half never moves out, however little context the agent has to spare.
"You are supplying the intent the text is missing as you read it" belongs in Common
Rationalizations, where it refutes the excuse at the moment it is reached for; in a README it
would be read once and agreed with, which is not the same as being applied.

## Guard it three ways

A skill is talked out of before the work, cut during it, and declared done after it. One
guard for each.

| Section | What it catches | Shape |
|---|---|---|
| **Common Rationalizations** | the excuse, before the step is skipped | a table of `Rationalization` against `Reality` |
| **Red Flags** | the symptom, once it is in the output | bullets: what it looks like, and what it actually is |
| **Verification** | whether the work is finished | a checklist whose every box is answerable from the artifact |

Fill Common Rationalizations from what the agent has actually said — add each excuse the
first time you have to answer it. A Red Flag is observable rather than a restatement of the
rule: "three questions in one message: that's batching, not interviewing" tells the agent
what to look at, where "do not batch questions" only repeats the rule it already has. A
Verification box nobody can answer from the artifact is a wish, not a check.

**Two of the three cannot be disclosed.** Common Rationalizations is reached in the state
where the agent is hunting for a reason to skip, and an agent in that state does not stop
to open a file. Red Flags has to be in its head while it writes, not only when it comes
back to review.

**Verification can**, because "before calling the artifact done" is a condition an agent
recognises, which is all a context pointer needs. Disclose it once it is a procedure of its
own — steps to run, a script, an expected output to compare against. Keep it inline while
it is a checklist: three to five boxes cost less inline than the pointer plus the load that
follows it.

A fact that defies a reasonable assumption stays inline for the same reason. An agent that
does not know the `/health` endpoint answers while the database is down cannot recognise
the condition that would have loaded the file saying so.

## Leave out what the structure already settles

A skill does not need to state its own category, who calls it, or where it sits. The
frontmatter and the callers establish all of that, a sentence saying it changes nothing
the skill does, and it makes the skill wrong the day a caller is renamed.

Leave out what the model already does unprompted, too. It reads as thoroughness and costs
a reader the same as a rule that changes something.

## Sharpen the bound before you split a sequence

Every step needs a condition that says it is finished, checkable and exhaustive — "the
validator exits zero", not "the code is clean". A run of steps that looks like it needs a
skill of its own usually has one vague bound instead, and the agent drifts past it rather
than stopping. Sharpen the bound first, and split only if it is still a sequence
afterwards.

## When to split

Scope first. A skill covers a coherent unit of work, the way a function does. Too narrow
and one task loads several skills, each with instructions to reconcile against the others;
too broad and nothing activates it precisely. Querying a database and formatting the
result is one unit; adding database administration makes it two.

Then split only when the cut earns its cost. Three cuts justify it. The first two come
from mattpocock's `writing-for-agents` (`skills/productivity/` in `mattpocock/skills`) —
the sequence cut from its own `## When to Split`, the trigger-word cut from the
`SKILL-MECHANICS.md` it discloses:

1. **By trigger word** — a distinct situation has its *own* leading word you
   actually type. That word can invoke a separate model-invoked skill (or, within
   one skill, gate a separate reference).
2. **By sequence** — a run of steps whose *post-completion* steps should be hidden.
   Isolating that run in its own context clears what follows, so it does not
   distract the work that comes after.
3. **By delegation** — a phase that should run in a *different execution
   environment*: its own model, its own tool set, its own context. The cut is not
   about what the reader types, nor about what comes after; it is about who should
   do the work. For how, read [`child-skills.md`](child-skills.md).

If no cut applies, keep it inline. Splitting for its own sake multiplies either
context load (one more description on every turn) or cognitive load (more files an
author must hold) and buys nothing.

## This skill as the worked example

`write-nice-skills` teaches "don't write everything; push branch detail one level
down," so it splits along its own branches:

- the always-needed core stays in `SKILL.md`;
- the branches an author is actually on — *writing a description*, *structuring a
  skill*, *delegating a phase* — each get one reference, and the worked Bad → Good
  pairs a fourth;
- shared vocabulary goes in `GLOSSARY.md`.

A single-file version would contradict the rule it teaches. That is the test: a
skill about structure should be structured the way it prescribes.
