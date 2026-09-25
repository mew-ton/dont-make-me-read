# Worked strength rows — Bad → Good

Read this when a strength row needs a worked example: the fix you can defend, the options that are
genuinely interchangeable, or the problem you can only register. The examples are in English because
this file is — strength is a property of what you assert, not of the language you assert it in.

## A fix you can defend

**Bad: the fix is known, but written as a menu**

```markdown
This PR looks good overall, nice work! One thing about the cache key — it might be worth
considering whether it could be made a bit more stable. There are a few options: key on the
assembled query, normalize the restored form, compare the two before fetching, or leave it as is
and document the behaviour. Any of them would probably work. The tests might also have a little
more room to cover.
```

Title is an assessment rather than a fact. The four options are not equally good and the writer knows
it. The hedge leaves it unclear whether anything must change. A second instruction about tests is
bundled into the same finding. And the whole thing is prose, so none of that is countable.

**Good: one fix asserted, the rejected option kept as a constraint**

```markdown
**minor** — the cache key is derived from the raw filter form rather than from the assembled query
it represents

- `app/composables/foo/useFetchFoo.ts:23` keys `useAsyncData` on the raw filter form: the modal and
  the URL restore serialize the same conditions in two different shapes.
- One set of conditions therefore lands in `payload.data` as two entries.
- Key on the assembled query instead: `JSON.stringify(buildFooListQuery({ ... }))`.

The two shapes differ because the modal sends every key, including the ones whose value means
"all", while the URL restore stores only the keys it actually filters on. Nothing is visibly broken
today — both issue the identical `/v1/foo` request. Fixing it now is worth it because a second list
screen is adopting the same URL-restore pattern, and `useFooFilterUrlState.isSameForm` already
treats both forms as equal, which leaves the cache key as the only place the two disagree.

Do not take the normalize-the-restored-form route. `readFromQuery` deliberately leaves an
equivalent-conditions form in the shape the dialog submitted: reassigning even an equivalent object
is still a write to a `shallowRef` and re-triggers the fetch watcher, which is what took this list
from three `/v1/foo` calls down to one.

The composable's other callers (`pages/bar/index.vue` and the `asBarView: true` path) will both see
the new key string, so both need regression coverage.
```

**Listing rejected options and stating constraints are different things.** The middle paragraph is not
an alternative offered to the reader — it is the wall they would walk into on reaching for the obvious
local fix. One asserted fix, plus the constraints that make it the fix.

## Options that are genuinely interchangeable

**Good: flat, unweighted, and short**

```markdown
**nit** — `path/to/config.ts:41` emits one log line per config key

- Any of these is fine: drop the per-key logging, lower it to `trace`, or replace it with a single
  summary line carrying the key count.
```

If you would be mildly disappointed by any of the options you are about to list, you have a fix you
can defend and should say which. A flat list is for the case where you genuinely would not review the
choice.

**Bad: the comment reads as correct, so the code is asserted as the thing to fix**

```markdown
**major** — the header comment at `useBarSender.ts:8` says a failed send is retried once and then
dropped, but `sendBar()` implements no retry and discards the payload immediately on failure

- Implement the retry that `sendBar()`'s comment describes.
```

The comment reads as the more deliberate, more complete side, so it gets asserted as ground truth —
but nothing here establishes that the retry is the missing half rather than a leftover description of
a plan the code already moved past.

**Good: the disclosure is what makes the fixes interchangeable**

```markdown
**major** — the header comment and the code it describes disagree about the retry behaviour

- The header comment at `useBarSender.ts:8` says a failed send is retried once and then dropped,
  but `sendBar()` implements no retry and discards the payload immediately on failure.
- The PR body's own "Seams" section defers retry handling to the queue-based sender (a follow-up
  ticket), and nothing states that a retry is still expected in this PR.
- Either implement the retry, or correct the comment to say retries are not in place yet and link
  the follow-up ticket — whichever the author has already decided.
```

Nothing available here says which side is the bug: the comment could be a stale plan, or this PR could
be an intentionally partial step toward it. Asserting "add the retry" would decide that scope question
instead of reporting it.

Two concrete fixes exist — implement the retry, or make the comment state the deferral — and either
one resolves the contradiction, so this is not the case where no fix can be named. Nor is it a fix
you can defend: nothing here, no grep and no explicit statement, favors one side. Once something does
(the PR body says outright "the comment is stale, ignore it"), name that fix and assert it.

## No fix you can name

The goal changes: you are no longer instructing a fix, you are **registering the problem** so it is
not lost. Two shapes, by where you are writing.

**Good: in a PR review — open an issue and link it from the code**

```markdown
**major** — `pages/foo/[id].vue:24` swallows `useAsyncData`'s `error`

- On failure the body renders empty, and the reader is shown an article with no text in it.
- There is no fix to include in this PR. Two things have to be decided first.
- Open an issue covering both and link it from a `TODO(#N)` at the fetch site.

`fooBlocks` falls back to `[]` and `isLocked` to `false`, so the failure shows up neither in the UI
nor in the DOM. There are two reasons it cannot be fixed here. No spec defines the failure copy, so
implementing it would make the implementer the author of user-facing text. And this page is mounted
from several routes — the article list, search results, external links — each with a different
layout, so there is no basis for deciding that the failure UI belongs to this one. Where the failure
renders is an open design question.
```

The finding is not softened into "maybe consider handling the error", and it is not dropped for being
unsolvable. Summary carries the fact and the instruction; the reasons a fix cannot be named are
Details.

**Good: where the fix itself opens a new issue**

```markdown
**major** — the STG environment badge renders white text on `#ff2a1f`, a contrast ratio of 3.75:1,
below the 4.5:1 AA threshold that applies to 16px bold

- There is no fix to include in this PR. An accessible color pairing is a design decision, not an
  implementation detail.
- Open an issue carrying the measured alternatives and what has to be decided, and link it from a
  comment on the `stg` entry in `path/to/resolveEnvironmentBadge.ts`.
```

The linked issue is where the non-options get closed off and the decision is named.
