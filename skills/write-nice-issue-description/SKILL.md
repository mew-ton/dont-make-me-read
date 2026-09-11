---
name: write-nice-issue-description
description: >
  Use this skill when writing or revising a GitHub issue body — "write an issue", "polish this
  issue draft", "make this existing issue readable" — or when breaking a task down into several
  issues. DO NOT use for a PR review finding (that is write-nice-instructions), for a persistent
  doc's general rationale-vs-process rule (that is avoid-unverifiable-context), or for auditing an
  issue that is already written (that is review-nice-issues).
user-invocable: false
disable-model-invocation: false
context: fork
background: false
allowed-tools: []
---

## Scope

An issue is not a design document; it is a problem statement plus a completion condition. Apply
this once per issue body, whether drafting a new one or revising an existing one.

The reader is the implementer, and they can read the repository. So this issue does not need to
explain project context the way `avoid-reference-detours` asks of persistent text generally —
pointing at a location is enough where prose would otherwise explain it, and prose that explains it
both grows the issue and encroaches on the implementer's own judgment.

What `avoid-unverifiable-context` guards against still applies in full: no conversation log, no discarded
alternatives, no residue that only the people in this session could reconstruct. Dropping the
project-context explanation is not a license to let session/process context back in — if anything,
an issue is exactly where that context is least excusable, since the reader is never a participant.

Two gates below govern every section.

## Language

Write the issue in the language its implementer already reads — the language of the repository, its
existing issues, and its code review. Both gates below are about the issue's **shape**, and the
sections, the two gates, and the template apply the same way whichever language you write in. The
examples here are in English because this skill is; they are not a request to file issues in
English.

One issue, one language. A second-language restatement of the same content is Gate 2 duplication,
not accessibility — see the exception under Gate 2, which covers differing presentation forms and
not differing languages.

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
([`references/sections.md`](references/sections.md), when Background splits into chapters) is
where this applies with the most force.

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

### Per section

| Section | What goes in it |
|---|---|
| **Background / Why** | The facts that make up the problem. Test each sentence: does the issue's necessity fail to hold without it? Subject a domain entity, never an issue number or "this task". |
| **Goal** | What to conform to — a standard's semantics, the existing implementation, a screenshot. Never your own explanation of the fix, and never a verification means. |
| **Acceptance criteria** | Checkboxes in the domain's own vocabulary. A constraint is written as a state to satisfy, with its reason in Background. Lint / type-check / test last. |
| **Affected areas** | Paths that look suspicious right now — a hunch, not a boundary. The parenthetical names what is already there, never what to do to it. |
| **Dependencies** | Only a dependency that blocks starting. Drop the section when nothing does. |

Read [`references/sections.md`](references/sections.md) before filling a section — it holds the
per-section rules and one worked contrast each: Background's subject and when to chapter or
tabulate it, Goal's coverage test, the set an "all" criterion ranges over, and what a parenthetical
may say.

## Revising an existing draft

Revising is a different pass from drafting: instead of deciding what to write, you are hunting for
what the draft already contains that should not be there. Read
[`references/revising.md`](references/revising.md) — an ordered checklist of what to hunt for. It
stops short of an audit on purpose: you wrote the draft with the problem already in your head, so
the `review-nice-issues` run belongs to whoever called this skill, on either route.

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

Worked examples of each gate, and a full passing issue body:
[`references/examples.md`](references/examples.md).

## Related skills

- `review-nice-issues` — audits an already-drafted issue body against these same two gates,
  from a reader's-eye view.
- `write-nice-instructions` — the finding/instruction template and remedy strength; applies
  to PR review comments, not issue bodies.
- `avoid-unverifiable-context` — the rationale-vs-process rule this skill's Background guidance
  draws its "keep the why" half from.
- `avoid-reference-detours` — the same subtraction across documents, where Gate 2 covers repetition
  inside one: a reader reads an issue in order, so a second copy is a re-read, while a fact kept in
  another file costs them a trip.
