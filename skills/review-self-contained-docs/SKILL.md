---
name: review-self-contained-docs
description: >
  Text-self-containment pass over a pull request's description and every code comment it adds or
  changes: checks each one for a reader with none of the writer's context — no conversation, no
  issue, no surrounding diff — against three conditions: time-closure, referenceability,
  reference-scope closure. Invoked by a caller such as a PR-review skill for its own
  text-self-containment axis; also invocable directly by name to self-check a PR description,
  issue body, or code comment you just wrote before it ships — "self-check this with
  review-self-contained-docs", "does this comment read without the surrounding context". DO NOT
  invoke it as a general-purpose "review this PR" entry point, and do not expect it to judge issue
  conformance, scope, or design — that is the caller's job (e.g. ghdd-review-pr-against-issue),
  not this skill's.
disable-model-invocation: true
argument-hint: "[<pr-url-or-number>] [--repo <owner/repo>] [--worktree <path>] [--comment]"
allowed-tools:
  - Read
  - Grep
  - Bash(gh pr diff:*, gh pr view:*, gh api:*)
---

# review-self-contained-docs

## Purpose

`write-self-contained-docs` says what to write. This skill checks what was actually written,
against the same three conditions from the reader's side: time-closure, referenceability, and
reference-scope closure (defined below). It runs in two situations:

- **Reviewing a PR**: check its description and every comment the diff adds or changes.
- **Self-checking text you just wrote**: before a PR description, issue body, or code comment
  ships, run it through this same judgment explicitly, rather than trusting your first read of
  it — you wrote it with all the context already in your head, which is exactly the thing this
  check has to route around. Imagine the exact reader `write-self-contained-docs`'s self-check
  describes — someone opening this with zero context — and judge only what is in front of that
  reader: the unit's own text, and for a code comment, the code it annotates. Nothing else you
  know about the PR, the issue, or this conversation counts as evidence.

## Usage

`/review-self-contained-docs [<pr>] [--repo <owner/repo>] [--worktree <path>] [--comment]`

| Argument | Meaning | Required |
|---|---|---|
| `<pr-url-or-number>` | The PR to review. Defaults to the PR of the current branch. | Optional |
| `--repo <owner/repo>` | Target repository when not inferable from the cwd. | Optional |
| `--worktree <path>` | Read files from an already-checked-out worktree instead of fetching content over the API. Set this when called from another review flow that already has one. | Optional |
| `--comment` | Post findings as inline PR review comments. Default is to print the findings and post nothing. | Optional |

For self-checking text you just wrote, there is no PR argument: go straight to "Judge each unit"
below with the drafted text (and, for a code comment, the code block it annotates) — there is only
one unit, extraction does not apply.

## Workflow

### 1. Get the current file content, not just the diff

Time-closure (condition 1, below) cannot be judged from a comment in isolation — it has to be
checked against what the code actually looks like now. A diff hunk alone can hide this: an added
comment might describe code that a *later* hunk in the same PR changes again, or the context
lines around a hunk might be stale relative to the file's head.

- If `--worktree <path>` was given, read files from there, and get the diff with `gh pr diff` run
  with no arguments from inside that worktree — it auto-detects the PR from the checked-out
  branch, so no separate `git diff` permission is needed.
- Otherwise, run `gh pr diff <pr>` for the diff, and fetch each file's content at the PR's head
  SHA via `gh api repos/<owner>/<repo>/contents/<path>?ref=<head-sha>` (base64-decode the
  response). Do not judge from `gh pr diff` hunks alone — that is the diff-only mistake
  `ghdd-review-pr-against-issue` guards against for the same reason.

### 2. Extract candidate units

Restrict attention to **added or changed lines only** — a PR review has no business reviewing
comments nobody touched. This is a two-pass filter, not a single regex:

1. **Mechanical pass**: for each changed file, pick the comment syntax that matches its extension
   (`//`, `#`, `/* ... */`, docstrings, `<!-- -->`, and so on) and use `Grep` to pull every
   added/changed line that starts one. Treat a contiguous run of such lines as one block.
2. **Judgment pass**: drop a candidate if it is commented-out code rather than prose, or if the
   change is purely a reflow/typo fix with no semantic difference — neither is a unit this skill
   judges. For what survives, decide the attached code: default to the smallest enclosing
   statement, block, or function the comment sits above or beside, and adjust if the comment
   itself is clearly about a wider or narrower span. Check the content against that choice: a
   docstring can be true of the declaration it physically sits on and still leave a different
   declaration undocumented — one whose callers are the ones who actually need it. That gap is a
   finding in its own right, before any of the three conditions apply to what the docstring says.

A changed line can also shift what an *unchanged* neighboring line means, without changing that
line's own characters — a trailing sentence in the same paragraph that says "see the comment
above for why" still points at the same words, but if the sentence right before it just changed,
what the reader is being sent to read has changed too. Pull the whole paragraph or comment block
into the unit whenever an unchanged line is grammatically continuous with a changed one (reads as
one sentence or one train of thought), not only the lines the diff marked. Judging the changed
half alone would miss exactly the kind of misdirected reference this skill exists to catch.

Add the PR description itself as one more unit (fetch with `gh pr view --json body`). An issue
body being self-checked works the same way — one unit, no code attached.

### 3. Judge each unit

For every surviving unit, judge it against the three conditions below using **only** that unit's
text and (for code comments) its attached code block. Treat anything not in front of you as
absent for the real reader too — do not fill in what the surrounding file or PR "probably" says.
This is the same self-check `write-self-contained-docs` asks a writer to run on themselves; here
it is run explicitly and per-unit rather than trusted to a single read-through.

Judge them in order; each later condition assumes the earlier ones passed, so stop at the first
failure. Record which condition each unit failed, or that it passed all three — see
[Common Rationalizations](#common-rationalizations) before treating a candidate list, or an
overall skim, as a substitute for this per-unit record.

#### Condition 1: time-closure

The question is which point in time the text describes, not which grammatical tense it uses.
Text in the past tense can still describe the present: "this call is synchronous because the
constraint from the legacy API is still in effect" is past-referencing but describes a property
of the code in front of you right now — check it against the attached code, and if the code
confirms it, this condition passes regardless of tense. Text fails this condition when what it
describes has no counterpart in the attached code at all: "this used to call the legacy API
before the migration" describes a past state, and if the attached code shows nothing of the sort,
there is nothing left for a reader to verify.

#### Condition 2: referenceability

The question is whether a reader could go check what the text refers to. Two things make a
reference unreachable, and they get the same verdict because the reader ends up equally stuck:

- **Unidentifiable** — the words don't say what system the reference even belongs to ("issue:
  1234" with no system named: a Notion page ID? A GitHub issue? A Jira ticket?). This fails before
  reachability is even a question a reader can ask.
- **Unreachable in principle** — a conversation, a chain of trial and error, a decision made in
  this session. There is no artifact to go read.
- **Unreachable in this reader's environment** — a Notion page, a Slack thread, a meeting. It
  exists, but not anywhere the text's own words get the reader to.

A short `TODO(#123): ...`-style cross-reference is the one exception: it names exactly what to go
read and where, so treat it as passing this condition.

#### Condition 3: reference-scope closure

A different axis from condition 2, and it only applies to text that already passed it. The
question is not whether the reference is reachable, but whether the reader is being sent outside
this unit's own scope to make sense of it at all — a class-level comment elsewhere in the file,
"see the config", "same as `coupon.rb`", a different section of the same PR description. The
target may be perfectly readable; the problem is that reading it was never optional, and the
comment's position is where the mistake was made. "Can the reader reach it?" is condition 2's
question. "Should the reader have to leave this unit to understand it at all?" is this one.

See [`references/examples.md`](references/examples.md) for a Bad/Good pair per condition (condition
1 has a second Bad pair, for a violation buried in an otherwise-valid comment), a best case with no
comment at all, and two extraction edge cases — a changed line redirecting what an unchanged
neighboring line means, and a docstring describing a declaration other than the one it sits on.

### 4. Assemble findings

Hand each violation to `write-nice-instructions` as the fact(s) it needs to render — that
skill owns the finding's shape and how firmly the remedy is stated; don't invent either here.

- Condition 1 or 2 violation → **one fact**: the unit fails, and the fix is unambiguous — delete
  it.
- Condition 3 violation → **usually two distinct facts**, because a defensible fix (delete the
  unit) and an unsolved gap (the information it carried has no home) are different kinds of
  claims:
  - (a) the unit sends the reader outside its own scope — delete it.
  - (b) the information it carried is not expressed anywhere at its point of use — name what's
    missing and where it would need to live, without naming a fix. Skip (b) when it would be purely
    redundant with (a) — some condition-3 violations carry no information beyond "this is
    misplaced," and forcing a second fact out of those would be manufacturing a design-gap that
    isn't there.

### 5. Report

- Default: print the findings. Nothing is posted.
- `--comment`, standalone use only: post each finding as an inline PR review comment via
  `gh api repos/<owner>/<repo>/pulls/<pr>/comments`, passing that unit's `commit_id` (the PR's
  head SHA), `path`, `line`, and the rendered finding as `body`. A plain `gh pr comment` lands on
  the conversation tab, not at the line — it does not satisfy `--comment`.
- **When invoked as a step inside another skill** (e.g. `ghdd-review-pr-against-issue`'s
  text-self-containment axis), never post — return the findings and let the caller fold them into
  its own comment. Posting from both places would duplicate the same finding twice.

## Guardrails

- Never judge condition 1 from a diff hunk alone; get the file's current content first (step 1).
- Never bring outside knowledge into step 3 — judge each unit from only its own text and directly
  attached code, exactly as the reader would encounter it. Reaching for what you already know
  about the PR is the one failure mode this whole skill exists to catch in yourself.
- Never post findings unless `--comment` was explicitly given, and never post at all when running
  as another skill's subroutine.
- The language a unit is written in is never a finding. All three conditions are about what context
  the text carries, so judge each unit in whatever language it is written in — the examples in this
  skill are English only because the skill is. A unit restating the same content in a second
  language is a finding, but as duplication, not as a language choice.
- A unit that fails condition 1 or 2 does not also get checked against condition 3 — stop at the
  first failure; do not invent a condition-3 verdict for a unit that already failed earlier.

## Common Rationalizations

Step 2 produces a candidate list; step 3 is the part that actually judges it. Read this table
before starting, so the excuse is already answered when it occurs to you.

| Step | Rationalization | Reality |
|---|---|---|
| 3 | "There are dozens (or hundreds) of comment candidates; grepping them and reporting the list is the review." | Grep only extracts lines that *look like* comments, and step 2's judgment pass only filters that list further. Neither judges time-closure, referenceability, or reference-scope closure — those are semantic questions no pattern match resolves. A candidate list is step 2's output regardless of size, never step 3's. |
| 3 | "There are too many surviving units to judge each one individually in one pass." | Five survivors and five hundred survivors are the same task repeated — volume is never a signal to sample, batch, or skim. Record a verdict for every surviving unit before moving to step 4. |
| 3 | "Most of this comment reads as legitimate, checkable justification, so the whole unit passes." | One clause that fails a condition fails the whole unit, even when the rest of the same comment is present-tense and checkable. A good surrounding explanation is not amnesty for the one clause that isn't — judge every clause, not the unit's overall impression (see `references/examples.md`'s second Condition 1 example). |

## Related skills

- `write-self-contained-docs` — the authoring-time guidance this skill checks compliance with.
  Read it if a finding here is confusing; it explains the same three conditions from the writer's
  side, with more examples.
- `write-nice-instructions` — owns the finding template and how firmly a remedy is stated;
  this skill hands it facts (step 4), never a rendered shape.
- `ghdd-review-pr-against-issue` — calls this skill for its "Text self-containment" axis as one
  part of a full PR review; this skill has no opinion on the other axes.
