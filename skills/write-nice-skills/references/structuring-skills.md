# Structuring and splitting a skill

Read this when the body is growing, when you are deciding what goes in `SKILL.md` versus a
reference, what to call either, how to keep the skill in force once it has loaded, or whether
to split one skill into two.

## Contents

- What is free and what is not
- The body budget
  - Measuring the token half of that budget
- Staying in force
- Open with what it is, then when it applies
- Guard it three ways
- Naming
- Progressive disclosure: what to inline, what to disclose
- Leave out what the structure already settles
- When to split
- This skill as the worked example

## What is free and what is not

Every installed skill's `name` and `description` are pre-loaded, on every turn, whether
or not the skill is ever used. A bundled file costs nothing until it is read.

Moving a branch into a reference is therefore free until the branch is taken, while moving
it into a second skill pays a description on every turn, forever, for everyone who has it
installed.

## The body budget

The budget belongs to the **set of skills that stand together**. Skills do not arrive one
at a time: a rule that is on for a whole activity is
resident while another skill fires for the artifact in hand, and the reader pays for
both. A file inside its own limit can still put the activity over.

| The skill | Budget | Because |
|---|---|---|
| Always on for a whole activity — resident whatever the reader is doing | **2000 tokens for all of them together** | every turn of every activity pays for them |
| Reached for one artifact or one branch | **5000 tokens each** | only the reader who needs it pays |

So the set to check is every skill that will be standing at once: the ones on for this
activity, summed against the first figure, plus whichever is reached for the artifact in
hand against the second. Measure the set, not the file you happen to be editing.

### Measuring the token half of that budget

Line count is a weak proxy: 5000 tokens buys around 250 lines of English prose but
only around 150 in a non-Latin writing system such as Japanese or Chinese, so a body
can look short by line count and still cost several times the budget. Measure it:

```bash
bash <this skill's directory>/scripts/count-tokens.sh path/to/SKILL.md
TARGET=2000 bash <this skill's directory>/scripts/count-tokens.sh <every always-on SKILL.md>
```

The second line is the always-on budget; sum the reported figures to check the set.

"This skill's directory" is wherever this file was loaded from — a plugin's
install path, `~/.claude/skills/write-nice-skills/`, or a repository's
`.claude/skills/write-nice-skills/`. Resolve it from where you read this file: there is no one absolute path to hard-code.

It sends the file to whichever model is currently default and subtracts a baseline request
without it, so the figure is that model's own count and stays correct as models change. Each
file costs one round trip, and it exits non-zero over budget.

For a free pre-check, count bytes with `wc -c`: bytes per token barely move between
writing systems, where characters per token nearly double between a Latin one and a
non-Latin one. **Under about 15 KB stands in for 5000 tokens today, and 6 KB for 2000.** The script's
closing line re-derives that figure from your own run; recompute it there once the default
model has moved on, since a stale figure that is too low sends you splitting files that were
never over budget.


## Staying in force

A skill that has to be on for a whole activity is loaded once and then competes with
everything that arrives after it. A body that never says it is still in force reads
as advice already given, and the work drifts back to what it was doing.

Say it, in the body, in three parts: it is in force every response after the one that
loaded it; it stays in force while you are unsure whether the case in front of you counts;
it is released on an explicit condition — the work turning to something the skill does not
cover, or being told to stop.

Leaving it on too long and dropping it too early are not equal failures, and the judgment is
retaken every response, so the cheap one has to be the one that leaves the rule on.


## Open with what it is, then when it applies

`## Overview` first: one or two sentences on what the skill does and why that matters. Then
whether the reader is in it. The rules, the procedure and the guards come after.

The second half — whether the reader is in it — earns its place only where the fire is fuzzy: a
standing rule the work never names, or an artifact with a near neighbour. A skill whose next
section is already its inputs or its routing has answered it, and a section that repeats the
description there is a **no-op**.

Whatever argument does not fit those two sentences is either operative — and belongs in the rule
it defends, or in a Common Rationalizations row — or it is not, and it belongs outside the skill.

## Guard it three ways

A skill is talked out of before the work, cut during it, and declared done after it. One
guard for each.

| Section | What it catches | Shape |
|---|---|---|
| **Common Rationalizations** | the excuse, before the step is skipped | a table of `Rationalization` against `Reality` |
| **Red Flags** | the symptom, once it is in the output | bullets: what it looks like, and what it actually is |
| **Verification** | whether the work is finished | a checklist whose every box is settled by looking at the artifact, or by running one check against it |

Fill Common Rationalizations from what the agent has actually said — add each excuse the
first time you have to answer it. A Red Flag names something observable in the output — "three questions in one message" —
so the agent can look for it, where a restatement of the rule gives it nothing new to look
at.

**Two of the three stay inline.** Common Rationalizations is reached in the state where the
agent is hunting for a reason to skip, and an agent in that state does not stop to open a
file. Red Flags has to be in its head while it writes, which is before any review.

**Verification can**, because "before calling the artifact done" is a condition an agent
recognises, which is all a context pointer needs. Disclose it once running it takes more than
reading the list — steps in a fixed order, an expected output to compare each against. Keep it
inline while every box is answered by looking or by one command: three to five of those cost
less inline than the pointer plus the load that follows it.

When it does move, it goes to **`VERIFICATION.md` beside `SKILL.md`**: a standing role of
the skill, under the fixed name every skill's checks share.

## Naming

The skill's own name: lowercase letters, digits and hyphens; at most 64 characters; no
leading, trailing or consecutive hyphen; and the frontmatter `name` equal to the directory
name. `anthropic` and `claude` are reserved and may not appear in it.

**Two files carry a standing role of the skill, and their names are fixed**, so every skill's
sits at the same path and the set is greppable:

| File | What it holds |
|---|---|
| `GLOSSARY.md` | the terms the rules use |
| `VERIFICATION.md` | the checks, once they are a procedure rather than a checklist |

Neither is required. The name is fixed for a skill that has one.

**Everything else the agent loads is branch material, and its name is yours.**
`references/`, `scripts/`, `workflows/`, `assets/`, or a bare file beside `SKILL.md`. Match
whichever neighbour fits and spend no further thought on it.

**A file the agent never loads is outside all of this** — whether one exists at all, and what
it is called, belong to whoever writes it.

## Progressive disclosure: what to inline, what to disclose

- **Inline** in `SKILL.md` what **every path needs**: the overview, how to work, the
  condition that routes to each reference, and the Common Rationalizations guard. Leave the
  rules themselves to the reference that owns each — an author who can settle one from
  `SKILL.md` will not open the file it came from.
- **Disclose** behind a context pointer what **only some branches reach**: deep
  detail, long examples, per-branch procedure.
- **Move out of the skill entirely** what no branch reaches: a file beside `SKILL.md` that
  nothing references is never loaded, so it costs the agent nothing at all — the design
  rationale, the skill explained to a person, where its rules came from.

What the body points at sits **one level deep**. A reference reached from another reference
is read *partially* — the agent previews it with something like `head -100` instead of
reading it whole — so a rule on line 150 of that second hop is a rule nobody read. Every
supporting file links directly from `SKILL.md`, and is found that way; what it is called is
settled under [Naming](#naming). A reference over **100 lines opens with a list of its own
headings**, for the same reason: a partial read still shows what the file contains.

A context pointer names the **condition or the question** that reaches the file: "Read
`references/api-errors.md` when the API returns a non-200 status", or "What an error code
means". The reference loads only when the reader is in that case.

A fact that defies a reasonable assumption stays inline as well: an agent that does not know a
health endpoint answers while its database is down cannot recognise the condition that would have
loaded the file saying so.

A rule's *operative* half stays inline, however little context the agent has to spare. The
excuse "it reads fine to me", answered with "you are supplying the intent the text is missing
as you read it", belongs in Common Rationalizations, where the answer arrives at the moment the
excuse is reached for; in a file nothing loads, it would be read once and agreed with, which is
not the same as applied.

## Leave out what the structure already settles

The frontmatter and the callers already establish a skill's category, who calls it and
where it sits. A sentence repeating any of that changes nothing the skill does, and makes
the skill wrong the day a caller is renamed.

Leave out the no-op, too — the instruction the model already follows unprompted. It reads as
thoroughness and costs a reader the same as a rule that changes something.

## When to split

Scope first. A skill covers a coherent unit of work, the way a function does: narrow it
further and one task loads several skills with instructions to reconcile against each
other, widen it and nothing activates it precisely. Querying a database and formatting the
result is one unit; adding database administration makes it two.

Then split only when the cut earns its cost. Three cuts justify it:

1. **By leading word** — a distinct situation has its *own* leading word you
   actually type. That word can invoke a separate model-invoked skill (or, within
   one skill, gate a separate reference).
2. **By sequence** — a run of steps whose *post-completion* steps should be hidden.
   Isolating that run in its own context clears what follows, so it does not
   distract the work that comes after. First give every step a completion condition
   that is checkable and exhaustive: "the validator exits zero". A sequence that looks
   like it needs a skill of its own usually has one vague condition instead, and the
   agent drifts past it rather than stopping.
3. **By delegation** — a phase that should run in a *different execution
   environment*: its own model, its own tool set, its own context. This cut is about
   who should do the work, where the first two are about what the reader types and
   what comes after. It has a reference of its own, and `SKILL.md` routes to it.

If no cut applies, keep it inline. Splitting for its own sake multiplies either
context load (one more description on every turn) or cognitive load (more files an
author must hold) and buys nothing.


## This skill as the worked example

This skill splits along its own branches, as it asks every skill to:

- the always-needed core stays in `SKILL.md`;
- the branches an author is actually on — *writing a description*, *structuring a
  skill*, *delegating a phase* — each get one reference, and the worked Bad → Good pairs a
  fourth, because writing a description and measuring one against a worked pair are reached at
  different moments;
- shared vocabulary goes in `GLOSSARY.md`.

That is the test: a skill about structure is structured the way it prescribes.
