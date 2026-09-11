---
name: write-nice-instructions
description: >
  Use this skill when drafting or revising a PR review finding, a review comment, or a code-review
  remark — instruction text a person will read and act on — and especially when you wrote it
  yourself and it reads fine to you. DO NOT use this skill when the artifact is a GitHub issue
  body or a skill's description and size budget, or when the question is which background context
  a persistent document carries.
user-invocable: false
disable-model-invocation: false
context: fork
background: false
allowed-tools: []
---

## Scope

This skill governs **text that tells a person what to change**: a PR review finding. An agent
reading the same text is served by the same shape, but **the bar is set by the human reader** —
the budgets below exist because a person decides within the first few lines whether to act or skim.

A GitHub issue body is a different artifact — a problem statement plus a completion condition, read
by an implementer who can read the repository — and is `write-nice-issue-description`'s scope, not
this skill's.

Neighbouring skills own different axes, and several can apply to one PR review finding:

| Question | Skill |
|---|---|
| Is the instruction in the fixed shape, and is its remedy stated at the right strength? | this skill |
| Can the reader check what it claims (rationale kept, process dropped)? | `avoid-unverifiable-context` |
| Was the reader sent somewhere reachable to understand it? | `avoid-reference-detours` |

A skill body is instruction text too, so this skill still governs the asks inside one; what it hands
to `write-nice-skills` is the description and the size budget.

## Language

Write the finding in the language its readers already use — the language of the repository, the
review thread, and the surrounding comments. Every rule below is about the finding's **shape**, not
its language: Title / Summary / Details, the budgets, and the three strength rows apply the same
way whichever language you post in. The examples here are written in English only because this
skill is; they are not a request to review in English.

Two consequences worth stating outright, since they are where a translated finding usually slips:

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
before writing Details — it holds the four tells that a draft is already two applications under one
Title, the overflow signal that catches the same thing later, and a worked example. Split on any of
those, before writing Details.

## The template

| Part | What goes in it | Budget |
|---|---|---|
| **Title** | The observed **fact**, and nothing else — stated at the level of the **rule it breaks**, not the evidence that proves it. A path, a quoted identifier, or an instance-specific comparison is usually evidence, and belongs in Summary (exception in the rule file below). Not a request, not an assessment, not how it made you feel. | **one sentence** — if it needs a second one, the rest is Summary |
| **Summary** | The fact, and what should be done about it. The reader can act from this alone. | **a list of at most 3 short statements** — one fact or one instruction each |
| **Details** | The how and the why behind that fix. Omit it when the summary already carries them. | **20 lines**, code blocks excluded |

Before writing Title, read the three rules below — each holds one worked example, not a survey of
every way Title can go wrong:

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
usually two facts. Same remedy for both: the second belongs in Summary. Different remedy: it is a
**second application**, not a longer Summary
([`rules/one-instruction-one-application.md`](rules/one-instruction-one-application.md)).

## How firmly to state the remedy

Pick one of three, by what you can actually defend:

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

## Self-check

1. **Budget**: Summary at most 3 bullets of one short sentence each, Details within 20 lines (code
   blocks excluded), counted in the language you are posting in?
2. **Title**: a fact the reader can verify, with no request or judgement mixed in — does it still read
   true if the instance is swapped for a different file? If not, is the site genuinely the only
   instance (the exception), rather than a pattern that could recur?
3. **Strength**: row 1 asserted, with no hedge and no rejected option offered as a choice (a
   constraint is fine); row 2 with no implicit weighting; row 3 registered as a problem rather than
   softened into a suggestion?
4. **Unit**: Title is one fact; an instance count shares one edit; every part sits in one strength
   row; no sub-heading hides inside Details?
5. **Delete-test**: every line that would not change what the reader does, removed?
6. **Checkable property**: if the fix targets a mechanically checkable property, is it stated as the
   check itself, rather than as the paths that happened to be sampled?
7. **Language**: one language throughout, the one this repository's reviews already use — no
   second-language restatement of the same finding?

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
