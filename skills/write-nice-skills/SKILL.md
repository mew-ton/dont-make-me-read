---
name: write-nice-skills
description: >
  Use this skill when writing, editing, or reviewing a skill, a SKILL.md, or its description and
  frontmatter — how to write a skill's description and body so it fires reliably and stays lean.
  Also applies when another skill needs the description-writing or skill-length rules. DO NOT use
  for non-skill documentation, or to run a general repo review pass.
user-invocable: false
disable-model-invocation: false
context: fork
background: false
allowed-tools: []
---

## Scope

This skill is about **authoring a `SKILL.md`** — writing and reviewing a skill's
`description` and body so the skill (a) fires when it should and (b) stays lean
enough to be worth loading. It applies whether you are creating a new skill or
editing an existing one.

It is **not** a general repo review pass — running a checklist over a PR is a
separate job. It is **not** a publish/frontmatter policy document either. And
it is not for non-skill documentation. This skill is the always-on authoring
judgment that sits above those.

The detail lives one level down (see [References](#references)); this file holds
what every author needs no matter which branch they are on.

## Why the description carries the weight

When the agent decides whether to load a skill, the **only** text it reads is the
`description`. The body is not in context yet — it loads *after* the skill fires.
So the description does two load-bearing jobs at once:

1. It must let the agent judge *whether this skill applies* from the description
   alone.
2. It must **not** leak the procedure. If the steps are in the description, the
   agent believes it can act without loading the body, and skips the very
   instructions the skill exists to deliver.

Everything under "Writing the description" follows from this one fact.

## Principles

**Description** (details + Bad/Good examples:
[`references/writing-descriptions.md`](references/writing-descriptions.md)):

1. **The first line carries whichever the agent cannot infer.** Does the work name
   the artifact — an issue, a README, a `SKILL.md`? Lead with the when. Does it not,
   because the rule has to hold while someone writes code or a comment? An occasion
   nobody names is one the agent forgets, so lead with what the skill forces:
   `Forces the X that Y.` Either way name it as the skill's own occasion
   (`Use this skill when …`, not a bare `Apply when …`), and let the last line say
   when it does not apply (`DO NOT use for …`) — an unbounded when fires on
   everything near it.
2. **No procedure.** Never put step-by-step instructions in the description, nor the
   criteria the skill applies; both live in the body. An agent handed the standard
   has no reason to load what qualifies it.
3. **Front-load the leading word.** Put the term that shows up when this skill is
   needed near the start — the shared word between the description and whatever the
   agent is working from is what links them and fires the skill. That is a prompt
   when a person asks; for a skill hidden from the `/` menu it is the work itself.
   Not a slash-separated tag list, not a dressed-up request sentence: a leading word
   inside a natural sentence. That is where rule 1 already puts the `when`, so the
   first line carries both. One trigger per branch (no synonym padding); cut the
   identity the body carries — the argument, the cost, the remedy — and keep only the
   terms the work itself supplies. A skill that has to be on for a whole activity has
   no word to share: name the activity.
4. **English.** Write the description in English, whichever language you prompt in,
   and do not pad it with a second-language keyword list. What the skill *tells the
   agent to write* is a separate question each writing skill answers for itself.

**Body** (details + criteria:
[`references/structuring-skills.md`](references/structuring-skills.md)):

5. **Don't write everything.** Keep the body within the size budget — which belongs
   to the set of skills that stand together, and is tightest for a skill that is on
   for a whole activity — and push branch-specific detail one level down into a file
   the body points at. Inline what every path needs; put behind a pointer what only
   some branches reach.
6. **Add Common Rationalizations.** For any skill an agent might cut corners on,
   pre-empt the excuses (see the table below).
7. **Say it stays in force, when it has to.** A skill that is on for a whole
   activity is loaded once and then competes with everything after it; a body that
   never says it is still in force reads as advice already given.
8. **Leave out what the structure already settles.** A skill does not need to know
   its own category, who calls it, or where it sits — the frontmatter and the
   callers establish all of that, and a sentence saying it changes nothing the
   skill does. It also makes the skill wrong the day a caller is renamed. The
   sibling named inside a `DO NOT` is the one exception: it is bounding this skill's
   own trigger, not recording its position, and it pays for the rename risk by
   stopping a fire that would otherwise land here.

Terms used above (leading word, trigger, branch, progressive disclosure, context
pointer) are defined in [`GLOSSARY.md`](GLOSSARY.md).

## Common Rationalizations

The agent will look for reasons to skip this skill. Close them off:

| Rationalization | Reality |
|---|---|
| "A shorter description fires more reliably." | It fires on a *shared word*, not on brevity. With no leading word the prompt shares, it never links — length is not the lever. |
| "I'll put the steps in the description so it's self-explanatory." | Then the agent acts from the description and never loads the body — the steps you wrote get skipped. Keep procedure in the body. |
| "The description should explain why the rule matters, or nobody will take it seriously." | The argument, the cost and the remedy are the skill. Put them where they are read before the body loads and the agent has been given the skill already — it acts on the summary and confirms nothing. Keep the terms the work supplies; move the reasoning down. |
| "Stating when *not* to use it is negative and wastes budget." | A `when` with no bound fires on every neighbouring artifact, and each wrong fire costs the whole body. The `DO NOT` is the cheaper half of the condition. |
| "One file is simpler than splitting." | A bloated `SKILL.md` is loaded *every* time the skill fires and drags the whole context. Push branch-only detail behind a pointer. |
| "I'll write the full guide now and trim later." | You won't. Over-long skills ship over-long. Cut to the budget as you write. |
| "This description reads well to me." | You are not the trigger. Check it against the words a *user* types, not against your own summary. |

## References

- Writing or fixing a **description / frontmatter** →
  [`references/writing-descriptions.md`](references/writing-descriptions.md)
- Deciding **body size, references, or when to split**, or **keeping a skill in
  force** across an activity →
  [`references/structuring-skills.md`](references/structuring-skills.md)
- Measuring a file's real **token cost**, and the byte threshold to aim for →
  [`references/structuring-skills.md`](references/structuring-skills.md#measuring-the-token-half-of-that-budget)
  (runs [`scripts/count-tokens.sh`](scripts/count-tokens.sh))
- Vocabulary (leading word / trigger / branch / progressive disclosure / context
  pointer) → [`GLOSSARY.md`](GLOSSARY.md)
