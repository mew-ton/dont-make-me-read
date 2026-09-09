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
