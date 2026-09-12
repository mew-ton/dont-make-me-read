---
name: review-nice-issues
description: >
  Runs a determinacy-and-duplication pass over the text of a GitHub issue body that is already
  written — someone else's, or the author's own draft. Does not apply as a general-purpose "review
  this issue" entry point, when the issue is still being written or revised, or when what is wanted
  is a judgement of repo-groundedness, dependency closure, or scope.
user-invocable: false
disable-model-invocation: false
allowed-tools: []
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

# review-nice-issues

## Overview

`write-nice-issue-description` says how to write an issue body; this skill checks what was actually
written, against the same two gates from the reader's side: determinacy and duplication, defined
below. Judge only the text you were handed — a draft you wrote yourself reads fine to you, because
you still hold the problem and the implementation it leaves out.

## Inputs

The issue body text — nothing else. This skill never asks for an issue number or a repo; fetching
is the caller's job.

## Workflow

### 1. Take the body as given

Judge exactly the text you were handed, as it stands — not the requirement behind it, not what you
meant when you wrote it, not anything you know about the repository it will land in.

### 2. Judge the body against Gate 1: determinacy

Using **only** the body's own text — no repository lookup, no filling in what you happen to know
— check whether these three are fixed:

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
  them to decide, and what blocks them from starting at all? `Affected areas` fixes nothing here;
  it is a hunch, not a boundary — do not count it as satisfying this bullet.

Separately, scan every section for the implementation method itself:

- **Smuggled implementation.** A statement whose disposition would not change if a different
  implementation were chosen (which component to reuse, what to pass as props, how to branch) is a
  choice, not a criterion or an affected-area note — flag it wherever it appears.
- **A constraint with its reason attached.** A checkbox or bullet that carries its own justification
  inline, instead of stating the constraint alone and putting the justification in `Background`.
- **A reference that stalls this reader.** A reference whose sentence cannot be completed without
  opening it (`#1784 makes X return Y`) fails; a reference that only marks a boundary (`depends on
  #1784`, `Refs #1558`) does not.

### 3. Judge the body against Gate 2: duplication

Check whether the same content is stated in more than one place, and whether a section exists that
should not:

- A `Design / Approach`, `Out of scope`, or `Verification` section present at all is itself a
  finding — `write-nice-issue-description` does not use these sections, and their content always
  has a destination among the sections that remain (see the table in that skill's `SKILL.md`).
- `Goal` restating `Acceptance criteria` in different words, rather than pointing at what to
  conform to.
- `Background` prose that explains how to solve the problem rather than what the problem is.

### 4. Assemble findings

Hand each violation to `write-nice-instructions-as-comment` as the fact(s) it needs to render — that
skill owns the finding's shape and how firmly the remedy is stated; don't invent either here.

- A determinacy failure (problem, criteria, or boundary not fixed by the text alone) → state what
  is missing and where it belongs, using `write-nice-issue-description`' section guidance.
- A smuggled implementation, a misplaced constraint reason, or a stalling reference → the fix is
  usually unambiguous: state the choice/constraint/reference the way that skill's Gate 1 describes.
- A duplication → point at the section with the destination; the fix is to fold the content there
  and drop the other section, per that skill's Gate 2 table.

### 5. Report

Return the findings as text. That is the whole output. Whoever invoked it (a person, or another
skill that does have `gh` access) decides what to do with the findings: show them, post them, fold
them into a larger report.

## Guardrails

- Never bring outside knowledge into step 2 or 3 — judge the body from only its own text, exactly
  as the reader Gate 1 describes would encounter it. Reaching for what you already know about the
  requirement is the one failure mode this whole skill exists to catch in yourself.
- `Affected areas` never counts toward the boundary bullet in step 2, and never excuses a missing
  fact in `Background` — it is a hunch, with no binding force, by `write-nice-issue-description`'
  own definition.
- Whether a referenced file or symbol actually exists is out of scope here — that is repo-
  groundedness, a job for a skill that is actually allowed to look.
- The language the issue is written in is never a finding. Both gates are about the body's shape, so
  judge it in whatever language it is written in — the examples in `write-nice-issue-description`
  are English only because that skill is. The one language-related finding is Gate 2's: the same
  content restated in a second language.
- Never post anything from inside this skill. Posting, if wanted, is the caller's action with the
  caller's own tools.

## Common Rationalizations

| Rationalization | Reality |
|---|---|
| "The Affected areas list is detailed, so the boundary is clear enough." | Affected areas is a guess at the time of writing, with no binding force — it tells the reader where to look, not what is and isn't their decision to make. Judge the boundary from `Goal` / `Dependencies` / the scope statement, not from how long the file list is. |
| "Most of this issue reads as implementable, so the one vague criterion won't block anyone." | One criterion that fails determinacy is one criterion nobody can check off with confidence — the rest of the issue reading well is not evidence for that one. Judge every criterion, not the issue's overall impression. |
| "This issue still has a Design / Approach section, but it reads like useful context." | Useful context for whom is exactly the question this skill exists to ask. If it is a defensible constraint, it belongs in Acceptance criteria with its reason in Background; if it is not, the section is smuggling in a choice that should have been left out. Either way, the section itself is the finding. |
| "I wrote this issue myself an hour ago, I know what it means." | You are supplying the intent the text is missing as you read it. Judge it as someone holding only the text — that is the whole failure mode. |
| "Giving this skill `gh` access would save a step." | It would also let it quietly resolve a reference or confirm a fact the reader in front of the real text can't — and that reader's inability to do so is exactly what step 2 is checking. The step saved is the one thing this skill is for. |

## Red Flags

- A finding that leans on what you already know about the requirement — the failure this skill
  exists to catch in yourself.
- `Affected areas` counted as the out-of-scope boundary.
- A finding about repo-groundedness, scope, or the language the issue is written in.
- A rewrite of the issue where a finding belongs.

## Verification

- [ ] Every finding names the section or sentence of the body it came from.
- [ ] Every finding is a Gate 1 or Gate 2 failure, and says which.
- [ ] Nothing was posted from inside this skill.

## Related skills

- `write-nice-issue-description` — the authoring-time guidance this skill checks compliance with.
  Read it if a finding here is confusing; it explains the same two gates from the writer's side,
  with more examples.
- `write-nice-instructions-as-comment` — owns the finding template and how firmly a remedy is stated;
  this skill hands it facts (step 4), never a rendered shape.
