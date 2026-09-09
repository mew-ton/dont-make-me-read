# Worked examples

Read this when you want the contrast for a case you are looking at: a doc comment that defers
to a file header, or a cross-issue note in prose. `SKILL.md` carries the rule; this holds the
Bad/Good pairs.

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
