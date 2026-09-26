# Restating at the point of use

Read this when what you are writing sends its reader somewhere else to be understood — a comment,
a docstring, a PR description, a section that defers to another section — and the target is one
they can reach. `SKILL.md` carries the test; this holds the rules for that case and the Bad/Good
pairs.

A reference the reader can genuinely open is still a defect when following it was never optional:
the round trip is what costs them, not the fact.

## When it applies

To any sentence that cannot be understood without going somewhere else. It does not apply when:

- The target does not exist for this reader at all — a conversation, a removed declaration, a Slack
  thread. There is nothing to restate and the fix is to delete, so settle whether the reader can
  reach the target before asking whether they should have been sent to it.
- The same content is stated twice inside one document. A reader reads a document in order, so the
  second statement costs them a re-read rather than a trip, and only a trip is this file's.

## The rules

- **State the fact at the point of use, and leave the original where it is.** The file-header
  docstring, the schema, the spec, the config stays put and stays authoritative, which is why this
  subtracts rather than adds: the reader stops making the trip, and the two lines that would have
  described the trip go with it.
- **Bring the part this reader needs in order to act, in the shortest form that does the job.** The
  whole original copied to the point of use adds reading in place of the trip it removed.
- **Restate only where it removes a trip.** Of each line you add, ask: **does this change what the
  reader does next?** A line repeating what the code beside it already shows, or a background
  paragraph the reader would never have gone looking for, adds reading and removes no trip — point
  at `path:line` if the location needs naming at all.
- **Write the restated line in the language the artifact's readers already use.** A line they
  have to translate before they can act is the trip again, moved.

## Common Rationalizations

| Rationalization | Reality |
|---|---|
| "Restating it duplicates the source of truth." | The source of truth does not move — it stays where it is and stays authoritative. What comes here is the part this reader needs to act, not a second copy of the whole. |
| "More context at the point of use is always safer." | Only when it removes a trip. A line that repeats what the code beside it already shows adds reading and saves nothing. Run the test on every line you add, not only on the ones you cut. |

## Red Flags

- A restatement that adds a line and removes no trip, because the code beside it already showed it.
- The whole original copied to the point of use, instead of the part this reader needs.

## Verification

- [ ] Every remaining pointer is one the reader may decline to follow and still act.
- [ ] The original is still in place and still authoritative.

## Worked examples

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

### Good: state it on the signature
```typescript
/**
 * @param discountCode 5-8 uppercase alphanumeric characters, optional campaign-tag prefix.
 */
export function validateDiscountCode(discountCode: string): boolean {
  return DISCOUNT_CODE_PATTERN.test(discountCode);
}
```

The rule now reaches the caller, who sees it on hover without opening the function at all — a
comment inside the body would still have made them come here to read it.

### Good: put it on the type, when more than one function takes it
```typescript
/** 5-8 uppercase alphanumeric characters, optional campaign-tag prefix. */
type DiscountCode = string;

export function validateDiscountCode(code: DiscountCode): boolean {
  return DISCOUNT_CODE_PATTERN.test(code);
}
```

Stated once, and it arrives at every place the type is used. The file-level docstring is untouched
in both.

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
