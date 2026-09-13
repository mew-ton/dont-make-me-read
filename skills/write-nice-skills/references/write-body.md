# Writing the body

Read this when writing or revising the body of a `SKILL.md`: which sections it carries, in what
order, what each has to hold, and what to leave out of it.

## Contents

- The body's shape, and what opens it
- Staying in force
- Guard it three ways
- Leave out what changes nothing

## The body's shape, and what opens it

`## Overview` first: one or two sentences on what the skill does and why that matters. Saying
again what the description says is its job here — the description was material for the firing
judgment, and this reader is past that and has to act.

Give the reader a second short section — `## When it applies` — only where being in scope is hard
to tell from the description alone: a standing rule the work never names, or an artifact with a
near neighbour — unless the routing conditions themselves name which cases are in scope, in which
case they have answered it and a section of its own is a line the reader would have got through
without.

Everything else comes after: how to work, the condition that routes to each reference, the
`## Persistence` section if the skill is always-on, and the three guards below.

## Staying in force

A skill that has to be on for a whole activity is loaded once and then competes with
everything that arrives after it. A body that never says it is still in force reads
as advice already given, and the work drifts back to what it was doing.

Say it in the body, in a `## Persistence` section, in three parts: it is in force every response after the one that loaded it; it stays in force while you are unsure whether the case in front of you counts;
it is released on an explicit condition — the work turning to something the skill does not
cover, or being told to stop.

Dropping it too early costs more than leaving it on too long — an extra paragraph of a rule that
no longer applies against a whole response written without one — and the judgment is retaken every
response, so let the cheap failure be the one that leaves the rule on.

## Guard it three ways

A skill is talked out of before the work, cut during it, and declared done after it. One
guard for each.

| Section | What it catches | Shape |
|---|---|---|
| **Common Rationalizations** | the excuse, before the step is skipped | a table of `Rationalization` against `Reality` |
| **Red Flags** | the symptom, once it is in the output | bullets, each naming one thing visible in the output |
| **Verification** | whether the work is finished | a checklist |

Fill Common Rationalizations from what the agent has actually said — add each excuse the
first time you have to answer it. A Red Flag names something observable in the output — "a description with a step in it" —
so the agent can look for it, where a restatement of the rule gives it nothing new to look
at.

Verification is the one of the three that may move out of `SKILL.md`; the condition it moves on is a
progressive-disclosure decision, and `SKILL.md` routes to the reference that settles it.

**A box earns its place when what it catches stops the skill working** — it does not load, it never
fires, or it is reached and skimmed past — or when it is a budget. A Red Flag may name the same
thing: one is read while writing, the other after. The rest of the rules are met by reading them
where they live, and a checklist that enumerates all of them has become the rule set.

## Leave out what changes nothing

Leave out of a body the sentence that restates what that skill's own frontmatter already sets —
`context: fork`, `user-invocable: false` — or that names whichever skill happens to invoke it —
"this is a model-invoked skill, called during review by `write-nice-instructions-as-comment`".
Neither changes what the skill does, and the second is wrong the day that skill is renamed.

Leave out the no-op, too. It reads as thoroughness and costs a reader the same as a rule that
changes something.

And leave out the argument that changes nothing. An argument that does change what the reader does
belongs beside the rule it changes; one that does not belongs outside the body.
