---
name: write-nice-skills
description: >
  Writes and edits a skill for a coding agent — its `SKILL.md`, its description, its frontmatter —
  to the notation and rules that make it fire reliably when the model judges whether to use it, and
  that keep the agent from skipping steps once it has. Also applies when another skill needs the
  rules for writing a description or for sizing a body.
user-invocable: false
disable-model-invocation: false
---

## Overview

This skill settles the notation and rules a `SKILL.md` uses — in its frontmatter and in its body —
and how to split a body once it has grown. That buys:

- a firing condition precise enough that the agent picks the right skill
- instructions the agent carries out instead of skipping
- fewer tokens spent loading the skill, so there is more room for the other skills and instructions
  in context

## How to work

- **Write the description and the body to the notation this skill sets**, taking each from the
  file that owns it, per the table below.
- **Measure what the skill itself costs, every time,** with this skill's `scripts/count-tokens.sh`,
  and judge whether it has become heavy.
- **Correct notation does not get the steps done.** Where the agent skips one anyway, keep the
  notation and improve what the text says.

## Which file to read

| The question | Read |
|---|---|
| What a term here means | [`GLOSSARY.md`](GLOSSARY.md) |
| What the `description` must do, must never do, how to choose the word it fires on, what opens it, how it divides with the body, and how to test that it fires | [`references/writing-descriptions.md`](references/writing-descriptions.md) |
| What a fixed description looks like — Bad → Good, each pair naming what it repairs | [`references/examples.md`](references/examples.md) |
| Which sections the body carries and in what order, what each has to hold, how a skill stays in force, what to leave out of a body, and where a sub-skill's body takes its input | [`references/writing-body.md`](references/writing-body.md) |
| What a skill may cost and how to measure it, what moves into a bundled file and which guard may move there, when to split one skill into a sub-skill, and whether a phase should run in its own execution environment | [`references/structuring-skills.md`](references/structuring-skills.md) |
| Which frontmatter fields to set, what each settles, and which a sub-skill carries | [`references/writing-frontmatter.md`](references/writing-frontmatter.md) |

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

- A `SKILL.md` that settles a rule one of its own bundled files owns, so nobody opens that file.
- A description carrying the steps, the criteria it applies, or another skill's name.
- A description whose head is a tag list or a run of keywords.
- A bundled file reached from another bundled file.
- A body whose opening sentence does not say what the skill does.

## Verification

Each box is here because what it catches stops the skill working, or because it is a budget. The
rules themselves are met by reading them where they live.

- [ ] The frontmatter parses, and `name` matches the directory the skill is in.
- [ ] The description carries no `<` or `>` in its text — otherwise nothing loads.
- [ ] The description is inside 1024 characters.
- [ ] `count-tokens.sh` exits zero over every file the skill loads for one artifact or one branch.
- [ ] If it is always-on: `count-tokens.sh` over it and every always-on `SKILL.md` it ships alongside, the counts added up, under 2000.
- [ ] The cases that should reach the skill do — run them with it installed and without, so a case the description reached is told apart from one the model would have handled anyway.
- [ ] Common Rationalizations and Red Flags are in `SKILL.md` itself, where the agent meets them without opening anything.
- [ ] Every file the skill loads is pointed at directly from `SKILL.md`, under a stated condition or question.
