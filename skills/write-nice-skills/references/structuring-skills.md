# Structuring and splitting a skill

Read this when the body is growing, when you are deciding what goes in `SKILL.md` versus a
reference, what to call either, what the frontmatter may carry, how to keep the skill in force
once it has loaded, or whether to split one skill into two.

## Contents

- What is free and what is not
- Staying in force
- The body budget
  - Measuring it
- Open with what the skill is
- Guard it three ways
- Naming
- Progressive disclosure: what to inline, what to disclose
- Comments in the frontmatter
- Leave out what changes nothing
- When to split

## What is free and what is not

Every installed skill's `name` and `description` are pre-loaded, on every turn, whether
or not the skill is ever used. A bundled file costs nothing until it is read.

Moving a branch into a reference is therefore free until the branch is taken, while moving
it into a second skill pays a description on every turn, forever, for everyone who has it
installed.

## Staying in force

A skill that has to be on for a whole activity is loaded once and then competes with
everything that arrives after it. A body that never says it is still in force reads
as advice already given, and the work drifts back to what it was doing.

Say it, in the body, in three parts: it is in force every response after the one that
loaded it; it stays in force while you are unsure whether the case in front of you counts;
it is released on an explicit condition — the work turning to something the skill does not
cover, or being told to stop.

Dropping it too early costs more than leaving it on too long — an extra paragraph of a rule that
no longer applies against a whole response written without one — and the judgment is retaken every
response, so let the cheap failure be the one that leaves the rule on.


## The body budget

The budget belongs to the **set of skills that stand together**. Skills do not arrive one
at a time: a rule that is on for a whole activity is
resident while another skill fires for the artifact in hand, and the reader pays for
both. A file inside its own limit can still put the activity over.

Each figure is measured over one file as it is loaded — a `SKILL.md`, or a reference once the
branch that reaches it is taken:

| The skill | Budget | Because |
|---|---|---|
| Always on for a whole activity — its body keeps it in force past the response that loaded it | **2000 tokens for every such `SKILL.md` added up** | every turn of every activity pays for them |
| Reached for one artifact or one branch | **5000 tokens per file** | only the reader who needs it pays |

So the set to check is every skill that will be standing at once: the always-on ones summed
against the first figure, plus whichever is reached for the artifact in hand against the second.
Measure the set, not the file you happen to be editing. You cannot know what else a stranger
installs alongside a published skill, so sum only the always-on skills you ship together, and
treat 2000 as the ceiling for that.

### Measuring it

Line count is a weak proxy: 5000 tokens buys around 250 lines of English prose but
only around 150 in a non-Latin writing system such as Japanese or Chinese, so a body
can look short by line count and still cost well over the budget. Measure it:

```bash
# artifact-reached files, each against 5000
bash <this skill's directory>/scripts/count-tokens.sh path/to/SKILL.md path/to/reference.md
# every always-on SKILL.md, to add up against 2000
bash <this skill's directory>/scripts/count-tokens.sh <every always-on SKILL.md>
```

The script sends each file to whichever model is currently default and subtracts a baseline
request without it, so the figure is that model's own count and stays correct as models change.
Each file costs one round trip. It prints a count and a bytes-per-token ratio per file, and exits non-zero when any one file is
over `TARGET` — an environment variable, defaulting to 5000 — so the first command checks an artifact-reached file
outright. The always-on figure is a total, which no per-file exit code can test: run the
second line and add the counts up yourself.

"This skill's directory" is wherever this file was loaded from — a plugin's install path,
`~/.claude/skills/write-nice-skills/`, or a repository's `.claude/skills/write-nice-skills/`.
Resolve it from where you read this file: there is no one absolute path to hard-code.

For a free pre-check, count bytes with `wc -c`: bytes per token barely move between
writing systems, where characters per token falls sharply between a Latin one and a non-Latin
one — which is what puts the English figure above at 250 lines and the Japanese one at 150. **Under about 15 KB stands in for 5000 tokens today, and 6 KB for 2000.** Work those two figures
out again from the ratio the script reports whenever the default model changes, since a stale
figure that is too low sends you splitting files that were never over budget.


## Open with what the skill is

`## Overview` first: one or two sentences on what the skill does and why that matters. Saying
again what the description says is its job here — the description was material for the firing
judgment, and this reader is past that and has to act.

Give the reader a second short section — `## When it applies` — only where being in scope is hard
to tell from the description alone: a standing rule the work never names, or an artifact with a
near neighbour. Where the next section is already the routing or the first step, that section has
answered it, and adding one is a line the reader would have got through without.

How to work, the rules and the guards come after.

Whatever argument does not fit those opening sentences either changes what the reader does — and
belongs beside the rule it changes — or it does not, and does not belong in the body at all.

## Guard it three ways

A skill is talked out of before the work, cut during it, and declared done after it. One
guard for each.

| Section | What it catches | Shape |
|---|---|---|
| **Common Rationalizations** | the excuse, before the step is skipped | a table of `Rationalization` against `Reality` |
| **Red Flags** | the symptom, once it is in the output | bullets, each naming one thing visible in the output |
| **Verification** | whether the work is finished | a checklist whose every box is settled by looking at the artifact, or by running one check against it |

Fill Common Rationalizations from what the agent has actually said — add each excuse the
first time you have to answer it. A Red Flag names something observable in the output — "a description with a step in it" —
so the agent can look for it, where a restatement of the rule gives it nothing new to look
at.

**Two of the three stay inline.** Common Rationalizations is reached in the state where the
agent is hunting for a reason to skip, and an agent in that state does not stop to open a
file. Red Flags has to be in its head while it writes, which is before any review.

**Verification may be disclosed**, because "before calling the artifact done" is a condition an
agent recognises, which is all the pointer that discloses it needs. Disclose it once running it takes more than
reading the list — steps in a fixed order, an expected output to compare each against. Keep it
inline while every box is answered by looking or by one command: three to five of those cost
less inline than the pointer plus the load that follows it.

When it does move, it goes to **`VERIFICATION.md` beside `SKILL.md`**.

## Naming

The skill's own name: lowercase letters, digits and hyphens; at most 64 characters; no
leading, trailing or consecutive hyphen; and the frontmatter `name` equal to the directory
name. `anthropic` and `claude` are reserved and may not appear in it. A skill that runs as another
skill's delegated phase takes a further rule on top of this one, in the reference that owns
delegation.

**Two files carry a standing role of the skill, and their names are fixed**, so every skill's
sits at the same path and the set is greppable:

| File | What it holds |
|---|---|
| `GLOSSARY.md` | the terms the rules use |
| `VERIFICATION.md` | the checks, once they are disclosed |

Neither is required. The name is fixed for a skill that has one.

**Everything else the agent loads is branch material, and its name is yours.**
`references/`, `scripts/`, `workflows/`, `assets/`, or a bare file beside `SKILL.md`. Use whatever
the skill's other folders already use, and spend no further thought on it.

## Progressive disclosure: what to inline, what to disclose

- **Inline** in `SKILL.md` what **every path needs**: the overview, how to work, the
  condition that routes to each reference, and the Common Rationalizations and Red Flags
  guards. Leave the
  rules themselves to the reference that owns each — an author who can settle one from
  `SKILL.md` will not open the file it came from.
- **Disclose** behind a context pointer what **only some branches reach**: deep
  detail, long examples, per-branch procedure.
- **Move out of the skill entirely** what no branch reaches: a file beside `SKILL.md` that
  nothing references is never loaded, so it costs the agent nothing at all — the design
  rationale, the skill explained to a person, where its rules came from. Whether such a file
  exists, and what it is called, belong to whoever writes it.

What the body points at sits **one level deep**. A reference reached from another reference
is read *partially* — the agent previews it with something like `head -100` instead of
reading it whole — so a rule on line 150 of that second hop is a rule nobody read. Every
supporting file links directly from `SKILL.md`, and is found that way; what it is called is
settled under [Naming](#naming). A reference over **100 lines opens with a list of its own
headings**: a file that long is read in pieces about as often as whole, and the list is what a
piece shows.

A context pointer names the **condition or the question** that reaches the file: "Read
`references/api-errors.md` when the API returns a non-200 status", or "What an error code
means". The reference loads only when the reader is in that case.

A fact that defies a reasonable assumption stays inline as well: an agent cannot recognise the
condition that would have sent it to a file whose content it has no reason to expect.

The half of a rule that changes what the agent does stays inline, however little context it has
to spare. The
excuse "it reads fine to me", answered with "you are supplying the intent the text is missing
as you read it", belongs in Common Rationalizations, where the answer arrives at the moment the
excuse is reached for; in a file nothing loads, it would be read once and agreed with, which is
not the same as applied.

## Comments in the frontmatter

Write the frontmatter without comments. All of the frontmatter loads on every fire, and a field that needs
explaining needs prose an author can argue with — the body — rather than a trailing `#` every
future reader pays for.

## Leave out what changes nothing

Leave out the sentence that restates the frontmatter's mechanics fields, or names whichever skill
happens to invoke this one — "this is a model-invoked skill, called by `x` during review". It
changes nothing the skill does, and it is wrong the day `x` is renamed.

Leave out the no-op, too — the instruction the model already follows unprompted. It reads as
thoroughness and costs a reader the same as a rule that changes something.

## When to split

Scope first. A skill covers a coherent unit of work, the way a function does: narrow it
further and one task loads several skills with instructions to reconcile against each
other, widen it and nothing activates it precisely. Querying a database and formatting the
result is one unit; adding database administration makes it two.

Then split only when the cut earns its cost. Three cuts justify it:

1. **By leading word** — a distinct situation has its *own* leading word, one the prompt or
   the work actually supplies. That word can invoke a separate model-invoked skill (or, within
   one skill, gate a separate reference).
2. **By sequence** — a run of steps a caller should be able to reach as one unit, whose
   intermediate steps nothing after it needs to see. First give every step a completion
   condition that is checkable and exhaustive: "the validator exits zero". A sequence that
   looks like it needs a skill of its own usually has one vague condition instead, and the
   agent drifts past it rather than stopping.
3. **By delegation** — a phase that should run in a *different execution
   environment*: its own model, its own tool set, its own context. This cut settles which
   execution environment the phase runs in, where cut 2 settles which skill the steps live in.

If no cut applies, keep it inline. Splitting for its own sake multiplies either
context load (one more description on every turn) or cognitive load (more files an
author must hold) and buys nothing.
