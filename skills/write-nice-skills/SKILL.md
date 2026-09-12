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

This settles how a skill is written: its `description`, so the skill fires when the work needs it,
and its body, so the rules survive the fire. A skill that never fires has no effect, and one that
fires and gets skipped has none either — both decided by text its author cannot feel, having read
the skill already.

## How to work

- **Judge the `description` against the work**, in the words the work supplies: you know what the
  skill says and the agent that must reach it does not.
- **Count tokens with this skill's `scripts/count-tokens.sh`.** Line counts drift between
  writing systems, and the budgets are in tokens.
- **Settle each rule in the reference that owns it**, per the table below.

## Where each decision is settled

| The question | Read |
|---|---|
| What the `description` must do, must never do, and how to lead it | [`references/writing-descriptions.md`](references/writing-descriptions.md) |
| What a fixed description looks like — Bad → Good, each pair naming what it repairs | [`references/examples.md`](references/examples.md) |
| What a body may cost, which sections it carries, what goes in a reference, when to split, how a skill stays in force, what to call its files | [`references/structuring-skills.md`](references/structuring-skills.md) |
| Whether a phase should run as a child skill, how to write one, and what goes in its frontmatter | [`references/child-skills.md`](references/child-skills.md) |
| What a term here means | [`GLOSSARY.md`](GLOSSARY.md) |

## Comments in the frontmatter

Write the frontmatter without comments. All of it loads on every fire, and a field that needs
explaining needs prose an author can argue with — the body — rather than a trailing `#` every
future reader pays for.

## Common Rationalizations

The agent will look for reasons to skip this skill:

| Rationalization | Reality |
|---|---|
| "A shorter description fires more reliably." | It fires on a leading word shared with the work. With none, nothing links it to the task, whatever its length. |
| "I'll put the steps in the description so it's self-explanatory." | Then the agent acts from the description and never loads the body — the steps you wrote get skipped. |
| "The description should explain why the rule matters, or nobody will take it seriously." | The argument, the cost and the remedy are the skill. Put them in the description and the agent has the whole argument before the body loads, so it never loads the body. |
| "Stating when *not* to use it is negative and wastes budget." | A description that names only when it applies fires on every neighbouring artifact too, and each wrong fire costs the whole body. |
| "Naming the skill that owns a neighbouring artifact helps the agent route." | It stops the agent asking whether the artifact in front of it is this skill's, which is the question the bound exists for, and it comes due again the day the skill it names is renamed. |
| "One file is simpler than splitting." | A bloated `SKILL.md` loads *every* time the skill fires and drags the whole context. |
| "I'll write the full guide now and trim later." | You won't. Over-long skills ship over-long. |
| "This reads well to me." | You are supplying the intent the text is missing as you read it. Check it against the words the work supplies and the number the script reports. |

## Red Flags

- A rule stated in `SKILL.md` that a reference already owns.
- A description carrying the steps, the criteria it applies, or another skill's name.
- A reference reached from another reference.
- A body whose opening sentence does not say what the skill does.

## Verification

- [ ] `count-tokens.sh` puts the skill you are writing inside its budget, and the always-on set inside 2000 once summed.
- [ ] The description names when the skill applies and when it does not, in the third person, inside 1024 characters.
- [ ] Every reference is reached directly from `SKILL.md`, under a stated condition.
