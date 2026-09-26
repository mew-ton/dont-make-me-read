---
name: review-self-contained-docs
description: >
  Runs a self-containment pass over text that is already written — a pull request's description and
  every code comment its diff adds or changes, someone else's or the author's own draft — against a
  reader who holds none of the writer's context. Does not apply as a general-purpose "review this
  PR" entry point, or when what is wanted is a judgement of issue conformance, scope, or design.
user-invocable: false
disable-model-invocation: false
allowed-tools:
  - Read
  - Grep
  - Bash(gh pr diff:*)
  - Bash(gh pr view:*)
  - Bash(gh api:*)
---

## Overview

This skill judges text that is already written — a PR's description, and every code comment its
diff touches — as the reader who holds none of the writer's context: no conversation, no issue, no
rest of the diff. Each unit is judged from its own text and, for a code comment, the code it
annotates. Anything else you know is not evidence, and reaching for it is the one failure this
skill exists to catch in yourself.

## How to work

- **Judge each unit from its own text and its attached code, and treat everything else as absent.**
  Do not fill in what the surrounding file or the PR "probably" says — the real reader cannot.
- **Get the file as it stands at the PR's head before judging anything.** A hunk's context lines
  are whatever surrounded that change, not the code the first condition is checked against.
- **Extract from added or changed lines only, then judge every survivor.** A PR review has no
  business on comments nobody touched, and volume is never a reason to sample.
- **Read every unit; never search for a phrasing instead.** A pattern search returns the wordings
  you already thought of, and the defect is in the ones you did not.
- **Record a verdict per unit** — which condition it failed, or that it passed every one — before
  assembling a single finding. A candidate list is not a verdict.
- **Hand facts to the skill that renders them, and post nothing you were not asked to post.**

## The brief

The caller's brief arrives as **`$ARGUMENTS`**, and may carry:

| In the brief | What it settles | Default |
|---|---|---|
| `<pr-url-or-number>` | the PR to review | the PR of the current branch |
| `--repo <owner/repo>` | the repository, where the cwd does not settle it | inferred from the cwd |
| `--worktree <path>` | read files from a checkout that exists already, instead of fetching content over the API — set by a review flow that has one | fetch over the API |
| `--comment` | post the findings as inline PR review comments | print the findings, post nothing |

A brief with no PR in it is a self-check of text just drafted: there is one unit — that text, plus
the code block it annotates — and nothing to extract, so go straight to the conditions.

## The conditions

Judge each unit against every condition below, in order. Each later condition assumes the earlier
ones passed, so stop at the first failure and record it: a unit that failed condition 1 or 2 never
gets a
condition-3 verdict.

### Condition 1: time-closure

The question is which point in time the text describes, not which grammatical tense it uses. Text
in the past tense can still describe the present: "this call is synchronous because the constraint
from the legacy API is still in effect" is past-referencing but states a property of the code in
front of you right now — check it against the attached code, and if the code confirms it, the
condition passes whatever its tense. Text fails when what it describes has no counterpart in the
attached code at all: "this used to call the legacy API before the migration" describes a past
state, and if the code shows nothing of the sort, there is nothing left for a reader to verify.

Judge every clause. One clause that fails fails the whole unit, however checkable the rest of it is.

### Condition 2: referenceability

The question is whether a reader could go check what the text refers to. These make a reference
unreachable, and they get the same verdict because the reader ends up equally stuck:

- **Unidentifiable** — the words do not say what system the reference even belongs to ("issue:
  1234" with no system named: a Notion page ID? A GitHub issue? A Jira ticket?). This fails before
  reachability is a question the reader can ask.
- **Unreachable in principle** — a conversation, a chain of trial and error, a decision made in
  this session. There is no artifact to go read.
- **Unreachable in this reader's environment** — a Notion page, a Slack thread, a meeting. It
  exists, but not anywhere the text's own words get the reader to.

A short `TODO(#123): ...` cross-reference is the one exception: it names exactly what to go read
and where, so treat it as passing.

### Condition 3: reference-scope closure

A different axis from condition 2, and it applies only to text that already passed it. The question
is not whether the reference is reachable, but whether the reader is being sent outside this unit's
own scope to make sense of it at all — a class-level comment elsewhere in the file, "see the
config", "same as `coupon.rb`", another section of the same PR description. The target may be
perfectly readable; the problem is that reading it was never optional, and the comment's position is
where the mistake was made. "Can the reader reach it?" is condition 2's question. "Should the reader
have to leave this unit to understand it at all?" is this one.

## From a failed unit to findings

Hand each violation to `write-nice-instructions-as-comment` as the fact or facts it needs to render.
That skill owns the finding's shape and how firmly the remedy is stated; invent neither here.

- **Condition 1 or 2** — **one fact**: the unit fails, and the fix is unambiguous, so state it.
  Delete the unit.
- **Condition 3** — **usually two facts**, because a defensible fix and an unsolved gap are
  different kinds of claim:
  - (a) the unit sends the reader outside its own scope — delete it.
  - (b) the information it carried is expressed nowhere at its point of use — name what is missing
    and where it would have to live, without naming a fix.
  - Skip (b) where it would only restate (a). Some condition-3 units carry nothing beyond "this is
    misplaced", and forcing a second fact out of those manufactures a design gap that is not there.

## Reporting

- **Default: print the findings.** Nothing is posted.
- **`--comment`, standalone use only**: post each finding as an inline review comment via
  `gh api repos/<owner>/<repo>/pulls/<pr>/comments`, passing that unit's `commit_id` (the PR's head
  SHA), `path`, `line`, and the rendered finding as `body`. A plain `gh pr comment` lands on the
  conversation tab rather than at the line, and does not satisfy `--comment`.
- **Running as a step inside another skill, post nothing at all** — return the findings and let the
  caller fold them into its own comment. Posting from both places files the same finding twice.

## The language a unit is written in is never a finding

The conditions are all about what context the text carries, so judge each unit in whatever
language it is written in, and write the findings in the language the repository's reviews already
use. A unit that restates its own content in a second language is a finding — as duplication, not
as a language choice.

## Which file to read

| The question | Read |
|---|---|
| The brief names a PR, and its diff has to become units with code attached to each | [`references/extracting-units.md`](references/extracting-units.md) |
| A worked Bad → Good pair for the condition in front of you, or the case where no comment at all is the right answer | [`references/examples.md`](references/examples.md) |

## Common Rationalizations

| Rationalization | Reality |
|---|---|
| "There are dozens of comment candidates; grepping them and reporting the list is the review." | A grep extracts lines that *look like* comments, and the judgment pass only filters that list further. Neither answers time-closure, referenceability or reference-scope closure — those are semantic questions no pattern match resolves. A candidate list is extraction's output whatever its size, never a verdict. |
| "There are too many surviving units to judge each one individually in one pass." | Five survivors and five hundred are the same task repeated — volume is never a signal to sample, batch or skim. Record a verdict for every surviving unit before assembling any finding. |
| "Most of this comment reads as legitimate, checkable justification, so the whole unit passes." | One clause that fails a condition fails the whole unit, even where the rest is present-tense and checkable. A good surrounding explanation is not amnesty for the clause that is not — judge every clause, not the unit's overall impression (condition 1's second Bad in `references/examples.md`). |
| "I know from the PR what this comment means, so it is fine." | Then the finding rests on context the reader does not have. What you hold from the diff, the issue or this conversation is exactly what the unit has to carry for itself. |

## Red Flags

- Condition 1 judged from a diff hunk, without the file's current content.
- A unit that already failed condition 1 or 2 carrying a condition-3 verdict anyway.
- A finding whose ground is the PR context you happen to hold.
- A language choice reported as a finding.
- A comment the diff never touched, appearing among the findings.

## Verification

- [ ] Every unit was judged from its own text and the code attached to it.
- [ ] Every surviving unit has a recorded verdict, and each failing one stops at its first failed
      condition.
- [ ] Nothing was posted unless `--comment` was given, and nothing at all when running as another
      skill's step.
