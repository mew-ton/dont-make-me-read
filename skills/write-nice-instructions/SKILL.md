---
name: write-nice-instructions
description: >
  Instruction text a person will read and act on — a PR review finding — gets one fixed shape: a
  title that states the observed fact, a short summary of that fact and the fix, and bounded
  details for the how and why. It is applied once per finding. It also fixes **how firmly the
  remedy is stated**, so a fix you can defend is asserted as the one to make instead of being
  diluted into a menu of alternatives, and a problem you have no fix for is registered as one
  rather than dressed up as a suggestion. Apply when drafting or revising a PR review finding, and
  especially when you wrote it yourself and it reads fine to you
  (「レビューコメントを書いて」「この指摘、ノイズが多くて伝わらない」). DO NOT use for a GitHub
  issue body (that is write-nice-issue-description), for a skill's description or size budget (that
  is write-nice-skills), or for deciding which background context a persistent document carries
  (that is write-self-contained-docs).
disable-model-invocation: false
allowed-tools: []
---

## Scope

This skill governs **text that tells a person what to change**: a PR review finding. An agent
reading the same text is served by the same shape, but **the bar is set by the human reader** —
the budgets below exist because a person decides within the first few lines whether to act or skim.

A GitHub issue body is a different artifact — a problem statement plus a completion condition, read
by an implementer who can read the repository — and is `write-nice-issue-description`'s scope, not
this skill's.

Two neighbours own different axes, and both can apply to one PR review finding:

| Question | Skill |
|---|---|
| Is the instruction in the fixed shape, and is its remedy stated at the right strength? | this skill |
| Does the reader have the background to judge it (rationale kept, process dropped)? | `write-self-contained-docs` |
| Will this `SKILL.md` fire, and is it lean enough to load? | `write-nice-skills` |

A skill body is instruction text too, so this skill still governs the asks inside one; what it hands
to `write-nice-skills` is the description and the size budget.

## One instruction, one application

The template applies **once per instruction** — never once per document containing several.

| Artifact | Applications | 表題 (title) | 概要 (summary) | 詳細 (details) |
|---|---|---|---|---|
| PR review | **one per finding** | the finding's lead line (`**<severity>** — <fact>`) | the finding's opening | only when the summary does not carry the how / why |

**Four tells a draft is already two applications under one 表題**, readable before 詳細 exists —
earlier than a 20-line overflow (`Fitting the budget`, below) catches the same thing:

- 表題 joins two facts ("...で、かつ...") instead of stating one.
- 表題 counts instances ("4 件"), not all closing with the same edit.
- Parts sit at different strength rows (below) — a fix for one, none for another.
- 詳細 wants a sub-heading — that heading is the second instruction's name.

Split on any of these, before writing 詳細.

## The template

| Part | What goes in it | Budget |
|---|---|---|
| **表題** | The observed **fact**, and nothing else — stated at the level of the **rule it breaks**, not the evidence that proves it. A path, a quoted identifier, or an instance-specific comparison is usually evidence, and belongs in 概要 (exception below). Not a request, not an assessment, not how it made you feel. | **one sentence** — if it needs a second one, the rest is 概要 |
| **概要** | The fact, and what should be done about it. The reader can act from this alone. | **a list of at most 3 short statements** — one fact or one instruction each |
| **詳細** | The how and the why behind that fix. Omit it when the summary already carries them. | **20 lines**, code blocks excluded |

表題 states a fact so the reader can verify it before deciding anything: `` `validate.ts:14` returns
no field name on a validation failure `` is checkable; "the error handling should be improved" is an
opinion they can only agree or disagree with.

**Flipping the request's polarity is not this either.** "Introduce library `A`" rewritten as
"library `A` is not introduced" is checkable, but it is still the request wearing 表題's shape — it
names the absence of what was asked for, and carries no more information than the ask itself. The
fact sits upstream of the request: what is happening today, in the code, that the request is a
response to? `` `src/report/*.ts` formats dates with five different ad-hoc `Intl.DateTimeFormat`
presets `` is a fact that justifies introducing a shared formatter; "library `A` is not introduced"
only restates the request with a `not` inserted.

The same upstream move applies when the finding is not a defect at all. A finding that proposes a
better idea rather than reporting something broken still needs an upstream fact instead of the
proposal's own negation — not the proposal negated, but the structural fact that pulled today's
shape into place. The upstream fact does not have to be "why the code is broken"; it can be "why the
code is shaped the way it is today."

**表題 names the rule, 概要 points at where it broke.** A 表題 can be one honest fact and still sit at
the wrong altitude: `` `FieldDisplay.vue`'s fallback branch adds `data-test`, referenced only by this
PR's two test files while `AppFieldDisplay` is shared across 17+ screens `` names a real, single fact,
but it fuses the rule ("don't add a test-only hook to a shared component") with the one place that
broke it. Test it by swapping the instance: does the same 表題 still read true pointing at a different
file? `` a `data-test` hook is added to a shared component for one PR's own tests `` survives the
swap; the file-qualified version does not, which means the file was still evidence. Move the path, the
scoping comparison, and the reasoning into 概要 as separate bullets — where, then why, then the fix.

This does not mean stripping every path from 表題. `` `validate.ts:14` returns no field name on a
validation failure `` (above) keeps its path because the site *is* the fact — nothing else exhibits
the same behaviour, so there is no rule to abstract to above the instance. Apply the swap test before
deciding: if the finding is about a pattern that could recur elsewhere, evidence — a path, a quoted
value, a scoping comparison — belongs in 概要, not 表題.

**When the fix targets a mechanically checkable property, state the check, not the instances.** A
path or list of paths is evidence for a human reader to weigh against; a coding agent asked to apply
the fix instead treats every instance it is shown as the complete set to touch, since it has no reason
to go looking past what was given. If the property behind the finding is machine-checkable — a line
count, a ratio, a naming pattern — write 概要's fix as that check itself, applied over whatever scope
表題 already claims, instead of naming the paths that happened to be sampled and asking the reader to
extend from them. See [`references/examples.md`](references/examples.md), "A checkable property
stated as a list of instances," for both shapes worked out.

**概要 is a list, not a paragraph.** Write each statement as its own bullet, and keep each to one
short sentence. A three-line paragraph hides its instruction inside a subordinate clause — "since the
caller cannot tell which field failed, it might be better to…" — and hides how many separate points
you actually made. A bullet forces both into the open: if a qualifier will not fit in the sentence it
qualifies, it is either its own statement or it belongs in 詳細. Three bullets is the ceiling, not a
target; one is common and better. **Bulleted is not the same as 概要**: a list of evidence — what you
checked, a table's contents — is still 詳細, only reformatted.

For 詳細, a **line** is one written line at the width you are writing at — a GitHub comment wraps near
100 characters — so 20 lines is on the order of 2000 characters. Rewrapping to hit the count is not a
fix: if it only fits at 200 characters a line, it does not fit. Only a **fenced code block** is
excluded — a table, list, or sub-heading inside 詳細 counts as written lines, so a table buys back
nothing. 表題 is counted in sentences, since a title does not wrap by choice — a long 表題 is usually
two facts. Same remedy for both: the second belongs in 概要. Different remedy: it is a **second
application**, not a longer 概要 (the tells above).

## How firmly to state the remedy

Pick one of three, by what you can actually defend. This is the axis generated text gets wrong: it
reaches for a flat menu of options in all three cases, which reads as balanced and leaves the reader
to do the deciding.

| What you have | How to write it | What not to do |
|---|---|---|
| **A fix you can defend** | Assert it as the one to make: "fix it with `ValidationError`, as `src/order/validate.ts:22` does". A rejected option may appear **only as the constraint that rules it out** — the wall the reader would otherwise walk into — never as an option offered to them. | Do not present the alternatives you rejected as choices, and do not hedge the one you chose ("it might be worth considering…"). Both hand your decision back to the reader. |
| **Several fixes, and any of them is genuinely fine** | List them flat, with no weighting. | Do not smuggle in a preference through ordering, length, or wording. If you have a preference, you are in row 1 — say so. |
| **No fix you can name** | Switch the goal to **registering the problem**: open an issue and link it from a comment at that code. | Do not invent a vague suggestion to fill the slot, and do not drop the finding because you cannot solve it. |

**A flat list is the last resort, not the default.** When you are about to give three options, first
check whether row 1 applies. If you can weight them at all, it is row 1 — one asserted fix — not
row 2. Row 2 is only for options that are genuinely interchangeable.

**Marking a fix as optional to adopt is not the same as hedging it.** A nit can say outright that
nothing is broken today and still assert a specific fix as the one to make if you act on it — the fix
is stated with confidence; only whether it is worth the effort right now is left to the reader. That
differs from "it might be worth considering…", which hedges the fix's correctness itself. If you can
name the fix and defend it, row 1's wording stays direct even when acting on it is optional.

**A contradiction between a comment (or spec, or AC) and the code is not automatically row 1.**
Finding that a doc comment claims A while the code does B tells you the two disagree — it does not by
itself tell you A is correct and B is the bug. Prose reading as the more complete or deliberate-sounding
side is not evidence it is current: it can just as easily be a stale plan the code has already moved
past. Absent evidence that actually favors one side — a grep showing the described behavior has no
remaining callers, an explicit statement that one side is stale, the same kind of evidence any other
row-1 fix cites — this is row 2: list both fixes flat ("bring the code up to what the comment says, or
correct the comment to say what the code actually does") and let the author's own scope call pick. A
disclosed, deliberate scope split — a follow-up ticket, a "not wired yet" note, a `TODO(#N)` — is the
clearest case of this: it tells you the mismatch is intentional, not which side is wrong. Its absence
is not itself evidence either — a comment nobody has explained yet still gets the same row-2 default
until something actually favors a side.

The issue opened for row 3 is itself a decision issue, written by `write-nice-issue-description`;
what must be decided and what would settle it lands in that issue's own body, not in this finding.

Strength is **orthogonal to severity**: `critical` / `major` / `minor` / `nit` says whether the
finding blocks the merge, strength says how firmly the remedy is stated. A `major` can have no known
fix (row 3), and a `nit` can have exactly one (row 1).

## Fitting the budget

Three statements and 20 lines are not achievable by compressing prose; they are achievable by removing
what does not change what the reader does:

| Cut | Why |
|---|---|
| Preamble and meta-narration ("この PR を確認しました", "以下に詳しく説明します") | The reader knows what they opened. Start at the fact. |
| Praise and cushioning | Carries no action, and dilutes the finding after it. |
| Code, diffs, or issue text quoted back | The reader has it. Point at `path:line` instead. |
| An inventory of what you checked | Process, not instruction (`write-self-contained-docs`). |
| The same point in a summary, the details, and a closing line | Say it once, where the reader acts from. |
| Vague quantifiers standing in for a spec ("適切に", "必要に応じて") | They read as complete and specify nothing. |

If 詳細 will not fit in 20 lines, that is usually **two instructions in one** — split it into two
applications rather than compressing it.

## Self-check

1. **Budget**: 概要 at most 3 bullets of one short sentence each, 詳細 within 20 lines (code blocks
   excluded)?
2. **表題**: a fact the reader can verify, with no request or judgement mixed in — does it still read
   true if the instance is swapped for a different file? If not, is the site genuinely the only
   instance (the exception), rather than a pattern that could recur?
3. **Strength**: row 1 asserted, with no hedge and no rejected option offered as a choice (a
   constraint is fine); row 2 with no implicit weighting; row 3 registered as a problem rather than
   softened into a suggestion?
4. **Unit**: 表題 is one fact; an instance count shares one edit; every part sits in one strength row;
   no sub-heading hides inside 詳細?
5. **Delete-test**: every line that would not change what the reader does, removed?
6. **Checkable property**: if the fix targets a mechanically checkable property, is it stated as the
   check itself, rather than as the paths that happened to be sampled?

## Common Rationalizations

| Rationalization | Reality |
|---|---|
| "Listing every option is the honest thing to do." | The options you rejected are your context, not the reader's. A menu does not inform them, it moves the decision to someone with less information than you had. Assert the fix you can defend; keep the flat list for options that really are interchangeable. |
| "Asserting one fix is overbearing." | Strength is about where the decision sits, not about tone. Hedging a fix you can defend makes the reader carry your call, and they carry it worse. Politeness lives in the wording, not in the vagueness. |
| "I have no fix, so I will soften it into a suggestion." | A soft suggestion with nothing behind it sends the reader chasing a fix you never had. Register it: open an issue and link it from the code. |
| "20 lines cannot hold the explanation." | Almost always two instructions — split it (the tells catch this earlier). If truly one, the excess belongs in the linked issue, not 詳細. |
| "A paragraph reads more naturally than a bulleted summary." | It reads more naturally to *you*, because you already know which clause is the instruction. To the reader, prose lets the ask hide in a subordinate clause and hides how many points were made. Bullets make both countable — which is exactly why they feel constraining to write. |
| "Background first is kinder to the reader." | 表題 and 概要 are the fact and the fix; why goes in 詳細. A reader who cannot act after the summary's three statements stops reading, and never reaches the background. |
| "It's all one file / one PR, so it's one finding." | The unit is the **remedy**, not the subject. Different edits — or one the reader could accept while contesting the other — means two applications; bundling forces them to re-do a split you already could have made. |
| "It reads fine to me." | You are supplying the intent the text is missing as you read it. Judge it as someone holding only the text — that is the whole failure mode. |
| "I can turn any request into a fact by negating it." | Negating the request only changes its grammar, not its content — "library `A` is not introduced" carries the same information as "introduce library `A`" and no more. The fact has to be upstream: the behaviour in the code that the request is a response to. |
| "Naming the file in 表題 is more precise." | Precision at the wrong altitude reads as evidence, not a rule. A reader needs to recognise the shape of the problem before they need its address — put the file in 概要's first bullet, and swap-test 表題 for whether it still reads true pointing elsewhere. |
| "The comment/spec describes the intended behaviour, so making the code match it is the fix." | Reading as the more confident or complete side is not evidence it is the current one — the comment can just as easily be the stale half. If the PR or issue discloses the gap as a deliberate scope split, forcing the code to catch up decides a scope question that belongs to the author, not the reviewer. That is row 2 unless you have independent evidence — a grep, an explicit statement that one side is stale — that actually favors one side. |

## Examples

Worked examples of each strength row, and what overflow looks like:
[`references/examples.md`](references/examples.md). Read it when you are writing an actual finding
rather than judging one you already have.
