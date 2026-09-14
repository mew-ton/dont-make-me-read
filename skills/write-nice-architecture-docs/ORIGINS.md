# Where these rules came from

Nothing points at this file, and nothing should: it is provenance and design rationale for whoever
maintains the skill, not material an agent writing an architecture doc has to load. Keeping it here
keeps it out of the body, where it would cost every reader who is only trying to write a doc.

## What the skill extends

The sections in `SKILL.md`'s "What the doc owes its reader" are **matklad's `ARCHITECTURE.md`**
(Alex Kladov, 2021), and so are the standing rules named here: keep it short and specify only what
is unlikely to change; name important files, modules and types rather than linking into them; call
out your invariants. His shape is settled, and the skill does not relitigate it.

What the skill adds is the reader who is not navigating but *adding*: each section is written so
that it also places a case the doc has never seen. That is where the conditions under "The rules"
come from — roles over instances, the golden rule above the invariants, the total classification,
the definition another file owns — and it is why "call out your invariants" is sharpened into a
testable question rather than repeated.

The staleness argument behind the arrow test is matklad's link rule one step further in: a
definition copied from the file that owns it goes stale exactly the way a link does, and neither
failure announces itself.

## Where this skill sits among its neighbours

These are the relationships the body no longer spells out, because naming them changed nothing an
author does. They are recorded here for whoever edits the skill next.

- `dont-make-me-read` — the test this one sharpens, and the source of the rule that a constraint is
  stated as the wall the reader would walk into.
- `avoid-unverifiable-context` — what keeps deliberation out of the doc while the rationale stays.
- `avoid-reference-detours` — what settles whether you may restate something at the point of use;
  this skill narrows it for the definitions another file owns.
- `find-document-dependencies` — draws the arrows, so the maintenance-side test can be run rather
  than eyeballed.
- `write-nice-skills` — a `SKILL.md` is an instruction to an agent, not an architecture doc. That
  boundary is settled by each skill's own description and needs no clause in either body.
