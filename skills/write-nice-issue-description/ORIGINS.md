# Where these rules sit, and what sits next to them

Nothing points at this file, and nothing should: it is neighbourhood and design rationale for
whoever maintains the skill, not material an agent writing an issue has to load. Keeping it here
keeps it out of the body, where it would cost every reader who is only trying to write an issue.

## Where this skill sits among its neighbours

The body no longer names any of these. A list of the neighbours changed nothing an author does
next, and each name was a dependency on somebody else's file that nothing checks. They are recorded
here for whoever edits the skill.

- `review-nice-issues` — audits an already-drafted issue body against these same gates, from a
  reader's-eye view. This skill stops where that one starts, which is why the description's bound
  takes the audit mode back, and why the routing table says the reader's-eye pass belongs to
  whoever called this skill.
- `write-nice-instructions-as-comment` — the finding/instruction template and remedy strength, for
  text one person reads and can answer back to. Its own description already takes an issue body
  back, so this one spends no characters ruling a review comment out.
- `dont-make-me-read`'s `rules/unverifiable-context.md` — the rationale-versus-process rule, across
  any text read later. "What the implementer already has" is that rule at an issue's granularity:
  the project context goes because the reader can read the repository, and the session residue goes
  because the reader was never a participant.
- `dont-make-me-read`'s `rules/reference-detours.md` — the same subtraction across documents, where
  Gate 2 covers repetition inside one. A reader reads an issue in order, so a second copy is a
  re-read, while a fact kept in another file costs them a trip. Gate 1's reference rule is the point
  the two meet: a reference may stay when the next action is decided without resolving it.
- `dont-make-me-read` — the test underneath Gate 1, at an issue body's granularity: an implementer
  holding only this text and the repository can start, and can tell when they are done.

## Why the description's other two bounds went

The rebuilt description keeps one bound and drops two.

- "when the artifact is a PR review finding" — an occasion naming the body of a GitHub issue never
  reached a review comment, so the clause returned none of the characters it spent.
- "when the question is a persistent doc's general rationale-vs-process rule" — a routing table with
  the skill's name taken out, pointing at a neighbour the occasion does not sweep in.

What survives is the audit mode, because "revises" genuinely reaches an issue that is already
written, and that case is somebody else's entry point.

## Why the template holds no rules

The template used to restate, in HTML comments, nearly every rule in `SKILL.md` and
`references/sections.md` — a third copy, and the one an author would settle a question from instead
of opening the file that owns it. It is now a skeleton: headings, the blanks, and the note saying
which slots may be dropped. That note stays because the skill's own principle is that a section
which exists gets filled, so the skeleton has to say which headings are optional.
