# Worked Titles — Bad → Good

Read this when a Title needs measuring against a worked pair. Each pair names what it repairs: a
Title fused to its one instance, a Title that only negates the request, and a lead line carrying two
remedies at once. The examples are in English because this file is; the shape is what they teach.

## The rule and its one instance, fused into Title

**Bad**

```markdown
**minor** — the comment attached to `FooDetail.vue:4-16` is too long

- It carries the related issue and incident history, all for a change that only adjusts a width.
- The same tendency shows up in various other places.
- Please review the comments.
```

Swapping the file breaks the sentence — it stops being about this bug and starts being about a
different one. So the file is evidence, not the fact Title should state, and Summary already says as
much ("the same tendency shows up in various other places"), which makes a Title naming just the one
file a missed abstraction rather than a lack of awareness. The fix is also vague ("please review the
comments") where the Good version states a checkable rule.

**Good**

```markdown
**minor** — comments are too long

- An LLM tends to write verbose, flat comments that run to three lines or more.
- Even a supplementary comment becomes text the reader has to stop and work through once that
  tendency is strong enough.
- Delete or compress to one line any comment that, after the fix, runs past three lines excluding
  blank lines.
```

Title now reads true for any comment that grew this way, anywhere it recurs. Summary grounds it in
the mechanism (LLM comment habits) and in the checkable fix, rather than in the one path that
happened to trigger it — this example generalizes all the way, with no file needed to anchor it. It
also happens to win twice: Title sits at the rule, and separately its fix is stated as a countable
check rather than as a list of files to look at.

## Title only negates the request

**Bad**

```markdown
**minor** — `FooDetail.vue:140` embeds a compound condition directly in `v-if` (not extracted into
a named computed)
```

Title is the request ("extract it into a named computed") with the polarity flipped, not an
observation: "not extracted into…" restates what the fix would do, in reverse, and carries no more
information than the ask itself. It also fuses in the one file that happened to trigger it — a
second, independent problem, and fixing one does not excuse the other.

**Good**

```markdown
**minor** — compound and complex conditional expressions are written directly in the template
```

The fact is upstream of the request: what the template is actually doing today (a condition written
inline), not the mirror image of what the writer wants instead (extracted to a computed). That is
what justifies the fix without the Title itself being the ask, flipped.

## One lead line, two remedies

**Bad**

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
The tells that fired: Title joins two facts, the parts sit at different strength rows, and Details
grew a sub-heading per instruction.

**Good: split by remedy, not by subject**

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

Filing them together hides the row-3 problem under the row-1 fix: a reader who applies the rename
sees the finding as resolved, and the coverage gap that was never addressed goes with it.
