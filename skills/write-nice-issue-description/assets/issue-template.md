<!-- Write this whole issue in the language its implementer already reads (the repository's, the
     tracker's). One language throughout; do not restate content in a second language. -->
Refs #

## Background / Why

<!--
State the facts that make up the problem. Test: does the issue's necessity fail to hold without
this sentence?
Write it when the existing behavior is the problem itself. Skip it when it is only a lead toward
the fix (Affected areas' parenthetical is enough).
When Acceptance criteria states a constraint, write its grounds here, as a problem.
Subject: a domain entity. Not an issue number, "this task" (except the scope statement below). When
the entity is a document/code itself, its path is the subject.
Write only sentences that stay true after this issue closes.
One kind of problem: stay flat. More than one kind: open with one sentence stating why one issue
holds them together, then one heading per problem, each flat — no example/justification on that
opening sentence. Can't write that sentence? They aren't one issue; split.
One kind of problem with more than one requirement the current state fails to meet: a table
(`| | Actual | Requirement |`, one row per requirement), not one sentence per requirement. One
requirement only: keep the sentence.
-->

<!-- Scope statement (the one place this issue itself may be the subject). Declare what this issue owns and what a follow-up owns. Omit this line entirely when there is no follow-up to hand off. -->
This task covers ____. #____ covers ____.

## Goal

<!--
Point at what to conform to: a standard's semantics / the existing implementation / a screenshot /
a copy table.
Prefer "conforms to ____." Do not restate Acceptance criteria in your own words.
When pointing at an image, also give a text alternative.
Covers every Acceptance criteria item — an item it can't reach means split the issue.
No verification means here (an executable command goes to Acceptance criteria's last item).
-->

## Acceptance criteria

<!--
Checkboxes.
No implementation detail (file names, numbers to check, internal field names, schema vocabulary).
Domain vocabulary only.
When the implementation must be restricted, write it here as a state to satisfy. No reason
attached (that goes to Background).
No statement whose disposition depends on the codebase's current structure (whether to reuse an
existing implementation, how to branch, etc.) — that is a choice, not a criterion.
An "all ___" item's set is exactly what its subject's path names — or, when Background states a
table of requirements, the table itself ("every row in the table above now holds," not one checkbox
per row).
-->

- [ ]
- [ ]
- [ ] `pnpm type-check` / `pnpm test` / `pnpm exec biome check .` / `pnpm lint:eslint` passes
      (`<target directory>`)

## Affected areas

<!--
List paths that look suspicious as of when this issue was written — a guess, not a considered
range or a scope boundary.
By the time work starts, they may have moved, been renamed, or vanished. Do not aim for
completeness, and do not spend time confirming the guess.
Parenthetical states only what is there. Never what to do to it (that is the implementation
method again). A future-placement note ("where X will move to") is what-to-do, not what-is-there —
drop it.
-->

- `path/to/file`
- `path/to/file` (<what already exists there, e.g. a prior example or definition>)

## Dependencies

<!--
Only a dependency that blocks starting. Do not guess one in.
A follow-up task is not a dependency — that belongs in Background's scope statement.
Drop this section entirely when nothing blocks starting.
-->

depends on #
