# Writing the body

Read this when writing or revising the body of a `SKILL.md`.

## Principles

**DO**

- **Open on what the skill does.** This reader is past the firing judgment and has to act.
- **Settle each rule in the file that owns it**, and give each section the shape set out below.
- **Keep an argument beside the rule it changes.** One that changes what the reader does earns its
  place there; one that does not belongs outside the body.

**DON'T**

- **Restate what the skill's own frontmatter already sets** — `context: fork`,
  `user-invocable: false`. It changes nothing the skill does.
- **Explain how the skill fires.** A body is read after firing, so the mechanism is already spent;
  what this reader needs is when to apply it.
- **Name whichever skill happens to invoke this one** — "called during review by
  `write-nice-instructions-as-comment`". It is wrong the day that skill is renamed, and nothing
  checks it.
- **Write the no-op.** It reads as thoroughness and costs a reader the same as a rule that changes
  something.

## The body's shape

```text
## Overview
## When it applies                      — where the description does not settle scope
## How to work
## <the rules, or the routing to them>
## Persistence                          — where the skill stays in force
## Common Rationalizations
## Red Flags
## Verification
```

The guards close it: a skill is talked out of before the work, cut during it, and declared done
after it, and there is one for each.

## Overview

One or two sentences on what the skill does and why that matters. Saying again what the
`description` says is its job here — the description was material for the firing judgment, and this
reader is past that.

Add a second short section, `## When it applies`, only where being in scope is hard to tell from
the description alone: a standing rule the work never names, or an artifact with a near neighbour.
Where the routing conditions themselves name which cases are in scope, they have answered it.

## How to work

The posture the rules are applied with, a bullet at a time: what the author does when they sit down
to the work. The rules each bullet applies stay in the file that owns them.

## The rules

A skill whose rules fit in the body carries them here, each with the cost of ignoring it beside it.

## Routing

A skill with bundled files carries the condition or the question that reaches each file, and leaves
the rules to it — an author who can settle a rule from `SKILL.md` will not open the file it came
from.

## Persistence

A skill that has to be on for a whole activity is loaded once and then competes with everything
that arrives after it. A body that never says it is still in force reads as advice already given,
and the work drifts back to what it was doing.

Say it in these parts: it is in force every response after the one that loaded it; it stays in
force while you are unsure whether the case in front of you counts; it is released on an explicit
condition — the work turning to something the skill does not cover, or being told to stop.

Dropping it too early costs more than leaving it on too long — an extra paragraph of a rule that no
longer applies against a whole response written without one — and the judgment is retaken every
response, so let the cheap failure be the one that leaves the rule on.

## Common Rationalizations

A table of `Rationalization` against `Reality`, which catches the excuse before the step is skipped.
Fill it from what the agent has actually said: add each excuse the first time you have to answer it.

## Red Flags

Bullets, each naming one thing visible in the output — "a description with a step in it" — so the
agent can look for it. A restatement of the rule gives it nothing new to look at.

## Verification

A checklist, settled by looking at the artifact or by running one check against it.

**A box earns its place when what it catches stops the skill working** — it does not load, it never
fires, or it is reached and skimmed past — or when it is a budget. The rest of the rules are met by
reading them where they live, and a checklist that enumerates all of them has become the rule set.

## A sub-skill's body

A parent reaches a sub-skill the way it reaches any skill — by name, through the `Skill` tool — and
passes the brief as one blob. Put **`$ARGUMENTS`** in the sub-skill's body where the brief should
land.
