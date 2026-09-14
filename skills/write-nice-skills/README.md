# write-nice-skills

Writes and edits a skill — its `description`, so the skill fires when the work needs it, and its
body, so the agent reads the rules instead of skipping them.

A skill is reached by its `description` alone: the body is not in context when the agent decides.
So its author judges that `description` against a skill they have already read, and cannot feel
what it looks like to something that has not. The same failure runs one level down — a `SKILL.md`
that restates its own bundled files is one whose files nobody opens.

## The way in

Install the plugin as the [root README](../../README.md) describes. Then either:

- type `/write-skill`, to write or revise one deliberately. The command settles what the skill is
  for, then hands this skill a single brief; or
- edit a `SKILL.md` and let the skill fire on its own.

Either way you never type the skill's own name: `user-invocable: false` keeps it out of the `/`
menu, and `/write-skill` is the plugin command that reaches it.

To measure what a skill costs, from this directory:

```bash
bash scripts/count-tokens.sh path/to/SKILL.md                 # one artifact or one branch: 5000 per file
TARGET=2000 bash scripts/count-tokens.sh <every always-on SKILL.md>   # always on: 2000 for the sum
```

It diffs input-side token counts against whichever model is currently default, so it needs no API
key and nothing is pinned to a model generation. It exits non-zero over `TARGET` per file, which
tests the first line outright. The always-on figure is a total across the skills that stand
together, which no per-file exit code can test — run the second line and add the counts up.

## Where the rest lives

`SKILL.md` routes each decision to the file that settles it. Start there, not here: the table is in
`SKILL.md`, and keeping a second copy of it in this file is how the two drift apart.

## Why the rules are not in SKILL.md

Nothing loads this file: it is not referenced from `SKILL.md`, so it costs the agent no context.
What follows is the reasoning behind the shape, for whoever maintains the skill.

Summarising a bundled file in `SKILL.md` skips that file exactly the way summarising a body in the
`description` skips the body. One mechanism, two levels:

| Summary lives in | Reader skips |
|---|---|
| the `description` | the body |
| `SKILL.md` | the bundled files |

An author who can settle a rule from `SKILL.md` alone has been handed the skill and will not open
the file the rule came from. So `SKILL.md` carries why the skill exists, how to work, and the
condition that routes to each file — and nothing that could be mistaken for the rule itself.

A routing costs a second load. That was weighed and dismissed: the subject here is making a rule
take effect, not minimising loads.

## What stays in SKILL.md anyway

**Common Rationalizations and Red Flags.** They are the guards against skipping, and an agent
hunting for a reason to skip does not stop to open a file. Behind a pointer they would be skipped
along with everything else. Verification is the third guard and the one that may live elsewhere: it
is read at the end, against a finished artifact, not mid-thought.

**The Verification checklist itself**, kept to what stops the skill working — it does not load, it
never fires, it is reached and skimmed past — and to budgets. A checklist that enumerates the rules
has become the rule set, and then nothing downstream of it gets opened either.

## Where `## Scope` came from

It was never a policy. `structuring-skills.md` once listed what to inline as "scope, the core
principles in brief, and the Common Rationalizations guard", and nine of the twelve skills grew a
`## Scope` heading out of that one word. The three that ignored it — `dont-make-me-read`,
`review-nice-issues`, `review-self-contained-docs` — opened with `## Why this exists` or
`## Purpose` instead, and were the only three whose bodies said what the skill was for. Every body
opens with `## Overview` now, and the bullet that started it asks for the body's own sections and
the two guards that have to be in the agent's head.
