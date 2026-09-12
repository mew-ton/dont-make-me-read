---
name: write-nice-instructions-as-comment
description: >
  Drafts and revises an instruction written as a comment — a PR review finding, a reply proposing a
  change, a remark asking someone to fix something — text one person reads, acts on, and can answer
  back to, and it applies especially to an instruction that reads fine to whoever wrote it. Does not
  apply when the instruction is a standing rule the reader will meet again, a GitHub issue body, or
  a skill's description and size budget, nor when the question is which background context a
  persistent document carries.
user-invocable: false
disable-model-invocation: false
context: fork
background: false
allowed-tools: []
---

## Overview

An instruction written as a comment — a PR review finding, a reply proposing a change, a remark
asking for a fix — has a reader who can answer back, which is what separates it from a rule. They
decide within the first few lines whether to act, skim, or argue, and the bar is theirs: the
budgets below exist because a person decides that fast.

## Language

Write the finding in the language its readers already use — the language of the repository, the
review thread, and the surrounding comments. Every rule below is about the finding's **shape**:
Title / Summary / Details, the budgets, and the strength rows apply the same way whichever language
you post in.

Where a translated finding usually slips:

- **Budgets are counted in the language you post in.** A Details section that fits 20 lines in one
  language and not in another is over budget in the second, and the remedy is the same as always —
  usually two instructions in one, not a wrapping problem.
- **Never post the same finding twice in two languages.** One finding, one language. A bilingual
  comment doubles the reading cost and hides how many separate points were actually made.

## One instruction, one application

The template applies **once per instruction** — never once per document containing several.

| Artifact | Applications | Title | Summary | Details |
|---|---|---|---|---|
| PR review | **one per finding** | the finding's lead line (`**<severity>** — <fact>`) | the finding's opening | only when the summary does not carry the how / why |

Read [`rules/one-instruction-one-application.md`](rules/one-instruction-one-application.md)
before writing Details — it holds the tells that a draft is already two applications under one
Title, the overflow signal that catches the same thing later, and a worked example. Split on any of
those, before writing Details.

## The template

| Part | What goes in it | Budget |
|---|---|---|
| **Title** | The observed **fact**, and nothing else — stated at the level of the **rule it breaks**, not the evidence that proves it. A path, a quoted identifier, or an instance-specific comparison is usually evidence, and belongs in Summary (exception in the rule file below). Not a request, not an assessment, not how it made you feel. | **one sentence** — if it needs a second one, the rest is Summary |
| **Summary** | The fact, and what should be done about it. The reader can act from this alone. | **a list of at most 3 short statements** — one fact or one instruction each |
| **Details** | The how and the why behind that fix. Omit it when the summary already carries them. | **20 lines**, code blocks excluded |

Before writing Title, read the rules below — each holds one worked example:

- [`rules/avoid-negating-the-request-as-the-fact.md`](rules/avoid-negating-the-request-as-the-fact.md)
  — a negated request is not an observation.
- [`rules/avoid-fusing-the-instance-into-the-title.md`](rules/avoid-fusing-the-instance-into-the-title.md)
  — the swap test for telling the rule from the one instance that broke it, and the exception where a
  path is genuinely the fact.
- [`rules/avoid-naming-sampled-paths-as-the-fix.md`](rules/avoid-naming-sampled-paths-as-the-fix.md)
  — when the property behind a finding is mechanically checkable, state the check itself.

**Summary is a list, not a paragraph.** Write each statement as its own bullet, and keep each to one
short sentence. A three-line paragraph hides its instruction inside a subordinate clause — "since the
caller cannot tell which field failed, it might be better to…" — and hides how many separate points
you actually made. A bullet forces both into the open: if a qualifier will not fit in the sentence it
qualifies, it is either its own statement or it belongs in Details. Three bullets is the ceiling, not
a target; one is common and better. **Bulleted is not the same as Summary**: a list of evidence —
what you checked, a table's contents — is still Details, only reformatted.

For Details, a **line** is one written line at the width you are writing at — a GitHub comment wraps
near 100 characters — so 20 lines is on the order of 2000 characters. Rewrapping to hit the count is
not a fix: if it only fits at 200 characters a line, it does not fit. Only a **fenced code block** is
excluded — a table, list, or sub-heading inside Details counts as written lines, so a table buys back
nothing. Title is counted in sentences, since a title does not wrap by choice — a long Title is
usually two facts, and the second belongs in Summary. A Summary that will not fit in three
statements is usually a **second application**
([`rules/one-instruction-one-application.md`](rules/one-instruction-one-application.md)).

## How firmly to state the remedy

Pick one, by what you can actually defend:

| What you have | How to write it |
|---|---|
| **A fix you can defend** | Assert it as the one to make. A rejected option may appear only as the constraint that rules it out — never as an option offered to the reader. |
| **Several fixes, and any of them is genuinely fine** | List them flat, with no weighting. |
| **No fix you can name** | Switch the goal to **registering the problem**: open an issue and link it from a comment at that code. |

Strength is **orthogonal to severity**: `critical` / `major` / `minor` / `nit` says whether the
finding blocks the merge, strength says how firmly the remedy is stated. A `major` can have no known
fix (row 3), and a `nit` can have exactly one (row 1).

Read [`rules/remedy-strength.md`](rules/remedy-strength.md) before writing Summary's
fix — it holds how to choose between the three rows, the caveat for a comment-vs-code contradiction
(not automatically row 1), and worked examples of each row.

## Fitting the budget

Read [`rules/fitting-the-budget.md`](rules/fitting-the-budget.md) before
trimming a draft — it holds what to cut and why, and the one exception (bulky evidence in a code
block sits outside the budget).

## Common Rationalizations

| Rationalization | Reality |
|---|---|
| "Listing every option is the honest thing to do." | The options you rejected are your context, not the reader's. A menu does not inform them, it moves the decision to someone with less information than you had. Assert the fix you can defend; keep the flat list for options that really are interchangeable. |
| "Asserting one fix is overbearing." | Strength is about where the decision sits, not about tone. Hedging a fix you can defend makes the reader carry your call, and they carry it worse. Politeness lives in the wording, not in the vagueness. |
| "I have no fix, so I will soften it into a suggestion." | A soft suggestion with nothing behind it sends the reader chasing a fix you never had. Register it: open an issue and link it from the code. |
| "20 lines cannot hold the explanation." | Almost always two instructions — split it (the tells catch this earlier). If truly one, the excess belongs in the linked issue, not Details. |
| "A paragraph reads more naturally than a bulleted summary." | It reads more naturally to *you*, because you already know which clause is the instruction. To the reader, prose lets the ask hide in a subordinate clause and hides how many points were made. Bullets make both countable — which is exactly why they feel constraining to write. |
| "Background first is kinder to the reader." | Title and Summary are the fact and the fix; why goes in Details. A reader who cannot act after the summary's three statements stops reading, and never reaches the background. |
| "It's all one file / one PR, so it's one finding." | The unit is the **remedy**, not the subject. Different edits — or one the reader could accept while contesting the other — means two applications; bundling forces them to re-do a split you already could have made. |
| "It reads fine to me." | You are supplying the intent the text is missing as you read it. Judge it as someone holding only the text — that is the whole failure mode. |
| "I can turn any request into a fact by negating it." | Negating the request only changes its grammar, not its content — "library `A` is not introduced" carries the same information as "introduce library `A`" and no more. The fact has to be upstream: the behaviour in the code that the request is a response to. |
| "Naming the file in Title is more precise." | Precision at the wrong altitude reads as evidence, not a rule. A reader needs to recognise the shape of the problem before they need its address — put the file in Summary's first bullet, and swap-test Title for whether it still reads true pointing elsewhere. |
| "The comment/spec describes the intended behaviour, so making the code match it is the fix." | Reading as the more confident or complete side is not evidence it is the current one — the comment can just as easily be the stale half. If the PR or issue discloses the gap as a deliberate scope split, forcing the code to catch up decides a scope question that belongs to the author, not the reviewer. That is row 2 unless you have independent evidence — a grep, an explicit statement that one side is stale — that actually favors one side. |
| "The examples in this skill are in English, so the finding should be too." | The examples are in English because the skill is. Post in the language the repository's reviews already use — the shape is what this skill fixes, not the language. |

## Red Flags

- A Title carrying the path or identifier that is evidence for the rule, rather than the rule.
- A Title that is a request, an assessment, or how it made you feel.
- A Summary paragraph with its instruction inside a subordinate clause.
- Options offered where you have a fix you can defend.

## Verification

- [ ] Title is one sentence carrying a fact, with no request, assessment or feeling in it.
- [ ] Title stays true pointed at another instance of the same rule, or the site is genuinely the
      only instance.
- [ ] Summary is at most three short statements, one fact or one instruction each.
- [ ] Details is inside 20 lines, code blocks excluded, counted in the language you post in — or absent.
- [ ] The remedy is asserted with no hedge, listed flat with no weighting, or registered as a
      problem, matching what you can actually defend.
- [ ] One edit answers the whole finding, and every part of it sits in one strength row.
- [ ] A mechanically checkable property is stated as the check, not as the paths you sampled.
- [ ] Every line left would change what the reader does, and all of it is in one language.

## Related skills

- `dont-make-me-read` — the test this one sharpens: the finding is judged by what its reader has to
  hold before they can act.
- `avoid-unverifiable-context` — whether the reader can check what the finding claims: the
  rationale stays, the process it came out of goes.
- `avoid-reference-detours` — whether the reader was sent somewhere to understand it, and what may
  be restated at the point of use instead.
- `write-nice-issue-description` — a problem statement plus a completion condition, read by an
  implementer who can read the repository; this skill stops where that one starts.
- `write-nice-instructions-as-rule` — the same demand where the instruction stays in force: a guideline, a
  convention, or the rules inside a skill body, read out of order by whoever the rule catches.
