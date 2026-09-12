# write-nice-skills

Writes and reviews a skill — its `description`, so the skill fires when the work needs it,
and its body, so the agent reads the rules instead of skipping them.

A skill is reached by its `description` alone: the body is not in context when the agent
decides. So its author judges that `description` against a skill they have already read,
and cannot feel what it looks like to something that has not. The same failure runs one
level down — a `SKILL.md` that restates its references is a `SKILL.md` whose references
nobody opens.

It does not review documentation that is not a skill's, and it is not a repo-wide review
pass.

## The way in

Install the plugin as the [root README](../../README.md) describes. Then either:

- type `/write-skill`, to write or revise one deliberately; or
- edit a `SKILL.md` and let the skill fire on its own. It is model-invoked — you never type
  its name.

To measure what a skill costs, from this directory:

```bash
bash scripts/count-tokens.sh path/to/SKILL.md              # 5000-token budget
TARGET=2000 bash scripts/count-tokens.sh path/to/SKILL.md   # a skill that is always on
```

It diffs input-side token counts against whichever model is currently default, so it needs
no API key and nothing is pinned to a model generation. It exits non-zero over budget.

## Where the rest lives

`SKILL.md` routes each decision to the file that settles it: `references/writing-descriptions.md`
for the `description`, `references/examples.md` for Bad → Good pairs,
`references/structuring-skills.md` for the body's size and shape and for splitting one skill
into two, `GLOSSARY.md` for the terms those use. Start there, not here.

## Why the rules are not in SKILL.md

Nothing loads this file: it is not referenced from `SKILL.md`, so it costs the agent no
context. What follows is the reasoning behind the shape, for whoever maintains the skill.

Summarising a reference in `SKILL.md` skips that reference exactly the way summarising
a body in the `description` skips the body. One mechanism, two levels:

| Summary lives in | Reader skips |
|---|---|
| the `description` | the body |
| `SKILL.md` | the references |

An author who can settle a rule from `SKILL.md` alone has been handed the skill and will
not open the file the rule came from. So `SKILL.md` carries why the skill exists, how to
work, and the condition that routes to each reference — and nothing that could be
mistaken for the rule itself.

A routing costs a second load. That was weighed and dismissed: the subject here is
making a rule take effect, not minimising loads.

## The two rules that stay in SKILL.md anyway

- **Frontmatter comments.** Frontmatter has no reference of its own, and the rule is one
  sentence, so stating it is not summarising anything.
- **Common Rationalizations.** The table is the guard against skipping. Behind a pointer
  it would be skipped along with everything else.

## Where `## Scope` came from

It was never a policy. `structuring-skills.md` once listed what to inline as "scope, the
core principles in brief, and the Common Rationalizations guard", and nine of the twelve
skills grew a `## Scope` heading out of that one word. The three that ignored it —
`dont-make-me-read`, `review-nice-issues`, `review-self-contained-docs` — opened with
`## Why this exists` or `## Purpose` instead, and were the only three whose bodies said
what the skill was for. Every body opens with `## Overview` now, bounded to the two
sentences that place the reader; the bullet asks for overview / how / routing.
