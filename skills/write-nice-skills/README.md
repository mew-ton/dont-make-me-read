# write-nice-skills — why it is shaped this way

For whoever maintains this skill. Nothing loads this file: it is not referenced from
`SKILL.md`, so it costs the agent no context.

## Why the rules are not in SKILL.md

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
what the skill was for. The bullet now asks for why / how / routing.
