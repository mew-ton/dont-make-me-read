---
name: write-nice-skills
description: >
  Writes, edits and reviews a skill, a SKILL.md, or its description and frontmatter — how to write a
  skill's description and body so it fires reliably and stays lean. Also applies when another skill
  needs the rules for writing a description or for sizing a body. Does not apply when the
  documentation is not a skill's.
user-invocable: false
disable-model-invocation: false
context: fork
background: false
allowed-tools: []
---

## Overview

This settles how a skill is written: its `description`, which decides whether the agent reaches for
the skill at all, and its body, which has to survive being reached. A skill nothing reaches has no
effect, and one that is reached and then skimmed past has none either.

## How to work

- **Judge the `description` against the work**, in the words the work supplies: you know what the
  skill says and the agent that must reach it does not.
- **Count tokens with this skill's `scripts/count-tokens.sh`.** Line counts drift between
  writing systems, so a body's budget is set in tokens.
- **Settle each rule in the reference that owns it**, per the table below.

## Where each decision is settled

| The question | Read |
|---|---|
| What the `description` must do, must never do, and how to lead it | [`references/writing-descriptions.md`](references/writing-descriptions.md) |
| What a fixed description looks like — Bad → Good, each pair naming what it repairs | [`references/examples.md`](references/examples.md) |
| What a body may cost, which sections it carries, what goes in a reference, when to split, how a skill stays in force, what to call its files, whether its frontmatter may carry comments | [`references/structuring-skills.md`](references/structuring-skills.md) |
| Whether a phase should run as a child skill, how to write one, and what goes in its frontmatter | [`references/child-skills.md`](references/child-skills.md) |
| What a term here means | [`GLOSSARY.md`](GLOSSARY.md) |

## Common Rationalizations

The agent will look for reasons to skip this skill:

| Rationalization | Reality |
|---|---|
| "A shorter description fires more reliably." | It fires on a leading word shared with the work. With none, nothing links it to the task, whatever its length. |
| "I'll put the steps in the description so it's self-explanatory." | Then the agent acts from the description and never loads the body — the steps you wrote get skipped. |
| "The description should explain why the rule matters, or nobody will take it seriously." | The argument, the cost and the remedy are the skill. Put them in the description and the agent has the whole argument before the body loads, so it never loads the body. |
| "Stating when *not* to use it is negative and wastes budget." | A description that names only when it applies fires on every neighbouring artifact too, and each wrong fire costs the whole body. |
| "Naming the skill that owns a neighbouring artifact helps the agent route." | It answers "is this artifact mine?" for the agent, which is the one question the description exists to make it ask. It also puts another skill's name in your description, where renaming that skill silently makes yours wrong. |
| "One file is simpler than splitting." | A bloated `SKILL.md` loads *every* time the skill fires and drags the whole context. |
| "I'll write the full guide now and trim later." | You won't. Over-long skills ship over-long. |
| "This reads well to me." | You are supplying the intent the text is missing as you read it. Check it against the words the work supplies and the number the script reports. |

## Red Flags

- A `SKILL.md` complete enough to settle an author's question without opening a reference.
- A description carrying the steps, the criteria it applies, or another skill's name.
- A reference reached from another reference.
- A body whose opening sentence does not say what the skill does.

## Verification

- [ ] The token counts are inside the budgets in `references/structuring-skills.md`, for the skill you are writing and for the set it will stand alongside.
- [ ] The description names when the skill applies and when it does not, in the third person, inside 1024 characters.
- [ ] Every reference is reached directly from `SKILL.md`, under a stated condition or question.
