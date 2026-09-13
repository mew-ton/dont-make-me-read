# Writing the body

Read this when writing or revising the body of a `SKILL.md`.

## Contents

- The shape
- DO
- DON'T
- Overview
- When it applies
- How to work
- The rules, or the routing to them
- Persistence
- Common Rationalizations
- Red Flags
- Verification

## The shape

```md
## Overview
## How to work
## The rules, or the routing to them
## Common Rationalizations
## Red Flags
## Verification
```

Two more sections are conditional: `## When it applies` follows `## Overview` where being in scope
is hard to tell from the description alone, and `## Persistence` comes before the guards where the
skill has to stay in force past the response that loaded it.

The last three are the guards. A skill is talked out of before the work, cut during it, and
declared done after it — one guard for each.

## DO

- **Open on what the skill does.** This reader is past the firing judgment and has to act.
- **Settle each rule in the reference that owns it**, and give each section the shape set out
  below.
- **Keep an argument beside the rule it changes.** One that changes what the reader does earns its
  place there; one that does not belongs outside the body.

## DON'T

- **Restate what the skill's own frontmatter already sets** — `context: fork`,
  `user-invocable: false`. It changes nothing the skill does, and the reader pays for it on every
  fire.
- **Explain how the skill fires.** A body is read after firing, so the mechanism is already spent;
  what this reader needs is when to apply it, which `## When it applies` carries.
- **Name whichever skill happens to invoke this one** — "this is a model-invoked skill, called
  during review by `write-nice-instructions-as-comment`". It is wrong the day that skill is
  renamed, and nothing checks it.
- **Write the no-op.** It reads as thoroughness and costs a reader the same as a rule that changes
  something.

## Overview

One or two sentences on what the skill does and why that matters. Saying again what the
`description` says is its job here — the description was material for the firing judgment, and
this reader is past that.

## When it applies

A second short section, only where being in scope is hard to tell from the description alone: a
standing rule the work never names, or an artifact with a near neighbour — unless the routing
conditions themselves name which cases are in scope, in which case they have answered it and a
section of its own is a line the reader would have got through without.

## How to work

The posture the rules are applied with, a bullet at a time: what the author does when they sit
down to the work. The rules each bullet applies stay in the reference that owns them.

## The rules, or the routing to them

A skill whose rules fit in the body carries them here. One with references carries the condition
or the question that reaches each file instead, and leaves the rules to it — an author who can
settle a rule from `SKILL.md` will not open the file it came from.

## Persistence

A skill that has to be on for a whole activity is loaded once and then competes with everything
that arrives after it. A body that never says it is still in force reads as advice already given,
and the work drifts back to what it was doing.

Say it in three parts: it is in force every response after the one that loaded it; it stays in
force while you are unsure whether the case in front of you counts; it is released on an explicit
condition — the work turning to something the skill does not cover, or being told to stop.

Dropping it too early costs more than leaving it on too long — an extra paragraph of a rule that no
longer applies against a whole response written without one — and the judgment is retaken every
response, so let the cheap failure be the one that leaves the rule on.

## Common Rationalizations

A table of `Rationalization` against `Reality`, which catches the excuse before the step is
skipped. Fill it from what the agent has actually said: add each excuse the first time you have to
answer it.

## Red Flags

Bullets, each naming one thing visible in the output — "a description with a step in it" — so the
agent can look for it. A restatement of the rule gives it nothing new to look at.

## Verification

A checklist, settled by looking at the artifact or by running one check against it.

**A box earns its place when what it catches stops the skill working** — it does not load, it never
fires, or it is reached and skimmed past — or when it is a budget. A Red Flag may name the same
thing: one is read while writing, the other after. The rest of the rules are met by reading them
where they live, and a checklist that enumerates all of them has become the rule set.

Verification is the one guard that may move out of `SKILL.md`. The condition it moves on is a
progressive-disclosure decision, and `SKILL.md` routes to the reference that settles it.
