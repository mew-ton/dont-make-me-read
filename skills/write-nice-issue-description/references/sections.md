# Filling each section

Read this before writing a section. `SKILL.md` carries what every section is for; this holds the
rules for getting each one right, and the contrast that shows the failure. Worked examples of the
gates and a full passing issue body are in [`examples.md`](examples.md).

## Background / Why

Write the facts that make up the problem. Test each sentence: does the issue's necessity fail to
hold without it? Whether the fact is derivable by reading code is not the test — write it when the
existing behavior *is* the problem, and skip it when the existing behavior is only a lead toward
the fix (its whereabouts is enough, in Affected areas' parenthetical).

- Write (a problem): "`GET /v1/foo/{id}` returns the same 404 whether the foo was deleted, never
  published, or closed, and does not distinguish why."
- Skip (a lead): "The messaging feature already has a structure for showing a substitute view when
  something is unpublished."

When a constraint lands in Acceptance criteria, write its grounds here, as a problem.

- "Treating a closed listing the same as a transient fetch error would tell a reader the job has
  'closed' even after it becomes visible again on recovery."

Subject the sentence on a domain entity — not an issue number or "this task." Write only sentences
that stay true after the issue closes.

- Don't write: "#1784 makes the article body's job link return a 4-state view model."
- Write: "A job card shown in an article can be in one of these states: closed, the job no longer
  exists, or fetch failed."

When the domain entity a sentence is about is itself a document or a piece of code, its path *is*
the domain entity — write the path as the subject, not a prose description of it. A description
makes the reader resolve which file it means; a path is already resolved.

- Don't write: "The backend's layer boundary rule document says circular dependencies are
  disallowed."
- Write: "The rules under `.claude/rules/backend/` say circular dependencies are disallowed."

This states an existing fact about that entity — it is not an instruction to go look there. Telling
the reader which file to open to find an answer is a different thing, an implementation step (see
Decision vs. choice in [`SKILL.md`](../SKILL.md)), and only applies to an entity that stays put for the issue's
lifetime — a standing rule set, a schema, a convention doc. Not a guess about where in the code a
fix will land; that guess is Affected areas' job, and its paths are expected to move before work
starts.

The one exception is the scope statement, where the issue itself may be the subject — declare what
this issue owns and what a follow-up owns.

- "This task covers the backend's 410 path and the view model's type and resolver. The rendering
  component's follow-through is #1851's."

When the bullets span more than one kind of problem, do not leave them flat. The test is how many
kinds of problem the bullets sort into — one kind stays flat, as in every example above. More than
one kind splits into one heading per problem, each internally flat.

Whether a single bullet reads as a problem on its own is not that test. A bullet belonging to a
single problem often does not stand alone either — it is one fact among several that jointly make
up that problem. What decides a split is how many distinct problems the bullets belong to, not
whether any one bullet is self-sufficient.

When it splits, open with one sentence stating why one issue holds every problem together, then one
heading per problem. If you cannot write that one sentence, the problems do not belong in one
issue — split into separate issues instead of chaptering a single Background; needing chapters is
the symptom that the issue may be two, not something to fix by adding structure.

The opening sentence stays one sentence, with no example or justification tacked onto it (Gate 2's
paragraph-compression rule in [`SKILL.md`](../SKILL.md)).

Tabulating is a separate axis from chaptering, and the two combine freely: chaptering asks how many
kinds of problem this issue holds; tabulating asks how many requirements *one* kind of problem has,
each with its own current and required state. When there is more than one such requirement, a
sentence per requirement is Gate 2's paragraph-compression rule again, just spread across bullets —
replace it with a table (a blank column, `Actual`, `Requirement`, one row per requirement; see
[`examples.md`](examples.md)). With only one requirement, keep the sentence;
a table buys nothing over it. A chapter's own requirements can still be tabulated.

## Goal

Point at what to conform to: a standard's semantics, the existing implementation, a screenshot, a
copy table.

Do not write Goal as your own explanation — "conforms to X" is the strongest form it takes.

- "Conforms to the messaging feature's job card appearance" (existing implementation + screenshot +
  copy table)
- "404 / 410 semantics conform to RFC 9110" (a standard)

Goal covers every Acceptance criteria item except the last lint/type-check/test item — that item
is how the work gets checked, not something to conform to. When any other item conforms to
something Goal doesn't point at, the issue is bundling more than one problem — split it.

Do not put a verification means in Goal. An executable verification command belongs in Acceptance
criteria's last item, not here.

- Don't write (Goal): "Conforms to `architecture.md`, which the architecture lint enforces."
- Write (Goal, conformance only): "Conforms to the structure `architecture.md` states."
- Write (Acceptance criteria, verification): "The architecture lint passes" — naming the command
  this repository actually runs for it.

## Acceptance criteria

Write as checkboxes.

No implementation detail — no file names or numbers to check, no internal field name or schema
vocabulary. Write in the domain's own vocabulary.

- Don't write: "`published_version_id` is set, but the version it points at is unpublished → return
  410."
- Write: "Return 410 when the listing was published in the past and is now unpublished."

When a criterion requires "all" of something, the set is exactly what the subject's path names —
or, when Background states a table of requirements, the table itself ("every row in the table above
now holds," rather than expanding each row back into its own checkbox). An "all" with no path or
table behind it cannot be checked, because no one can tell which set it ranges over.

- Don't write: "All backend architecture docs state the same dependency direction."
- Write: "All architecture docs under `.claude/rules/backend/` and `backend/docs/` state the same
  dependency direction."

When the implementation must be restricted, write it here as a state to satisfy, with no reason
attached (the reason goes to Background). When that restriction is a shape a consumer already
depends on — a response's fields, a `ViewModel` — write a short criterion pointing at it and give
the shape its own block right here, rather than either omitting it as a "choice" or squeezing a
multi-field interface into one checkbox line.

Put lint / type-check / test as the last item, with the target directory named. The commands are
whatever this repository actually runs — read them out of its own scripts or docs rather than
assuming a toolchain.

## Affected areas

List the file paths that look suspicious at the time of writing — a guess, not a considered range.

Not a scope boundary — a hunch toward where to start, pitched no higher than "this looks
suspicious." By the time work starts, files may have moved, been renamed, or vanished; missing
entries are expected. Do not aim for completeness, and do not spend time confirming the guess —
confirming it is the implementer's first step, not the writer's.

A parenthetical names only what is there, never what to do to it — naming what to do is the
implementation method creeping back in.

- Don't write: `` `createFooResolver.ts` (add a preview flag) ``
- Write: `` `path/to/types.ts` (an existing discriminated-union example is
  `FooResolution` in `_internals/foo/fooResolution.ts`) ``

A note describing where something will move to in the future is what-to-do dressed as
what-is-there — it commits the reader to a plan, not an observation.

- Don't write: `` `.claude/skills/` (where layer-specific implementation patterns get split out
  to) ``
- Write: `` `.claude/skills/` (existing layer-specific implementation-pattern docs live here) ``

## Dependencies

Write only a dependency that blocks starting. Do not guess one in.

A follow-up task is not a dependency — that belongs in Background's scope statement. Drop this
section entirely when nothing blocks starting.
