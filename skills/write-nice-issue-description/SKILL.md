---
name: write-nice-issue-description
description: >
  Writes and revises the body of a GitHub issue, and splits a task into several issues where it
  holds more than one problem. Does not apply when the issue is already written and what is wanted
  is an audit of it rather than a revision.
user-invocable: false
disable-model-invocation: false
context: fork
background: false
---

## Overview

This skill writes and revises a GitHub issue body so that an implementer who has this text and the
repository, and was in no conversation about either, can start work and can tell when they are
done. An issue is a **problem statement plus a completion condition**; the gates below decide
what earns a place in it, and they govern every section on both routes — a new draft, and a draft
being tightened.

## How to work

- **Settle what the one problem is before writing a line.** More than one kind of problem under one
  heading is more than one issue, and the split is cheapest before anything is written.
- **Write the problem and the completion condition first**, and make every other section earn its
  place against those two.
- **Run both gates over every section, on both routes.** Drafting decides what to write; revising
  hunts for what the draft already carries that should not be there.
- **Read the repository for the values you would otherwise invent** — the verification commands, the
  paths, the convention a constraint rests on.
- **Judge the draft as someone who was not in this session.** You are supplying the problem from
  memory as you read it, and that is the whole failure mode.

## What the implementer already has

The reader can read the repository, so this issue does not have to explain project context the way
persistent text generally must: point at a location where prose would otherwise explain it. Prose
that explains it both grows the issue and encroaches on the implementer's own judgment.

Session and process context is the opposite case and stays out in full — no conversation log, no
discarded alternatives, no residue only the people in this session could reconstruct. Dropping the
project-context explanation is not a licence to let it back in; an issue is where it is least
excusable, since its reader is never a participant.

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
no fact the first one didn't already state, compress it away. The sentence that opens a Background
holding more than one problem is where this applies with the most force.

### Exception: readers differ

State the same content twice when the readers differ — a screenshot for a human reader, plus a
copy table for a reader who can only read text. When Goal points at an external reference, also
give a text alternative.

A second copy in another language is not a second presentation form; it is duplication.

## The sections

The only sections are Refs / Background / Goal / Acceptance criteria / Affected areas /
Dependencies. Design / Approach, Out of scope, and Verification are not sections here — a section
that exists gets filled, so none of them is in the template either.

Each section carries one kind of content and nothing else, which is what keeps Gate 1's
implementation method and Gate 2's second copy from having anywhere to sit.

## Write it in the language its implementer reads

The language of the repository, its existing issues, and its code review. The gates, the sections
and the template are about the issue's **shape**, and apply the same way whichever language you
write in.

One issue, one language. A second-language restatement of the same content is Gate 2 duplication.

## Which file to read

| The question | Read |
|---|---|
| The skeleton to write the issue into | [`assets/issue-template.md`](assets/issue-template.md) |
| What has to hold in the section you are about to fill, and the contrast that shows the failure | [`references/sections.md`](references/sections.md) |
| The issue already exists, and you are hunting for what should not be there | [`references/revising.md`](references/revising.md) |
| A worked Bad → Good pair for one part of a gate, or a full passing issue body | [`references/examples.md`](references/examples.md) |

Revising stops short of an audit on purpose: you wrote the draft with the problem already in your
head, so a reader's-eye pass over the finished body belongs to whoever called this skill, on either
route.

## Common Rationalizations

| Rationalization | Reality |
|---|---|
| "Explaining the fix helps the implementer get started faster." | It also removes their judgment call, and locks the issue to a codebase shape that may already have moved by the time they start. Point at Affected areas instead — a hunch, not an instruction. |
| "This constraint needs its reason right there, or it looks arbitrary." | The reason is a problem, and problems belong in Background. A reason next to a constraint turns the line back into a paragraph, and the implementation method creeps back in through that paragraph. |
| "Listing the follow-up tasks under Out of scope is honest disclosure." | It duplicates the scope statement Background already needs to make ("this task covers X; Y is #____'s"). Fold it there instead of keeping a second list. |
| "A Verification section makes the checks easier to run." | If its content is already expressible as a checkbox, it is the same content twice. Fold it into Acceptance criteria and drop the section. |
| "I should sketch a couple of implementation options so the reader has context." | Either one satisfies the acceptance criteria, which makes both a choice you should not have surfaced, or you have a real constraint — which belongs in Acceptance criteria with its reason in Background, not as a menu in the body. |
| "These bullets are all about the same file or system, so they're one problem." | Sharing a subject is not sharing a problem — the test is how many kinds of problem the bullets sort into, not what they touch. If you can't write the one-sentence reason they belong together, split into separate issues instead of forcing a shared heading. |

## Red Flags

- `Background` whose subject is an issue number or "this task" rather than a domain entity.
- `Goal` stating your own fix, or a means of verification.
- Acceptance criteria in implementation vocabulary rather than the domain's.
- `Affected areas` telling the implementer what to do to a path.
- A `Design / Approach`, `Out of scope` or `Verification` heading in the draft at all.

## Verification

- [ ] Every `Background` sentence is one the issue's necessity fails without.
- [ ] Every acceptance criterion is a state to satisfy, checkable in the domain's vocabulary.
- [ ] `Goal` reaches every acceptance criterion but the last lint / type-check / test item.
- [ ] No section repeats what another already settled.
- [ ] `Dependencies` holds only what blocks starting, or is gone.
