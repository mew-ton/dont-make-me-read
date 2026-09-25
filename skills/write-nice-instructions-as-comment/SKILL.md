---
name: write-nice-instructions-as-comment
description: >
  Drafts and revises an instruction written as a comment — a PR review finding, a reply proposing a
  change, a remark asking someone to fix something — text one person reads, acts on, and can answer
  back to. Does not apply when the instruction is a standing rule the reader will meet again rather
  than a remark they can answer, or when it is the body of a GitHub issue.
user-invocable: false
disable-model-invocation: false
context: fork
background: false
---

## Overview

This skill drafts and revises an instruction written as a comment so that its reader can act from
the first few lines. A comment has a reader who can answer back, which is what separates it from a
rule, and inside those lines they decide whether to act, skim, or argue. The finding is judged by
what that reader must hold before they can act, and the budgets below are tight because a person
decides that fast.

## How to work

- **Settle what the one instruction is before writing a line.** The unit is the remedy, not the
  subject: one edit answers the whole finding, and a part needing a second edit is a second finding.
- **Write Title, then Summary, then Details, and stop as soon as the reader can act.**
- **Pick the strength row from what you can actually defend**, before wording the fix.
- **Get inside the budgets by removing what does not change what the reader does** — never by
  compressing prose or rewrapping lines.
- **Judge the draft as someone holding only the text.** You are supplying the intent it is missing
  as you read it, and that is the whole failure mode.

## One instruction, one application

The template applies **once per instruction** — never once per document containing several. In a PR
review that is **one application per finding**: Title is the finding's lead line
(`**<severity>** — <fact>`), and Summary is its opening.

**Tells that a draft is already two applications under one Title:**

- Title joins two facts ("… and also …") instead of stating one.
- Title counts instances ("4 occurrences") that do not all close with the same edit.
- Parts sit at different strength rows — a fix for one, none for another.
- Details wants a sub-heading. That heading is the second instruction's name.

Split on any of those, before writing Details.

**Overflow is the same signal, caught later.** Details that will not fit 20 lines is usually two
instructions sharing one application — a cache key that diverges *and* the rollout of the same
URL-restore pattern to three more list screens. Those have different owners, acceptance criteria and
review outcomes: keep the finding on one, file the other separately. A Summary that will not fit
three statements is the signal one level earlier — a fourth bullet that is another fact is Details,
and one that is another instruction is another application.

Filing two together hides the weaker half under the stronger: a reader who applies the asserted fix
sees the whole finding as resolved, and the part nobody addressed goes with it.

## The template

| Part | What goes in it | Budget |
|---|---|---|
| **Title** | The observed **fact**, and nothing else, at the altitude the rules below set. Not a request, not an assessment, not how it made you feel. | **one sentence** — if it needs a second, the rest is Summary |
| **Summary** | The fact, and what should be done about it. The reader can act from this alone. | **at most 3 short statements** — one fact or one instruction each |
| **Details** | The how and the why behind that fix. Omit it where the summary already carries them. | **20 lines**, code blocks excluded |

**Summary is a list, not a paragraph.** One short sentence per bullet. A three-line paragraph hides
its instruction in a subordinate clause — "since the caller cannot tell which field failed, it might
be better to…" — and hides how many separate points you made; a bullet forces both into the open. A
qualifier that will not fit in the sentence it qualifies is either its own statement or it belongs in
Details. Three bullets is the ceiling, not a target; one is common and better. **Bulleted is not the
same as Summary**: a list of evidence — what you checked, a table's contents — is still Details, only
reformatted.

For Details, a **line** is one written line at the width you are writing at — a GitHub comment wraps
near 100 characters — so 20 lines is on the order of 2000 characters. Rewrapping to hit the count is
not a fix: if it only fits at 200 characters a line, it does not fit. Only a **fenced code block** is
excluded, so a table, list or sub-heading inside Details counts as written lines and buys nothing
back. Title is counted in sentences, since a title does not wrap by choice.

## The rules

Each is a condition on how the parts above are written, and a finding against a draft names which
one failed.

### Title states the rule, not the one instance that broke it

A Title can be one honest fact and still sit at the wrong altitude: fused with the one instance that
broke it. **The swap test** — does the same Title still read true pointing at a different file? If
not, the file, the comparison and the reasoning are evidence rather than the fact, and belong in
Summary as separate bullets: where, then why, then the fix. A Summary that already says the tendency
shows up elsewhere, under a Title naming one file, has failed the test by its own admission.

**This does not mean stripping every path from Title.** `` `validate.ts:14` returns no field name on
a validation failure `` keeps its path because the site *is* the fact: nothing else exhibits the
behaviour, so there is no rule to abstract to above the instance. Run the swap test before deciding
— where the finding is about a pattern that could recur, the evidence goes to Summary.

### Never negate the request and call it the fact

"Extract this into a named computed" rewritten as "not extracted into a named computed" is
checkable, and still the request wearing Title's shape: it names the absence of what was asked for
and carries no more information than the ask. The fact sits upstream of the request — what the code
is doing today that the request is a response to. "Compound conditions are written directly in the
template" is the fact; "not extracted into a computed" is the ask, reversed.

This holds where the finding proposes a better idea rather than reporting something broken. The
upstream fact does not have to be why the code is broken; it can be why the code is shaped the way
it is today. It is never the proposal's own negation.

### State the remedy as firmly as you can defend it, and no firmer

Pick one of these. This is the axis generated text gets wrong: it reaches for a flat menu of options
whichever row it is in, which reads as balanced and leaves the reader to do the deciding.

| What you have | How to write it | What not to do |
|---|---|---|
| **A fix you can defend** | Assert it as the one to make: "fix it with `ValidationError`, as `path/to/validate.ts:22` does". A rejected option may appear **only as the constraint that rules it out** — the wall the reader would otherwise walk into — never as an option offered to them. | Do not present the alternatives you rejected as choices, and do not hedge the one you chose ("it might be worth considering…"). Both hand your decision back to the reader. |
| **Several fixes, and any of them is genuinely fine** | List them flat, with no weighting. | Do not smuggle a preference in through ordering, length or wording. If you have a preference, you have a fix you can defend — say so. |
| **No fix you can name** | Switch the goal to **registering the problem**: open an issue and link it from a comment at that code. | Do not invent a vague suggestion to fill the slot, and do not drop the finding because you cannot solve it. |

**A flat list is the last resort, not the default.** About to offer a menu, ask first whether you can
defend one of them: if you can weight them at all, you have a fix you can defend, and you assert that
one. A flat list is for options you genuinely would not review the choice between.

**Marking a fix as optional to adopt is not hedging it.** A nit can say outright that nothing is
broken today and still assert one specific fix as the one to make if you act on it — the fix is
stated with confidence, and only whether it is worth the effort now is left to the reader. That
differs from "it might be worth considering…", which hedges the fix's correctness itself.

**A contradiction between a comment (or spec, or AC) and the code is not automatically a fix you can
defend.** That
a comment claims A while the code does B tells you the two disagree, not that A is right and B is the
bug: prose reading as the more complete or deliberate side can as easily be a stale plan the code
moved past. Absent evidence that actually favours one side — a grep showing the described behaviour
has no remaining callers, an explicit statement that one side is stale, the same evidence any other
asserted fix cites — the fixes are interchangeable: list both flat ("bring the code up to what the
comment says, or correct the comment to say what the code does") and let the author's own scope call
pick. A
disclosed scope split — a follow-up ticket, a "not wired yet" note, a `TODO(#N)` — is the clearest
case: it says the mismatch is intentional, not which side is wrong. Its absence is not evidence
either, so an unexplained comment keeps the flat list until something favours a side.

Strength is **orthogonal to severity**: `critical` / `major` / `minor` / `nit` says whether the
finding blocks the merge, strength says how firmly the remedy is stated. A `major` can have no known
fix to name, and a `nit` can have one you can defend.

Where no fix can be named, the issue you open is itself a decision issue: what has to be decided, and
what would settle it, lands in that issue's own body, not in this template — while the finding
carries the fact, the instruction to register it, and the reasons a fix cannot be named.
"Investigation is needed", on its own, does not register the problem; it is registering it with the
work left out.

### Write it in the language its readers already use

The language of the repository, the review thread and the surrounding comments. Every rule here is
about the finding's **shape** — Title / Summary / Details, the budgets, the strength rows — and
applies the same way whichever language you post in. Two places a translated finding slips:

- **Budgets are counted in the language you post in.** Details that fits 20 lines in one language and
  not in another is over budget in the second, and the remedy is the usual one: it is two
  instructions in one, not a wrapping problem.
- **Never post the same finding twice in two languages.** A bilingual comment doubles the reading
  cost and hides how many separate points were actually made.

## Which file to read

| The question | Read |
|---|---|
| The fix is about to name the sites you sampled | [`references/stating-the-fix-as-a-check.md`](references/stating-the-fix-as-a-check.md) |
| The draft is running long and you are about to compress its prose | [`references/fitting-the-budget.md`](references/fitting-the-budget.md) |
| A worked Bad → Good pair for a Title fused to its instance, negating the request, or carrying two remedies | [`references/examples-title.md`](references/examples-title.md) |
| A worked example of each strength row, the comment-versus-code case included | [`references/examples-remedy-strength.md`](references/examples-remedy-strength.md) |
| The draft is finished and about to be posted | [`VERIFICATION.md`](VERIFICATION.md) |

## Common Rationalizations

| Rationalization | Reality |
|---|---|
| "Listing every option is the honest thing to do." | The options you rejected are your context, not the reader's. A menu does not inform them, it moves the decision to someone with less information than you had. Assert the fix you can defend; keep the flat list for options that are really interchangeable. |
| "Asserting one fix is overbearing." | Strength is about where the decision sits, not about tone. Hedging a fix you can defend makes the reader carry your call, and they carry it worse. Politeness lives in the wording, not in the vagueness. |
| "I have no fix, so I will soften it into a suggestion." | A soft suggestion with nothing behind it sends the reader chasing a fix you never had. Register it: open an issue and link it from the code. |
| "20 lines cannot hold the explanation." | Almost always two instructions — split it; the tells catch this earlier. If it truly is one, the excess belongs in the linked issue, not in Details. |
| "A paragraph reads more naturally than a bulleted summary." | It reads more naturally to *you*, because you already know which clause is the instruction. To the reader, prose lets the ask hide in a subordinate clause and hides how many points were made. Bullets make both countable — which is why they feel constraining to write. |
| "Background first is kinder to the reader." | Title and Summary are the fact and the fix; why goes in Details. A reader who cannot act after the summary's three statements stops reading, and never reaches the background. |
| "It's all one file / one PR, so it's one finding." | The unit is the **remedy**, not the subject. Different edits — or one the reader could accept while contesting the other — are two applications, and bundling them makes the reader re-do a split you could have made. |
| "It reads fine to me." | You are supplying the intent the text is missing as you read it. Judge it as someone holding only the text — that is the whole failure mode. |
| "I can turn any request into a fact by negating it." | Negating the request changes its grammar, not its content — "library `A` is not introduced" carries the same information as "introduce library `A`" and no more. The fact has to be upstream: the behaviour in the code that the request is a response to. |
| "Naming the file in Title is more precise." | Precision at the wrong altitude reads as evidence, not a rule. A reader recognises the shape of the problem before they need its address — put the file in Summary's first bullet, and swap-test Title. |
| "The comment/spec describes the intended behaviour, so making the code match it is the fix." | Reading as the more complete side is not evidence it is the current one; the comment can be the stale half. Asserting the code as the thing to fix also decides a scope question that belongs to the author. The fixes stay interchangeable unless a grep or an explicit statement favours a side. |
| "The examples in this skill are in English, so the finding should be too." | The examples are in English because the skill is. Post in the language the repository's reviews already use — the shape is what this skill fixes, not the language. |

## Red Flags

- A Title carrying the path or identifier that is evidence for the rule, rather than the rule.
- A Title that is the request with a "not" inserted.
- A Title that is a request, an assessment, or how it made you feel.
- A Summary paragraph with its instruction inside a subordinate clause.
- Options offered where you have a fix you can defend.
- A fix bound to the files you happened to sample — "compress these".
- A sub-heading inside Details.
