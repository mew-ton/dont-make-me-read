---
name: avoid-reference-detours
description: >
  A reference the reader can genuinely open is still a defect when following it was never optional
  — a doc comment that says "the format rules at the top of this file", a note that says "same as
  the config", a section that defers to another section of the same document. Restate what this
  reader needs at the point they need it, and leave the original where it is: the round trip is
  what costs them, not the fact. Apply when writing a code comment, a docstring, a PR description,
  or any text that points elsewhere to be understood. DO NOT use when the target does not exist or
  cannot be reached at all (that is avoid-unverifiable-context), or for the same content repeated
  twice inside one document (that is write-nice-issue-description's Gate 2).
user-invocable: false           # entry points are commands/, never the / menu
disable-model-invocation: false
allowed-tools: []
---

## Scope

Reachability is not the whole test. A pointer can be completely valid — the file really does carry
that rule at the top, the config really does say that — and still be the wrong thing to write,
because the reader had to leave to understand the sentence in front of them.

Two questions, and only the second is this skill's:

| Question | Skill |
|---|---|
| Can the reader go and check what this refers to? | `avoid-unverifiable-context` |
| Should the reader have had to leave here to understand it at all? | this skill |

The first fails when the target does not exist for this reader — a conversation, a removed
declaration, a Slack thread. There is nothing to restate, so the fix is to delete. This skill only
applies once that question has been passed.

## The rule

State it where it is used. Keep the original where it is.

The original — the file-header docstring, the schema, the spec, the config — stays put and stays
authoritative. What comes to the point of use is not a copy of it but **the part this reader needs
in order to act**, in the shortest form that does the job. That is why this subtracts rather than
adds: the reader stops making the trip, and the two lines that would have described the trip go
with it.

## This is not a licence to add

Restating earns its line only when it removes a trip. Before adding, run the same test everything
else in this set runs:

> **Does this change what the reader does next?**

A line repeating what the code beside it already shows adds reading and removes no trip — it fails.
So does a background paragraph the reader would never have gone looking for. The two directions are
one rule, not two:

| Situation | What the reader pays | Write |
|---|---|---|
| The fact lives elsewhere and they must go get it | a round trip | the fact, here |
| The fact is already in front of them (the diff, the code on the next line) | a re-read | nothing; point at `path:line` if it needs naming at all |

`write-nice-instructions`' "the reader has it — point at `path:line` instead" is the second row.
Both rows subtract from what the reader gets through.

## Where this ends and duplication begins

Inside one document a reader reads in order, so a second statement of the same content is a
re-read — that is `write-nice-issue-description`'s Gate 2, and it forbids it. Across documents,
files, or sections a reader has to travel, and the trip costs more than the restatement. This skill
governs the second case only; a repeated paragraph two sections down is Gate 2's, not this skill's.

## Language

Write the restated line in the language the artifact's readers already use. This skill is about
where a fact sits, not which language states it.

## Common Rationalizations

| Rationalization | Reality |
|---|---|
| "It's reachable, so pointing to it is fine." | Reachability was never the problem; being sent there was. If the reader has to leave this comment or section to make sense of it, state it here. |
| "Restating it duplicates the source of truth." | The source of truth does not move — it stays where it is and stays authoritative. What comes here is the part this reader needs to act, not a second copy of the whole. |
| "More context at the point of use is always safer." | Only when it removes a trip. A line that repeats what the code beside it already shows adds reading and saves nothing. Run the test on every line you add, not only on the ones you cut. |
| "It reads fine to me." | You already know what is at the other end of the pointer, so the trip costs you nothing. The reader is the one paying for it. |

## Examples

### Bad: sending the reader to the top of the file
```typescript
/** Discount codes are 5-8 uppercase alphanumeric characters, optional campaign-tag prefix. */

export function validateDiscountCode(code: string): boolean {
  // Validation here follows the format rules described at the top of this file.
  return DISCOUNT_CODE_PATTERN.test(code);
}
```

The file-level docstring is real and it is in the same file, so nothing here is unreachable. It
still fails: a reader checking `validateDiscountCode` has to go open the header to find out what
the pattern accepts.

### Good: state it at the point of use
```typescript
export function validateDiscountCode(code: string): boolean {
  // Discount codes: 5-8 uppercase alphanumeric characters, optional campaign-tag prefix.
  return DISCOUNT_CODE_PATTERN.test(code);
}
```

The rule now sits where it is used, and it is shorter to read than the version with the pointer.
The file-level docstring is untouched.

### Bad: a cross-issue note in prose
```markdown
The retry path is being handled in another issue and is not implemented yet.
```

### Good: a note that names what to read, at the code it concerns
```typescript
// TODO(#456): retries for combined promo codes are not implemented yet.
```

A `TODO(#456)` states the boundary at the point the reader hits it, and needs no trip to be acted
on — the reader knows to stop here whether or not they open #456.

## Related skills

- `avoid-unverifiable-context` — the other half of the same split: the target does not exist for
  this reader at all, so the fix is to delete rather than restate.
- `write-nice-issue-description` — Gate 2 owns repetition *inside* one document.
- `review-self-contained-docs` — audits written text against both, per unit, from the reader's side.
