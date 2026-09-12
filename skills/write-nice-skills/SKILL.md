---
name: write-nice-skills
description: >
  Use this skill when writing, editing, or reviewing a skill, a SKILL.md, or its description and
  frontmatter — how to write a skill's description and body so it fires reliably and stays lean.
  Also applies when another skill needs the description-writing or skill-length rules. DO NOT use
  this skill when the documentation is not a skill's, or to run a general repo review pass.
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
separate job. It does not decide which frontmatter fields a skill sets, beyond
keeping comments out of them. And it is not for non-skill documentation. It is reached by the `SKILL.md` in front
of you and is finished when that file is, which is why it carries no persistence
clause and leads its own description with a `when`.

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

**Description** (details:
[`references/writing-descriptions.md`](references/writing-descriptions.md)):

1. **Must do: imperative, intent, when, English, short.** `Use this skill when …` —
   third person only where leaving the subject out would make the sentence read as a
   description of the work. Show in one clause what the skill's author wanted
   enforced, name the occasion, and keep the whole inside 1024 characters.
2. **Must not: procedure, criteria, or a name from elsewhere.** Steps let the agent
   act without the body; the criteria the skill applies do the same one level up. A
   sibling skill's name, a file, whoever calls this one: a concrete name reads as a
   routing table and stops the agent asking whether *this* artifact is the skill's,
   and it is spent again on the day it is renamed. Name the artifact, not the skill
   that owns it.
3. **Wording that works.** The first line carries whichever of *what* and *when* the
   agent cannot infer, and one question decides which: does the work name the
   artifact? It does — an issue, a README, a `SKILL.md` — so lead with the when. It
   does not, because the rule holds while someone writes code or a comment, so lead
   with the stance: `Forces the X that Y.`, since an occasion nobody names is one the
   agent forgets. Close with `DO NOT use this skill when …`, the same `when` negated,
   so the pair reads as one condition of use. Front-load the leading word, the term
   the work itself supplies; one trigger per branch, no synonym padding.
4. **Leave the body's identity in the body.** Not the argument for the rule, not the
   cost of breaking it, not the remedy — an agent handed those has been handed the
   skill. The recognisable terms stay: those are what fires.

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
   description is held to this too, by principle 2.
9. **Write frontmatter without comments.** It is the part of a `SKILL.md` that is
   parsed rather than read, and all of it loads on every fire. A field that genuinely
   needs explaining needs prose an author can argue with — the body, or the
   architecture doc — not a trailing `#` every future reader pays for.

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
| "Naming the sibling that owns the other artifact helps the agent route." | It stops the agent asking whether *this* artifact is yours, which is the question the bound exists for, and it comes due again the day that skill is renamed. Name the artifact you are ruling out; a skill is reached by its own description or not at all. |
| "One file is simpler than splitting." | A bloated `SKILL.md` is loaded *every* time the skill fires and drags the whole context. Push branch-only detail behind a pointer. |
| "I'll write the full guide now and trim later." | You won't. Over-long skills ship over-long. Cut to the budget as you write. |
| "This description reads well to me." | You are not the trigger. Check it against the words a *user* types, not against your own summary. |

## References

- Writing or fixing a **description / frontmatter** →
  [`references/writing-descriptions.md`](references/writing-descriptions.md)
- Seeing a description **fixed**, Bad → Good, with what each pair repairs →
  [`references/examples.md`](references/examples.md)
- Deciding **body size, references, or when to split**, or **keeping a skill in
  force** across an activity →
  [`references/structuring-skills.md`](references/structuring-skills.md)
- Measuring a file's real **token cost**, and the byte threshold to aim for →
  [`references/structuring-skills.md`](references/structuring-skills.md#measuring-the-token-half-of-that-budget)
  (runs [`scripts/count-tokens.sh`](scripts/count-tokens.sh))
- Vocabulary (leading word / trigger / branch / progressive disclosure / context
  pointer) → [`GLOSSARY.md`](GLOSSARY.md)
