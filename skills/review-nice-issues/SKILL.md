---
name: review-nice-issues
description: >
  Runs a determinacy-and-duplication pass over the text of a GitHub issue body that is already
  written — someone else's, or the author's own draft. Does not apply as a general-purpose "review
  this issue" entry point, when the issue is still being written or revised, or when what is wanted
  is a judgement of repo-groundedness, dependency closure, or scope.
user-invocable: false
disable-model-invocation: false
disallowed-tools:
  - Read
  - Grep
  - Glob
  - Bash
  - Edit
  - Write
  - WebFetch
  - WebSearch
  - Agent
---

## Overview

This skill judges an issue body that is already written as the implementer who holds only that
text — no conversation about it, no requirement carried in from elsewhere, no repository to look
anything up in. It settles whether that text fixes what such a reader has to have fixed, and
whether any of its content is stated twice.

## The brief

The issue body arrives as **`$ARGUMENTS`** — the text itself. Never ask for an issue number or a
repo instead: fetching is the caller's job, and everything a fetch would put in front of you beyond
the body is what this pass has to do without.

## Judging the body

- **Judge exactly the text you were handed, as it stands** — not the requirement behind it, not what
  you meant when you wrote it, not anything you know about the repository it will land in. A finding
  that rests on what you already know is one the body's own reader could never have made.
- **Read every section, and never search for a phrasing instead.** A pattern search returns the
  wordings you already thought of, and the defect is in the ones you did not.
- **Leave whether a referenced file or symbol actually exists to whoever is allowed to look.** That
  is repo-groundedness, a different pass, and a finding here that turns on it rests on nothing the
  text shows.

## Gate 1: determinacy

Using **only** the body's own text — no repository lookup, no filling in what you happen to know —
check that the text fixes each of these:

- **The problem.** Read `Background / Why` alone. Does it state a fact whose absence would leave
  the issue's necessity unexplained? A sentence that only makes sense to someone who already knows
  the requirement (subject is an issue number, a filename, or "this task," outside the one
  permitted scope statement) does not fix the problem for this reader.
- **The acceptance criteria.** Read `Acceptance criteria` alone. Is each checkbox stated in domain
  vocabulary, with no internal field name, schema vocabulary, file name, or line number standing in
  for a spec? A criterion phrased as an implementation step ("check `published_version_id`...")
  fails even when it happens to be correct.
- **The boundary.** Read `Goal`, `Dependencies`, and `Background`'s scope statement (if one is
  present). Can this reader tell where their responsibility ends — what this issue does not ask
  them to decide, and what blocks them from starting at all? `Affected areas` settles neither this
  nor a fact missing from `Background`: it is a hunch with no binding force, and taking it for the
  boundary passes a body whose reader still cannot tell what is theirs to decide.

Separately, scan every section for the implementation method itself:

- **Smuggled implementation.** A statement whose disposition would not change if a different
  implementation were chosen (which component to reuse, what to pass as props, how to branch) is a
  choice, not a criterion or an affected-area note — flag it wherever it appears.
- **A constraint with its reason attached.** A checkbox or bullet that carries its own justification
  inline, instead of stating the constraint alone and putting the justification in `Background`.
- **A reference that stalls this reader.** A reference whose sentence cannot be completed without
  opening it (`#1784 makes X return Y`) fails; a reference that only marks a boundary (`depends on
  #1784`, `Refs #1558`) does not.

## Gate 2: duplication

Check whether the same content is stated in more than one place, and whether a section exists that
should not:

- A `Design / Approach`, `Out of scope`, or `Verification` heading present at all is itself a
  finding — these are not sections of an issue body, and the content under them always has a
  destination among the sections that are.
- `Goal` restating `Acceptance criteria` in different words, rather than pointing at what to
  conform to.
- `Background` prose that explains how to solve the problem rather than what the problem is.

## From a failed gate to findings

Hand each violation to `write-nice-instructions-as-comment` as the fact or facts it needs to
render. That skill owns the finding's shape and how firmly the remedy is stated; invent neither
here.

- **A determinacy failure** — the problem, the criteria or the boundary not fixed by the text alone
  — is one fact: what is missing, and which section it belongs in.
- **A smuggled implementation, a constraint carrying its reason, or a stalling reference** has an
  unambiguous fix, so state it: the choice left out, the constraint stated alone with its reason in
  `Background`, the reference cut back to the boundary it marks.
- **A duplication** is the content in two places, or the section that should not exist: name where
  the content belongs, and the fix is to fold it there and drop the other section.

## Reporting

Return the findings as text. That is the whole output, and posting is the caller's action with the
caller's own tools: whoever invoked this pass — a person, or a skill that does have `gh` access —
decides whether to show them, post them, or fold them into a larger report.

## The language the issue is written in is never a finding

The gates are about the body's shape, so judge it in whatever language it is written in. The one
language-related finding is Gate 2's: the same content restated in a second language.

## Common Rationalizations

| Rationalization | Reality |
|---|---|
| "The Affected areas list is detailed, so the boundary is clear enough." | Affected areas is a guess at the time of writing, with no binding force — it tells the reader where to look, not what is and isn't their decision to make. Judge the boundary from `Goal` / `Dependencies` / the scope statement, not from how long the file list is. |
| "Most of this issue reads as implementable, so the one vague criterion won't block anyone." | One criterion that fails determinacy is one criterion nobody can check off with confidence — the rest of the issue reading well is not evidence for that one. Judge every criterion, not the issue's overall impression. |
| "This issue still has a Design / Approach section, but it reads like useful context." | Useful context for whom is exactly the question this skill exists to ask. If it is a defensible constraint, it belongs in Acceptance criteria with its reason in Background; if it is not, the section is smuggling in a choice that should have been left out. Either way, the section itself is the finding. |
| "I wrote this issue myself an hour ago, I know what it means." | You are supplying the intent the text is missing as you read it. The reader who was not here cannot, and that gap is the whole failure mode. |
| "Giving this skill `gh` access would save a step." | It would also let it quietly resolve a reference or confirm a fact the body's own reader cannot — and that reader's inability to do so is exactly what Gate 1 checks. The step saved is the one thing this skill is for. |

## Red Flags

- A finding that leans on what you already know about the requirement, rather than on the text.
- `Affected areas` counted as the out-of-scope boundary.
- A finding about repo-groundedness, scope, or the language the issue is written in.
- A rewrite of the issue where a finding belongs.

## Verification

- [ ] Every finding names the section or sentence of the body it came from.
- [ ] Every finding is a Gate 1 or Gate 2 failure, and says which.
