---
name: write-nice-skills
description: >
  Writes, edits and reviews a skill, a SKILL.md, or its description and frontmatter — how to write a
  skill's description and body so it fires reliably and stays lean. Also applies when another skill
  needs the description-writing or skill-length rules. Does not apply when the documentation is not
  a skill's, or to a general repo review pass.
user-invocable: false
disable-model-invocation: false
context: fork
background: false
allowed-tools: []
---

## Overview

A skill that never fires has no effect, and one that fires and then gets skipped has none either —
both decided by text its author cannot feel. So the rules are not here: they are in the references
this file routes to.

## How to work

- **Check the description against the work, not against your summary of the skill.**
  You are not the trigger.
- **Measure, do not estimate.** Bytes and lines are proxies that drift with the model;
  `scripts/count-tokens.sh` does not.
- **Open the reference.** If you find yourself settling a rule from this file, that is
  the failure above, happening to you.

## Where each decision is settled

| What you are deciding | Read |
|---|---|
| The `description` — what to do, what never to do, and how to choose its lead | [`references/writing-descriptions.md`](references/writing-descriptions.md) |
| Whether a description is actually fixed — Bad → Good, each pair naming what it repairs | [`references/examples.md`](references/examples.md) |
| Body size, what goes in a reference, when to split, how a skill stays in force | [`references/structuring-skills.md`](references/structuring-skills.md) |
| Whether a phase should run as a child skill, and how to write one | [`references/child-skills.md`](references/child-skills.md) |
| What a file really costs the model that loads it | [`references/structuring-skills.md`](references/structuring-skills.md#measuring-the-token-half-of-that-budget), which runs [`scripts/count-tokens.sh`](scripts/count-tokens.sh) |
| What a term here means — leading word, trigger, branch, progressive disclosure, context pointer | [`GLOSSARY.md`](GLOSSARY.md) |

## Frontmatter

Write it without comments. It is the part of a `SKILL.md` that is parsed rather than
read, and all of it loads on every fire. A field that genuinely needs explaining needs
prose an author can argue with — the body, or the architecture doc — not a trailing `#`
every future reader pays for.

This is the one rule stated here rather than routed to: frontmatter has no reference of
its own, and this is the whole of it.

## Common Rationalizations

The agent will look for reasons to skip this skill, and the guard has to be here or it
is skipped with everything else:

| Rationalization | Reality |
|---|---|
| "A shorter description fires more reliably." | It fires on a *shared word*, not on brevity. With no leading word the work supplies, it never links — length is not the lever. |
| "I'll put the steps in the description so it's self-explanatory." | Then the agent acts from the description and never loads the body — the steps you wrote get skipped. |
| "The description should explain why the rule matters, or nobody will take it seriously." | The argument, the cost and the remedy are the skill. Put them where they are read before the body loads and the agent has been handed it already. |
| "Stating when *not* to use it is negative and wastes budget." | A `when` with no bound fires on every neighbouring artifact, and each wrong fire costs the whole body. |
| "Naming the sibling that owns the other artifact helps the agent route." | It stops the agent asking whether *this* artifact is yours, which is the question the bound exists for, and it comes due again the day that skill is renamed. |
| "One file is simpler than splitting." | A bloated `SKILL.md` loads *every* time the skill fires and drags the whole context. |
| "I'll write the full guide now and trim later." | You won't. Over-long skills ship over-long. |
| "This reads well to me." | You are not the reader who decides. Check it against the words the work supplies and the number the script reports. |

## Red Flags

- A rule settled from `SKILL.md` alone, with the reference it came from never opened.
- A description carrying the steps, the criteria it applies, or another skill's name.
- A reference reached from another reference.
- A body that opens on what the skill is not.

## Verification

- [ ] `count-tokens.sh` exits zero for this skill and for the set it stands with.
- [ ] The description names the occasion and the bound, in the third person, inside 1024 characters.
- [ ] Every reference is reached directly from `SKILL.md`, under a stated condition.
- [ ] The cases that should reach the skill were run against it.
