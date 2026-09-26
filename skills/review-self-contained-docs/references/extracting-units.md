# Extracting the units

Read this when the brief names a PR and its diff has to become the units the conditions are
judged against. A self-check of text just drafted has one unit and skips all of it.

## 1. Get the current file content, not just the diff

Time-closure cannot be judged from a comment in isolation — it is checked against what the code
looks like now. A diff hunk alone hides that: an added comment may describe code a *later* hunk in
the same PR changes again, and the context lines around a hunk are whatever the file looked like
around that change, not the head this condition has to be checked against.

- **With `--worktree <path>`** — read files from there, and get the diff by running `gh pr diff`
  with no arguments from inside that worktree. It detects the PR from the checked-out branch, so no
  separate `git diff` permission is needed.
- **Otherwise** — run `gh pr diff <pr>` for the diff, and fetch each file's content at the PR's head
  SHA with `gh api repos/<owner>/<repo>/contents/<path>?ref=<head-sha>`, base64-decoding the
  response.

## 2. Pick the candidates, in two passes

Restrict attention to **added or changed lines only** — a PR review has no business reviewing
comments nobody touched. This is a two-pass filter, not a single regex.

1. **Mechanical pass**: for each changed file, take the comment syntax its extension uses (`//`,
   `#`, `/* ... */`, docstrings, `<!-- -->`, and so on) and `Grep` every added or changed line that
   starts one. A contiguous run of such lines is one block.
2. **Judgment pass**: drop a candidate that is commented-out code rather than prose, or a change
   that is purely a reflow or typo fix with no semantic difference. Neither is a unit this skill
   judges.

Add the PR description itself as one more unit, fetched with `gh pr view --json body`. An issue body
being self-checked works the same way: one unit, no code attached.

## 3. Decide the code each unit is judged against

Default to the smallest enclosing statement, block or function the comment sits above or beside, and
widen or narrow that where the comment is clearly about a different span.

Then check the unit's content against the choice. A docstring can be true of the declaration it
physically sits on and still leave a *different* declaration undocumented — the one whose callers
are the ones who actually need the contract. That gap is a finding in its own right, before any
condition applies to what the docstring says.

## 4. Pull in the unchanged lines whose meaning changed

A changed line can shift what an *unchanged* neighbouring line means without changing that line's
own characters. A trailing sentence in the same paragraph that says "see the comment above for why"
still points at the same words, but if the sentence right before it just changed, what the reader is
being sent to read has changed too.

So pull the whole paragraph or comment block into the unit whenever an unchanged line is
grammatically continuous with a changed one — reads as one sentence or one train of thought — not
only the lines the diff marked. Judging the changed half alone would miss exactly the kind of
misdirected reference this skill exists to catch.

## Worked case: a changed line redirects an unchanged one

The conditions can be shown as plain code; this is inherently about a diff — what changed, and
what an unchanged neighbouring line now means because of it.

**Diff (`src/analytics/types.ts`)**

```diff
 /**
- * The resolved path. **Query string is not included** (`resolvePath` drops it).
+ * The resolved path and its query string. **Hash is not included.**
+ *
+ * The query is passed through `resolvePath` unchanged; only key order is stabilized.
  * See the comment in this file for why.
  */
 path: string;
```

**Extracted unit**: all four lines, as one paragraph. "See the comment in this file for why." carries
no `+`/`-` marker, so a diff-only pass would skip it — but it is grammatically the closing sentence
of the paragraph the changed lines open, and what it points at has changed along with them.

Condition 1 and 2 pass — the paragraph describes the current field, and "a comment in this file"
sounds reachable. Condition 3 fails, and worse than usual: sending the reader elsewhere for a fact
this doc could state directly is already a scope violation, and here the pointer is also wrong — the
actual reasoning lives in `src/analytics/resolvePath.ts`, a different file. A reader who follows the
pointer literally, as written, finds nothing there.

**Two facts** (condition 3's usual shape; the location error is part of what is wrong with (a), not
a separate fact):

(a) `types.ts`'s doc for `path` says the reasoning is "in this file," but it is in `resolvePath.ts` —
a reader following the pointer finds nothing. Fix the pointer to name the right file, or delete it
and state the reason (query kept, hash dropped) here directly.

(b) The contract for what `path` contains is not expressed at its own point of use. No fix is named;
this field's doc should be readable on its own, without opening another file at all — that is the gap
left open.

## Worked case: a docstring describing a different declaration than the one it sits on

This is not a condition-3 violation — nothing in the text below sends the reader anywhere. The
docstring is accurate, complete, and reachable exactly where it is. The mistake happened earlier, in
extraction: whoever wrote it meant to document `validateDiscountCode`, but the physical line it sits
on is a different declaration.

```typescript
/** Discount codes are 5-8 uppercase alphanumeric characters, optional campaign-tag prefix. */
const VALIDATE_CODE_REGEX = /^[A-Z0-9]{5,8}$/;

export function validateDiscountCode(code: string): boolean {
  return VALIDATE_CODE_REGEX.test(code);
}
```

**Extracted unit**: the docstring + `VALIDATE_CODE_REGEX`, by the default rule above (the declaration
it physically sits on). Judged on that unit alone, nothing violates any condition — the
text is true of `VALIDATE_CODE_REGEX`'s format, and it is local and reachable right where it is. The
finding comes from the content check, not from the conditions: `validateDiscountCode`
is the declaration whose callers need this contract (it is the exported function; the regex is just
how it is implemented), and it has no doc of its own — a reader of the function has to notice a
separately-named declaration above it and read that one instead.

**Finding**: `validateDiscountCode` has no doc of its own; its contract only shows up on
`VALIDATE_CODE_REGEX`, the declaration above it — move the docstring to `validateDiscountCode`.
