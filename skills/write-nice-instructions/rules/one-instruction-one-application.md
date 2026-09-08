# One instruction, one application

Read this before writing Details, or whenever a draft feels like it's carrying more than one point.

**Four tells a draft is already two applications under one Title**, readable before Details exists —
earlier than a 20-line overflow ([`fitting-the-budget.md`](fitting-the-budget.md)) catches the same
thing:

- Title joins two facts ("… and also …") instead of stating one.
- Title counts instances ("4 occurrences"), not all closing with the same edit.
- Parts sit at different strength rows ([`remedy-strength.md`](remedy-strength.md)) — a fix for one,
  none for another.
- Details wants a sub-heading — that heading is the second instruction's name.

Split on any of these, before writing Details.

**Overflow is the same signal, caught later.** A Details that will not fit 20 lines is usually two
instructions sharing one application — for example a cache key that diverges *and* the rollout of the
same URL-restore pattern to three more list screens. Those have different owners, different acceptance
criteria, and different review outcomes; keep the finding on the divergence and file the rollout
separately. A Summary that will not fit three statements is the same signal, one level earlier: if the
fourth bullet is another fact, it is Details; if it is another instruction, it is another application.

## Bad: one lead line, two remedies

```markdown
**major** — one of the mutation checks does not actually fail, and the shipped behaviour has no
automated test

This PR's regression suite claims seven mutation checks, but one stays green even with the guard it
targets removed. Separately, nothing in the suite verifies that the five-level breadcrumb actually
renders — the page-level test still mocks the list as empty.

### Why the mutation does not fail

`useFooFilterSummary.spec.ts:100-113` sets `fooSlug` to a non-empty value, so the neighbouring
`barRequest` fetch starts immediately and was blocked on the same gate as the removed
`await extras`. Dropping `extras` from `Promise.all` leaves that fetch pending all the same, so the
assertion keeps passing.

### What no test covers

`grep -rn "toHaveLength(5)" test/` returns nothing. The e2e JSON-LD assertion is still an `it.todo`,
and the page spec mocks `breadcrumbs: ref([])`, so the render path from the filter composable
through to the page is unverified.
```

Both facts are true and both matter, which is exactly why this reads as reasonable — but they call
for different remedies: one is fixed by editing the test, the other has no fix to assert here at all.

## Good: split by remedy, not by subject

```markdown
**major** — `useFooFilterSummary.spec.ts:100-113` stays green even with `extras` dropped from
`Promise.all`

- The assertions at :108/:113 are actually guarded by the neighbouring `barRequest` fetch, not by
  `extras` — removing `extras` from the awaited list does not turn this test red.
- Rename the test and its comment to match what it actually guards, and drop `extras` from the list
  of mutations this test claims to cover.
- Do not remove `extras` from `Promise.all` itself — the `Promise<unknown>[]` annotation there
  exists to catch a future narrowing of `useFetchExtras`'s return type, and removing it loses that.
```

```markdown
**major** — no automated test verifies the five-level breadcrumb that ships

- `grep -rn "toHaveLength(5)" test/` returns nothing, the e2e JSON-LD assertion is still an
  `it.todo`, and the page spec mocks `breadcrumbs: ref([])` — every existing test passes no matter
  where the path from the filter composable to the page render breaks.
- There is no fix to include in this PR. Filling in the `it.todo` is separate work.
- Open an issue for the `it.todo` and state in this PR that the behaviour was verified by manual
  check only.
```

Filing them together hides the row-3 problem under the row-1 fix: a reader who applies the rename sees
the finding as resolved, and the coverage gap that was never addressed goes with it.
