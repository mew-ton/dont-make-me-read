# Where these rules sit, and what sits next to them

Nothing points at this file, and nothing should: it is neighbourhood and design rationale for
whoever maintains the skill, not material an agent running the pass has to load. Keeping it here
keeps it out of `SKILL.md`, where it would cost every reader who is only trying to judge a unit.

## Where the conditions come from

The body no longer names the authoring skills it used to open on. A name in the body is a
dependency on somebody else's file that nothing checks, and a reader part-way through a review does
nothing differently for knowing where a condition was first written down.

- `dont-make-me-read`'s `rules/unverifiable-context.md` — the authoring-time rule behind conditions
  1 and 2, stated from the writer's side, with more examples. Read it if a finding on either
  condition is confusing.
- `dont-make-me-read`'s `rules/reference-detours.md` — the authoring-time rule behind condition 3,
  including why its fix restates rather than deletes. That asymmetry is why condition 3 produces two
  facts here and the other two produce one.

`write-nice-instructions-as-comment` is the exception and stays named in the body: this skill
invokes it to render every finding, and a step that calls something has to say what it calls.

## Why this skill is not a fork

Every other skill in this set that a parent invokes carries `context: fork` / `background: false`.
This one does not, on purpose: its only product is a set of verdicts, and a verdict handed back from
its own execution environment arrives without the unit text and attached code each one rests on, so
nobody can review the review. The pass runs in the caller's context, where the evidence stays
visible.

## What moved where, and why

- The extraction procedure — fetching head content, the two-pass candidate filter, deciding the
  attached code, pulling in continuous unchanged lines — is reached only when the brief names a PR.
  A self-check of text just drafted has one unit and skips it, so it is a bundled file rather than
  body.
- The extraction edge cases went with it, so extraction is settled in one place. `examples.md`
  is now only the condition pairs and the no-comment best case.
- The old `Guardrails` section was a fourth guard: every line of it was either a rule stated twice or
  a Red Flag already present. Its content sits in the rule it belongs to, in Red Flags, or in
  Verification.
