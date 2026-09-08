# Worked examples

Read this when you are about to write an actual finding. Each example is **one
application** of the template (表題 / 概要 / 詳細) from `SKILL.md`, and they are ordered by the
strength row they demonstrate — that is the axis generated text gets wrong most often.

In every Good example the 概要 is **a list of at most three short statements**, not a paragraph, and
詳細 stays within 20 lines excluding code blocks. The Bad examples are the shapes that come out when
the template is not applied.

## Row 1 — a fix you can defend

### Bad: the fix is known, but written as a menu

```markdown
This PR looks good overall, nice work! One thing about the cache key — it might be worth considering
whether the key could be more stable. There are a few options: you could key on the built query, or
normalise the restored form, or compare the forms before fetching, or leave it and document the
behaviour. Any of these would probably work. Also the tests could potentially cover more here.
```

表題 is an assessment rather than a fact. The four options are not equally good and the writer knows
it. The hedge leaves it unclear whether anything must change. A second instruction about tests is
bundled into the same finding. And the whole thing is prose, so none of that is countable.

### Good: one fix asserted, the rejected option kept as a constraint

```markdown
**minor** — a cache key is derived from the raw filter form instead of the built query it represents

- `app/composables/product/useFetchProducts.ts:23` keys `useAsyncData` on the raw filter form: the
  modal and URL restore serialise one condition two ways.
- So a single condition registers two `payload.data` entries.
- Key on the built query instead: `JSON.stringify(buildProductListQuery({ ... }))`.

The two spellings differ because the modal submits every key including its `"all"` sentinels, while URL
restore stores only the keys that narrow the list. Nothing is visibly broken today — both issue the
identical `/v1/products` request. It is worth fixing now because a second list screen is adopting the
same URL-restore pattern, and
`useProductFilterUrlState.isSameForm` already treats the two forms as equal, which leaves the cache key
as the only place they disagree.

Do not normalise the restored form instead. `readFromQuery` deliberately leaves an equal condition's
form exactly as the dialog submitted it, because re-assigning an equivalent object is still a
`shallowRef` write and re-triggers the fetch watcher — that is what took this list from three
`/v1/products` calls to one.

The other consumers of this composable (`pages/catalog/index.vue` and the `asArchiveView: true` path)
see a new key string, so both need regression coverage.
```

**Listing rejected options and stating constraints are different things.** The middle paragraph is not
an alternative offered to the reader — it is the wall they would walk into on reaching for the obvious
local fix. One asserted fix, plus the constraints that make it the fix.

### Bad: 表題 only negates the request

```markdown
**minor** — library `A` is not introduced

- Date formatting is hand-rolled at every call site.
- Introduce library `A`.
```

表題 is the request ("introduce library `A`") with the polarity flipped, not an observation. It is
checkable in the trivial sense — grep confirms `A` is absent — but it carries no more information
than the request itself, and does not say why the absence is a problem.

### Good: 表題 names the behaviour the request responds to

```markdown
**minor** — `src/report/*.ts` formats dates with five different ad-hoc `Intl.DateTimeFormat` presets

- Date formatting is hand-rolled at every call site.
- Introduce library `A`.
```

The fact is upstream of the request: what the five call sites are actually doing today, not the
mirror image of what the writer wants instead. 概要 is untouched from the Bad version — only 表題
changes, from the negated request to the behaviour that makes it necessary.

### Good: an opportunity finding still needs an upstream fact, not the proposal's negation

```markdown
**nit** — two interfaces, `resolveCategoryLabel` and `resolveProductLabel`, are meshed together into
an awkward shape

- `resolveProductLabel` is really just three arguments `or`-ed together in sequence, and
  `resolveCategoryLabel`'s interface was built to match that shape.
- Nothing else calls it, so this is cheap to fix now.
- Simplify it to `resolveProductLabel(FilterContext): string`.
```

This finding is not a defect report — nothing here is broken today — but it still needs the same
upstream move. 表題 names the structural fact (why the two interfaces ended up shaped this way), not
"resolveCategoryLabel is not simplified" or any other negation of the fix. 概要's second bullet
("nothing else calls it, so this is cheap to fix now") is neither the defect fact nor the fix, but it
is still a fact — one that argues why now is the cheapest time to act — so it sits in 概要 on the same
footing as the other two. The third bullet's "might as well" phrasing matches SKILL.md's "Marking a
fix as optional to adopt is not the same as hedging it": the fix stays row 1, only its adoption is
left open.

## Row 2 — options that are genuinely interchangeable

### Good: flat, unweighted, and short

```markdown
**nit** — `src/config/load.ts:41` logs one line per config key

- Any of these is fine: drop the per-key log, lower it to `trace`, or replace it with one summary line
  carrying the key count.
```

If you would be mildly disappointed by one of the three, you are in row 1 and should say which. Row 2
is for the case where you genuinely would not review the choice.

### Bad: the comment reads as correct, so the code is asserted as the thing to fix

```markdown
**major** — `useNotificationDigest.ts:8`'s header comment says a failed send is retried once before
it is dropped, but `sendDigest()` has no retry — a failure drops the digest immediately.

- Add the retry `sendDigest()`'s comment describes.
```

The comment reads as the more deliberate, more complete side, so it gets asserted as ground truth — but
nothing here establishes that the retry is the missing half rather than a leftover description of a
plan the code already moved past.

### Good: the disclosure is what moves it to row 2

```markdown
**major** — a header comment and the code it documents disagree about retry behaviour

- `useNotificationDigest.ts:8`'s header comment says a failed send is retried once before it is
  dropped; `sendDigest()` has no retry, so a failure drops the digest immediately.
- The PR body's own "Seams" section defers retry handling to the queue-backed sender (a follow-up
  ticket) — nothing here says the retry is still wanted in this PR.
- Either add the retry, or edit the comment to say sends are not retried yet and link the follow-up
  ticket — whichever the author already decided.

Nothing available here says which side is the bug: the comment could be a stale plan, or this PR could
be an intentionally partial step toward it. Asserting "add the retry" would decide that scope question
instead of reporting it.
```

Two concrete fixes exist — implement the retry, or make the comment state the deferral — and either one
resolves the contradiction, which is why this is row 2 and not row 3. It is not row 1 either: nothing
here, no grep and no explicit statement, favors one side over the other. Once something does (the PR
body says outright "the comment is stale, ignore it"), name that fix and move to row 1.

## Row 3 — no fix you can name

The goal changes: you are no longer instructing a fix, you are **registering the problem** so it is
not lost. Two shapes, by where you are writing.

### Good: in a PR review — open an issue and link it from the code

```markdown
**major** — `ContentsArticleBody.server.vue:31` discards `error` from `useAsyncData`

- On failure the body renders empty, and a reader sees an article with no text.
- No fix belongs in this PR; two things have to be decided first.
- Open an issue carrying both, and link it from a `TODO(#N)` at the fetch.

`openBlocks` falls back to `[]` and `isGated` to `false`, so the failure appears in neither the UI nor
the DOM. It cannot be fixed here for two reasons. The failure copy is undefined in every spec, so
implementing one would make the implementer the author of user-facing copy. And because the Island is a
`.server.vue` that fetches for itself, the page mounting it never receives the error — so "the page owns
the failure UI" cannot hold as currently written, and where the failure renders is an open design
question.
```

The finding is not softened into "maybe consider handling the error", and it is not dropped for being
unsolvable. The 概要 carries the fact and the instruction; the reasons a fix cannot be named are 詳細.

### Registering the problem when the fix opens a new issue

```markdown
**major** — the STG environment badge draws white text on `#ff2a1f`, 3.75:1, against the 4.5:1 AA
threshold that applies at 16px bold

- No fix belongs in this PR; the accessible fill is a design decision, not an implementation detail.
- Open an issue with the measured alternatives and the decision to make, and link it from a comment
  at `app/utils/environment/resolveEnvironmentBadge.ts`'s `stg` entry.
```

"Investigation is needed" on its own is not row 3 — it is row 3 with the work left out. The linked
issue is where the non-options get closed off and the decision named; that issue's own body is
written with `write-nice-issue-description`, not with this template.

## Two instructions wearing one 表題

The bundling that the four tells (`SKILL.md`) catch most often is this: a test-integrity gap and a
coverage gap, about the same code, filed as one finding because they share a subject — not because
they share a fix.

### Bad: one lead line, two remedies

```markdown
**major** — one of the mutation checks doesn't actually fail, and the shipped behaviour has no
automated test

The regression suite for this PR claims seven mutation checks, but one stays green when the guard it
names is removed. Separately, nothing in the suite asserts the five-level breadcrumb actually renders
— the page-level test still mocks the list as empty.

### Why the mutation doesn't fail

`useListingFilterSummary.spec.ts:100-113` sets `districtSlug` non-empty, so the sibling
`regionIdsRequest` fetch starts immediately and blocks on the same gate the removed `await amenities`
used to. Pulling `amenities` out of `Promise.all` leaves that fetch pending regardless, so the
assertion still passes.

### What no test covers

`grep -rn "toHaveLength(5)" test/` returns nothing; the e2e JSON-LD assertion is `it.todo`; the page
spec mocks `breadcrumbs: ref([])`, so the render path between the filter composable and the page is
unverified.
```

Both facts are true and both matter, which is exactly why this reads as reasonable — but they call
for different remedies: one is fixed by editing the test, the other has no fix to assert here at all.

### Good: split by remedy, not by subject

```markdown
**major** — `useListingFilterSummary.spec.ts:100-113` stays green with `amenities` removed from
`Promise.all`

- The assertion at :108/:113 is actually guarded by the sibling `regionIdsRequest` fetch, not by
  `amenities` — dropping `amenities` from the wait list does not turn this test red.
- Rename the test and its comment to describe what it actually guards, and drop `amenities` from the
  mutation list this test was claimed to cover.
- Do not drop `amenities` from `Promise.all` itself — the `Promise<unknown>[]` annotation there is
  what would catch a future narrowing of `useFetchAmenities`'s return shape; removing it loses that.
```

```markdown
**major** — no automated test verifies the shipped five-level breadcrumb

- `grep -rn "toHaveLength(5)" test/` returns nothing, the e2e JSON-LD assertion is `it.todo`, and the
  page spec mocks `breadcrumbs: ref([])` — a break anywhere between the filter composable and the page
  render would pass every existing test.
- No fix belongs in this PR; filling in the `it.todo` is its own piece of work.
- Open an issue for the `it.todo`, and note in this PR that the behaviour is verified only by manual
  check.
```

Filing them together hides the row-3 problem under the row-1 fix: a reader who applies the rename sees
the finding as resolved, and the coverage gap that was never addressed goes with it.

## 表題 written as evidence, not the rule

The swap test (`SKILL.md`) catches a different failure than the four tells: not two instructions
sharing one 表題, but one honest fact written at the wrong altitude — the file, the scope, and the
reasoning all fused into the lead line instead of split into 概要.

### Bad: the rule and its one instance fused into 表題

```markdown
**major** — `FieldDisplay.vue`'s fallback branch adds `data-test="field-display-fallback"`, referenced
only by this PR's two test files, while `AppFieldDisplay` itself is shared across 17+ screens
```

Swapping the file breaks the sentence — it stops being about this bug and starts being about a
different one. That means the file, and the comparison that justifies the finding, are evidence, not
the fact 表題 should state.

### Good: 表題 names the rule, 概要 carries the instance

```markdown
**major** — a `data-test` hook is added to a shared component for one PR's own tests

- `FieldDisplay.vue`'s fallback branch adds `data-test="field-display-fallback"`; `AppFieldDisplay` is
  shared across 17+ screens and only this PR's two test files reference the new hook.
- The fallback text ("未入力") is fixed and already i18n-resolved, so both tests can assert on text
  instead of the hook.
- Revert to `<template v-if="isShowFallbackContent">` with no `data-test`, and switch both tests to
  `wrapper.text()` / `.findAllComponents(AppFieldDisplay)` plus `.text()`.
```

表題 now reads true for any shared component a PR-only hook gets added to; the file that happened to
trigger it moved to 概要's first bullet.

### Bad: an instance-specific comment change written as if it were the whole finding

```markdown
**minor** — `MemberRequirementDetail.vue:4-16`, the reason `requirement` dropped `| null` is appended
to the file's whole-component doc comment, roughly doubling its length
```

This reads as a fact about one file, but the underlying problem — a comment growing past what its
adjacent diff explains — is the kind of thing that recurs across a PR's other files too, and 表題 gives
the reader no reason to go look.

### Good: 表題 states the pattern, 概要 offers this file as the example and widens the fix

```markdown
**minor** — a one-field type change grows the file's whole-component doc comment

- `MemberRequirementDetail.vue:4-16` is the clearest instance: the reason `requirement` dropped
  `| null` is appended to the component-level comment instead of sitting on the field, roughly
  doubling the comment's length.
- Move the explanation to sit directly above `requirement: MemberProfileRequirementViewModel` (or on
  `interface Props`), and check the rest of the PR for comments that grew the same way.
```

## A checkable property stated as a list of instances

Both examples above still name at least one file, because the underlying fact is not fully
mechanical — a reader has to judge whether a hook is test-only, or whether a comment explains its
adjacent diff. Some findings are different: the property behind them (a line count, a ratio, a
naming pattern) is checkable without judgment, and the fix can be written as that check instead of
as a list of files.

### Bad: a demonstrative pronoun re-narrows a correctly stated 表題 back to the files just listed

```markdown
**minor** — comments take up too much of the file in several places

`shared/types/contents/detail.ts` is 79% comment lines (52/66), `app/view-model/contents-detail/type.ts`
is 73% (55/75), and two more files run the same way. Compress these into one short, factual
intent label per declaration, and drop the field-by-field justifications.
```

表題 already sits at the right altitude — it does not name a file. But "compress **these**" binds the
fix to exactly the files just listed, the same way a file-qualified 表題 would. A reader can tell
"these" means "at least the files above, and probably others like them," but a coding agent applying
the fix has no reason to look past what it was handed — every other file in the diff at the same
comment ratio is left untouched.

### Good: the fix is the check itself, so no file needs to anchor it

```markdown
**minor** — comments take up too much of the file in several places

- Every declaration this PR touches — type, function, or field — gets a comment. Several run past
  3 lines, mostly restating field-by-field justification rather than the declaration's intent.
- For every declaration-level comment in this diff that runs 3+ lines, compress it to one short,
  factual intent label and drop the justification.
```

The fix is now a rule ("3+ lines → compress") instead of a set of paths, so it already covers every
file the diff touches — there is nothing for "these" to under-select, and nothing left over for a
later review to have to re-flag.

### Bad: a re-check embeds the sampled path back into 表題, and reports a partial sample as if it were the whole PR

```markdown
**minor** — the comment-density pattern from the prior review is unresolved, concentrated in
newly added `server/utils/contents/**.ts` files

The four originally-flagged files are fixed. Sampling the new `server/utils/contents/**.ts` files
and a set of `.vue` components: the `.ts` files still run 35-45% comment lines against the `.vue`
files' 2-6% — not a uniform pattern across the PR. Reduce comments in the newly added
`server/utils/contents/**.ts` files the same way.
```

This fails the swap test — drop `server/utils/contents/**.ts` from 表題 and it still reads true
("the prior pattern recurs in newly added files"), so the path was evidence, not the fact. "Not a
uniform pattern" also overstates what two sampled categories can support: files outside both
categories were never checked, so their absence from the finding is silence, not a clean bill.

### Good: 表題 stays at the recurrence, 概要 names the sample's own boundary and re-applies the original check everywhere

```markdown
**minor** — the prior review's comment-density pattern recurs in newly added files

- The prior fix (246d78150) applied "declaration-level comments over 3 lines get compressed to a
  factual intent label" to the four files named then. Newly added files were never checked against
  it.
- Re-run that same check across every file this PR adds, not only the ones sampled here — this
  finding covers what two categories happened to show, not what the rest of the diff does.
```

Stating the original check again, instead of the two categories that happened to be sampled, means
the fix already reaches whatever else in the diff would have failed it — sampling more categories
would only add evidence, never change what the fix asks for.

## When the budget overflows

This is the same split decision as above, caught by a slower signal: overflow shows up only after
詳細 is drafted, where the tells above catch it before you start writing. Overflow is the signal to
split, not to compress. A 詳細 that will not fit 20 lines is usually two
instructions sharing one application — for example a cache key that diverges *and* the rollout of the
same URL-restore pattern to three more list screens. Those have different owners, different acceptance
criteria, and different review outcomes; keep the finding on the divergence and file the rollout
separately.

A 概要 that will not fit three statements is the same signal, one level earlier: if the fourth bullet
is another fact, it is 詳細; if it is another instruction, it is another application.

The exception is a case whose *evidence* is bulky — a measurement table, a repro log. Evidence in a
code block sits outside the budget; evidence narrated in prose does not, so put it in the block. Once
a table's own size is what would overflow 詳細, fence the table itself in the text you actually post
— this file's outer ```markdown fence is its own display convention, not that fence.
