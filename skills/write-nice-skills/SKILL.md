---
name: write-nice-skills
description: >
  Writes, edits and reviews a skill, a SKILL.md, or its description and frontmatter — how to write a
  skill's description and body so it fires reliably and stays lean. Also applies when another skill
  needs the rules for writing a description or for sizing a body. Does not apply when the artifact
  is an architecture doc, an issue body, a README, or API or library reference documentation.
user-invocable: false
disable-model-invocation: false
context: fork
background: false
---

## Overview

This skill settles how a skill is written: its `description`, which decides whether the agent reaches for
the skill at all, and its body, which has to survive being reached. A skill nothing reaches has no
effect, and one that is reached and then skimmed past has none either.

## How to work

- **Judge the `description` against the work**, in the words the work supplies: you know what the
  skill says and the agent that must reach it does not.
- **Count tokens with this skill's `scripts/count-tokens.sh`.** A short-looking body can cost well
  over its budget, so the budget is set in tokens.
- **Settle each rule in the reference that owns it**, per the table below.

## Where each decision is settled

| The question | Read |
|---|---|
| What a term here means | [`GLOSSARY.md`](GLOSSARY.md) |
| What the `description` must do, must never do, how to choose the word it fires on, what opens it, how it divides with the body, and how to test that it fires | [`references/writing-descriptions.md`](references/writing-descriptions.md) |
| What a fixed description looks like — Bad → Good, each pair naming what it repairs | [`references/examples.md`](references/examples.md) |
| What a body may cost and how to measure it, which sections it carries, what to leave out, what goes in a reference, when to split, how a skill stays in force, what to call the skill and its files, what its frontmatter carries | [`references/structuring-skills.md`](references/structuring-skills.md) |
| Whether a phase should run as a child skill, what to call it, how to write one, and what goes in its frontmatter | [`references/child-skills.md`](references/child-skills.md) |

## Common Rationalizations

The agent will look for reasons to skip this skill:

| Rationalization | Reality |
|---|---|
| "A shorter description fires more reliably." | It fires on a word shared with the work — one a prompt supplies, or one the work itself already uses. With none, nothing links it to the task, whatever its length. |
| "I'll put the steps in the description so it's self-explanatory." | Then the agent acts from the description and never loads the body — the steps you wrote get skipped. |
| "The description should explain why the rule matters, or nobody will take it seriously." | What the skill forces belongs in the description; *why* forcing it is right — the argument, the cost, the alternatives — is the body's. An agent handed both acts from the description and never loads the body. |
| "Stating when *not* to use it is negative and wastes budget." | A description that names only when it applies fires on every neighbouring artifact too, and each wrong fire costs the whole body. |
| "Naming the skill that owns a neighbouring artifact helps the agent route." | It answers "is this artifact mine?" so the agent stops asking — and that is the one question the description exists to make it ask. It also puts another skill's name in your description, where renaming that skill silently makes yours wrong. |
| "One file is simpler than several." | A bloated `SKILL.md` loads *every* time the skill fires and drags the whole context, where a reference is read only on the branch that needs it. |
| "I'll write the full guide now and trim later." | You won't. Over-long skills ship over-long. |
| "This reads well to me." | You are supplying the intent the text is missing as you read it. Check it against the words the work supplies and the number the script reports. |

## Red Flags

- A `SKILL.md` an author could finish a skill from, with no reference opened.
- A description carrying the steps, the criteria it applies, or another skill's name.
- A description whose head is a slash-separated tag list.
- A reference reached from another reference.
- A body whose opening sentence does not say what the skill does.

## Verification

- [ ] `count-tokens.sh` exits zero over every file the skill you are writing loads for one artifact or one branch.
- [ ] If it is always-on: `count-tokens.sh` over it and every always-on `SKILL.md` it ships alongside, the counts added up, under 2000.
- [ ] The description names the intent — a verb that carries it counts — the occasion and the bound, in the third person, inside 1024 characters, with a reach clause where another skill will need these rules.
- [ ] The description is in English — a single-team skill may add the phrases that team really types — and carries no `<` or `>` in its text.
- [ ] The description shares a word with the prompts or with the work, and the cases that should reach the skill do; the same cases run without it come out worse, so you can see what the description bought.
- [ ] The body opens on what the skill does, carries all three guards, and — if the skill is always-on — a `## Persistence` section in three parts.
- [ ] Every reference is reached directly from `SKILL.md`, under a stated condition or question.
