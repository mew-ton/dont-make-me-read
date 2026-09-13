---
name: write-nice-skills
description: >
  Writes and edits a skill for a coding agent — its `SKILL.md`, its description, its frontmatter.
  Applies the notation and rules that make the skill fire reliably when the model judges whether to
  use it, and that keep the agent from skipping steps once it has. Also applies when another skill
  needs the rules for writing a description or for sizing a body.
user-invocable: false
disable-model-invocation: false
---

## Overview

This skill settles the notation and rules a `SKILL.md` uses — in its frontmatter and in its body —
and how to split a body once it has grown. That buys three things:

- a firing condition precise enough that the agent picks the right skill
- instructions the agent carries out instead of skipping
- fewer tokens spent loading the skill, so there is more room for the other skills and instructions
  in context, and less chance of the model garbling them

## How to work

- **Write the description and the body to the notation this skill sets**, taking each from the
  file that owns it, per the table below.
- **Measure what the skill itself costs, every time,** with this skill's `scripts/count-tokens.sh`,
  and judge whether it has become heavy. Split a heavy one by the splitting rules.
- **Correct notation does not get the steps done.** Where the agent skips one anyway, keep the
  notation and improve what the text says.

## Which file to read

| The question | Read |
|---|---|
| What a term here means | [`GLOSSARY.md`](GLOSSARY.md) |
| What the `description` must do, must never do, how to choose the word it fires on, what opens it, how it divides with the body, and how to test that it fires | [`references/writing-descriptions.md`](references/writing-descriptions.md) |
| What a fixed description looks like — Bad → Good, each pair naming what it repairs | [`references/examples.md`](references/examples.md) |
| Which sections the body carries and in what order, what each has to hold, how a skill stays in force, and what to leave out of a body | [`references/writing-body.md`](references/writing-body.md) |
| What a skill may cost and how to measure it, what moves into a bundled file and which guard may move there, and when to split one skill into two | [`references/structuring-skills.md`](references/structuring-skills.md) |
| Which frontmatter fields to set, and what each settles | [`references/writing-frontmatter.md`](references/writing-frontmatter.md) |
| Whether a phase should run as a child skill, what a fork buys, and what to call it | [`references/child-skills.md`](references/child-skills.md) |

## Common Rationalizations

The agent will look for reasons to skip this skill:

| Rationalization | Reality |
|---|---|
| "A shorter description fires more reliably." | It fires on a word shared with the work — one a prompt supplies, or one the work itself already uses. With none, nothing links it to the task, whatever its length. |
| "I'll put the steps in the description so it's self-explanatory." | Then the agent acts from the description and never loads the body — the steps you wrote get skipped. |
| "The description should explain why the rule matters, or nobody will take it seriously." | What the skill forces belongs in the description; *why* forcing it is right — the argument, the cost, the alternatives — is the body's. An agent handed both acts from the description and never loads the body. |
| "Stating when *not* to use it is negative and wastes budget." | A description that names only when it applies fires on every neighbouring artifact too, and each wrong fire costs the whole body. |
| "Naming the skill that owns a neighbouring artifact helps the agent route." | It answers "is this artifact mine?" so the agent stops asking — and that is the one question the description exists to make it ask. It also puts another skill's name in your description, where renaming that skill silently makes yours wrong. |
| "One file is simpler than several." | A bloated `SKILL.md` loads *every* time the skill fires and drags the whole context, where a bundled file is read only on the branch that needs it. |
| "I'll write the full guide now and trim later." | You won't. Over-long skills ship over-long. |
| "This reads well to me." | You are supplying the intent the text is missing as you read it. Check it against the words the work supplies and the number the script reports. |

## Red Flags

- A `SKILL.md` an author could finish a skill from, with no other file opened.
- A description carrying the steps, the criteria it applies, or another skill's name.
- A description whose head is a tag list or a run of keywords.
- A bundled file reached from another bundled file.
- A body whose opening sentence does not say what the skill does.

## Verification

- [ ] `count-tokens.sh` exits zero over every file the skill you are writing loads for one artifact or one branch.
- [ ] If it is always-on: `count-tokens.sh` over it and every always-on `SKILL.md` it ships alongside, the counts added up, under 2000.
- [ ] The description names the intent — a verb that carries it counts — and the occasion, in the third person, inside 1024 characters, with a bound where the occasion sweeps something in and a reach clause where another skill will need these rules.
- [ ] The description is in English (a single-team skill may add its team's own phrases).
- [ ] The description carries no `<` or `>` in its text.
- [ ] The description shares a word with the prompts or with the work, and the cases that should reach the skill do — run with it installed and without, so a case the description reached is told apart from one the model would have handled anyway.
- [ ] The body opens on what the skill does and carries Common Rationalizations, Red Flags and Verification — the last inline, or in `VERIFICATION.md` behind a pointer — plus `## When it applies` where the description does not settle scope, and `## Persistence` in three parts if the skill is always-on.
- [ ] The frontmatter `name` equals the directory name and is inside the platform's limits.
- [ ] Every file the skill loads is pointed at directly from `SKILL.md`, under a stated condition or question.
