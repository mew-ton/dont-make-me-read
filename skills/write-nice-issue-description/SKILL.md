---
name: write-nice-issue-description
description: >
  Write a GitHub issue body that an implementer can act on without needing to ask for anything
  more: a determinable problem, checkable acceptance criteria, and an out-of-scope boundary, with
  no implementation method smuggled in and no content duplicated across sections. Apply when
  writing or revising an issue body — "write an issue", "issue を書いて", "この issue のドラフトを
  推敲して", "既存の issue を読みやすくして" — or when breaking a task down into several issues. DO
  NOT use for a PR review finding, for a persistent doc's general rationale-vs-process rule, or for
  auditing an issue that is already written against these same conditions.
disable-model-invocation: false
allowed-tools: []
---

## Scope

An issue is not a design document; it is a problem statement plus a completion condition. Apply
this once per issue body, whether drafting a new one or revising an existing one.

The reader is the implementer, and they can read the repository. So this issue does not need to
explain project context the way `write-self-contained-docs` asks of persistent docs generally —
pointing at a location is enough where prose would otherwise explain it, and prose that explains it
both grows the issue and encroaches on the implementer's own judgment.

What that skill actually guards against still applies in full: no conversation log, no discarded
alternatives, no residue that only the people in this session could reconstruct. Dropping the
project-context explanation is not a license to let session/process context back in — if anything,
an issue is exactly where that context is least excusable, since the reader is never a participant.

Two gates below govern every section.

## Gate 1: determinacy

A reader with no ability to read files or run `gh` beyond what is written in front of them must be
able to fix, from the text alone:

- the problem to solve
- the acceptance criteria
- the boundary of what is out of scope

Not included: which files to touch. Affected areas is only a hunch at the time of writing —
"this area looks suspicious," nothing more considered than that. By the time work starts, files
may have moved, been renamed, or vanished. Only the implementer, reading the current repository,
can fix the actual range.

Do not write the implementation method.

### Decision vs. choice

If a different implementation could still satisfy the acceptance criteria, it is a choice — leave
it out. Anything that depends on the codebase's current structure is a choice, because that
structure is not fixed yet at the time the issue is written.

| Statement | Category | Disposition |
|---|---|---|
| Move and reuse an existing component, or build a new one | choice | omit |
| Reuse an existing i18n key, or add a new one | choice | omit |
| What to pass as a component's props | choice | omit |
| Branch on a 3-way union, or on a separate field's presence | choice | omit |
| Which file, which line, to check | choice | omit |

### When to write a constraint

Write a constraint only when the implementation must be restricted. A constraint's grounds sit
outside the issue itself — a standard's semantics, an existing repository convention, a
performance requirement, a security requirement, a contract with another system.

| Statement | Category | Disposition |
|---|---|---|
| The 410 path reuses the existing `GoneError` | constraint (existing convention) | Acceptance criteria |
| Only the IDs a batch could not resolve get an individual retry | constraint (performance) | Acceptance criteria |
| An existing endpoint's error response does not change | constraint (existing contract) | Acceptance criteria |
| A response shape (e.g. a `ViewModel`) was already fixed at design time, before this issue | constraint (existing contract) | Acceptance criteria, shape in its own block |

Write the constraint as a state to satisfy, inside Acceptance criteria. Never in Affected areas —
Affected areas is only a hunch, with no binding force.

A fixed shape is a constraint, not a choice, the moment something outside this issue already
depends on it — a consumer already coded against it, or a prior design step already settled it.
State that briefly as a criterion ("conforms to the shape below"), and give the shape itself its
own block directly under Acceptance criteria, rather than folding a multi-field interface into one
checkbox line or reaching for a `Design / Approach` section to hold it. The shape is what the
implementation must produce — that is Acceptance criteria's own content — not how to produce it.

Do not attach a reason to the constraint's line. The reason is a problem, and problems belong in
Background. A reason next to a constraint turns the line back into prose, and prose is where the
implementation method creeps back in.

If you mean to leave the decision to the implementer and only want their reasoning reported back,
that does not belong in the issue — it is a general review norm, not per-issue content.

### References

Write a reference so the next action is decided whether or not the reader resolves it.

- A reference that only makes sense once resolved: omit — `#1784 makes X return Y` stalls a reader
  who cannot open #1784, because the sentence's meaning depends on it.
- A reference that closes off further reading: keep — `depends on #1784`. "Out of scope past here"
  is already decided without opening it.
- A bare identifier: keep — `Refs #1558`.

## Gate 2: duplication

Never state the same content in two places. Solve by moving, not deleting — where the content
already has a destination, dropping the section is enough.

| Duplication | Resolution |
|---|---|
| Out of scope restates a list of follow-up tasks | fold into Background's scope statement |
| Out of scope restates a dependency that blocks starting | fold into Dependencies |
| Verification's content is already expressible as Acceptance criteria | drop Verification |
| Goal restates Acceptance criteria in different words | replace with a pointer to what to conform to |
| Background's prose explains how to solve it, not what the problem is | drop the prose (its whereabouts belongs in Affected areas' parenthetical) |
| The same content is written in two languages | keep one language; drop the other |

Duplication also happens inside a single paragraph, not just across sections: a first sentence
states a fact, and a following sentence only explains, exemplifies, or rephrases that same fact.
After writing a paragraph, check whether it compresses to one sentence — if a later sentence adds
no fact the first one didn't already state, compress it away. Background's opening reason sentence
(below, when Background splits into chapters) is where this applies with the most force.

### Exception: readers differ

State the same content twice when the readers differ — a screenshot for a human reader, plus a
copy table for a reader who can only read text. When Goal points at an external reference, also
give a text alternative.

This exception is about differing presentation forms, not differing languages. Write the whole
issue in one language; do not restate the same content in a second language.

## Sections

Use [`assets/issue-template.md`](assets/issue-template.md).

The only sections are Refs / Background / Goal / Acceptance criteria / Affected areas /
Dependencies. Design / Approach, Out of scope, and Verification are not sections here — a section
that exists gets filled, so it stays out of the template too.

### Background / Why

Write the facts that make up the problem. Test each sentence: does the issue's necessity fail to
hold without it? Whether the fact is derivable by reading code is not the test — write it when the
existing behavior *is* the problem, and skip it when the existing behavior is only a lead toward
the fix (its whereabouts is enough, in Affected areas' parenthetical).

- Write (a problem): "`GET /v1/jobs/{id}` returns the same 404 whether the job was deleted, never
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
Decision vs. choice above), and only applies to an entity that stays put for the issue's
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
paragraph-compression rule, above).

Tabulating is a separate axis from chaptering, and the two combine freely: chaptering asks how many
kinds of problem this issue holds; tabulating asks how many requirements *one* kind of problem has,
each with its own current and required state. When there is more than one such requirement, a
sentence per requirement is Gate 2's paragraph-compression rule again, just spread across bullets —
replace it with a table (a blank column, `Actual`, `Requirement`, one row per requirement; see
[`references/examples.md`](references/examples.md)). With only one requirement, keep the sentence;
a table buys nothing over it. A chapter's own requirements can still be tabulated.

### Goal

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

- Don't write (Goal): "Conforms to `architecture.md`, which `make lint-arch` enforces."
- Write (Goal, conformance only): "Conforms to the structure `architecture.md` states."
- Write (Acceptance criteria, verification): "`make lint-arch` passes."

### Acceptance criteria

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

Put lint / type-check / test as the last item, with the target directory named.

### Affected areas

List the file paths that look suspicious at the time of writing — a guess, not a considered range.

Not a scope boundary — a hunch toward where to start, pitched no higher than "this looks
suspicious." By the time work starts, files may have moved, been renamed, or vanished; missing
entries are expected. Do not aim for completeness, and do not spend time confirming the guess —
confirming it is the implementer's first step, not the writer's.

A parenthetical names only what is there, never what to do to it — naming what to do is the
implementation method creeping back in.

- Don't write: `` `createContentsBlockResolver.ts` (add a preview flag) ``
- Write: `` `shared/types/contents/block.ts` (an existing discriminated-union example is
  `OgpResolution` in `_internals/ogp/ogpResolution.ts`) ``

A note describing where something will move to in the future is what-to-do dressed as
what-is-there — it commits the reader to a plan, not an observation.

- Don't write: `` `.claude/skills/` (where layer-specific implementation patterns get split out
  to) ``
- Write: `` `.claude/skills/` (existing layer-specific implementation-pattern docs live here) ``

### Dependencies

Write only a dependency that blocks starting. Do not guess one in.

A follow-up task is not a dependency — that belongs in Background's scope statement. Drop this
section entirely when nothing blocks starting.

## Revising an existing draft

1. Test each Background sentence: does the issue's necessity fail to hold without it? Delete what
   passes. For what remains, check the subject is a domain entity (flag `#\d+` or "this task" as
   subject — the scope statement is the one exception; a path naming the document or code itself
   is fine)
2. Check how many kinds of problem the remaining bullets sort into. More than one kind: split into
   one heading per problem, with a one-sentence opening reason. Can't write that sentence? Split
   into separate issues instead
3. Apply Gate 1: find implementation-method statements and drop the ones that depend on the
   codebase's current structure. Move only issue-external constraints to Acceptance criteria, with
   their grounds written into Background as a problem
4. Strip internal field names and schema vocabulary out of Acceptance criteria; replace with domain
   vocabulary
5. For each Acceptance criteria item, confirm Background states the problem it resolves. An item
   with no corresponding problem asks the implementer to do work with no stated reason
6. Check Affected areas' parentheticals for "what to do" language — including a future-placement
   note — and drop it or replace it with "what is there"
7. Apply Gate 2: drop a section wherever its content already has a destination; compress any
   paragraph whose later sentences only restate its first
8. Check whether Goal restates Acceptance criteria; if so, replace it with a pointer to what to
   conform to
9. Check that Goal covers every Acceptance criteria item. An item Goal doesn't reach is a second
   problem bundled into this issue — split it out
10. Run `review-nice-issues` against the result before treating it as done — do not rely on
    steps 1-9 alone. You wrote this draft with the problem already in your head, which is exactly
    what that skill's judgment has to route around.

## Common Rationalizations

| Rationalization | Reality |
|---|---|
| "Explaining the fix helps the implementer get started faster." | It also removes their judgment call, and locks the issue to a codebase shape that may already have moved by the time they start. Point at Affected areas instead — a hunch, not an instruction. |
| "This constraint needs its reason right there, or it looks arbitrary." | The reason is a problem, and problems belong in Background. A reason next to a constraint turns the line back into a paragraph, and the implementation method creeps back in through that paragraph. |
| "Listing the follow-up tasks under Out of scope is honest disclosure." | It duplicates the scope statement Background already needs to make ("this task covers X; Y is #____'s"). Fold it there instead of keeping a second list. |
| "A Verification section makes the checks easier to run." | If its content is already expressible as a checkbox, it is the same content twice. Fold it into Acceptance criteria and drop the section. |
| "I should sketch a couple of implementation options so the reader has context." | Either one satisfies the acceptance criteria, which makes both a choice you should not have surfaced, or you have a real constraint — which belongs in Acceptance criteria with its reason in Background, not as a menu in the body. |
| "These bullets are all about the same file or system, so they're one problem." | Sharing a subject is not sharing a problem — the test is how many kinds of problem the bullets sort into, not what they touch. If you can't write the one-sentence reason they belong together, split into separate issues instead of forcing a shared heading. |

## Examples

Worked examples of each gate, and a full passing issue body: [`references/examples.md`](references/examples.md).

## Related skills

- `review-nice-issues` — audits an already-drafted issue body against these same two gates,
  from a reader's-eye view.
- `write-nice-instructions` — the finding/instruction template and remedy strength; applies
  to PR review comments, not issue bodies.
- `write-self-contained-docs` — the rationale-vs-process rule this skill's Background guidance
  draws its "keep the why" half from.
