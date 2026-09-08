# Worked examples

Bad/Good pairs for each condition, a best case with no comment at all, and two extraction edge
cases that need a diff to show. Read this when judging a unit and you want to check your
reasoning against a known-good case.

## Condition 1: time-closure

### Bad: Narrating a completed migration
```typescript
export function fetchOrder(id: string): Promise<Order> {
  // Used to call the legacy v1 billing API, but we migrated to v2 last quarter.
  return billingApiV2.get(`/orders/${id}`);
}
```
Describes a past state (calling v1); the code shows only v2, with nothing the comment's claim
corresponds to. There is nothing here for a reader to verify — it is narrating history the code
no longer contains.

**Finding**: `fetchOrder`'s doc describes a migration that has already completed, with nothing in
the current code for the reader to check it against — delete the comment; the code it describes
(calling the v1 API) is gone.

### Bad: A historical clause hiding inside an otherwise-valid comment
```typescript
type RoleLevelFilter = {
  // Role level, string id. Was declared `number`, but the runtime value was always a string
  // wearing a `number` type — the option ids it's matched against are strings and nothing
  // coerces them. Corrected here so the value's type matches what it actually holds.
  roleLevel: string;
};
```
Most of this comment is present-tense and checkable — `roleLevel` is `string`, and the code
confirms it. But "Was declared `number`, but the runtime value was always a string wearing a
`number` type" narrates a declaration that no longer exists anywhere in this code; there is
nothing left here for a reader to verify it against — the same failure as the migration example
above. A unit does not earn a pass because most of its clauses check out: every clause gets
judged, and one that fails is enough to fail the whole unit.

**Finding**: `roleLevel`'s doc narrates a previous `number` declaration that no longer exists in
the code, with nothing left to verify it against — delete the historical clause ("Was declared
`number`..."); keep the present-tense reasoning only if it independently passes the other two
conditions.

### Good: Stating a present constraint, past tense and all
```typescript
export function fetchOrder(id: string): Promise<Order> {
  // Calls the endpoint synchronously because the legacy billing API does not
  // support batching yet.
  return billingApi.get(`/orders/${id}`);
}
```
Past-referencing ("does not support... yet") but the claim — a synchronous call, driven by a
constraint in the API being called — is checkable against the code, and the code confirms it: a
plain synchronous `.get()`. The time the comment describes is now. No finding.

## Condition 2: referenceability

### Bad: A reference so vague the reader can't tell what to open
```typescript
export function applyDiscount(price: number, codes: string[]): number {
  /** Discount stacking rules are documented in the pricing team's Notion (issue: 1234) */
  return codes.reduce((p, c) => stackingEngine.apply(p, c), price);
}
```
"Notion (issue: 1234)" doesn't even say what system `1234` belongs to — a Notion page ID? A GitHub
issue? A Jira ticket? This fails before reachability is even the question: the reader cannot tell
what artifact they would need access to, let alone go get it.

**Finding**: `applyDiscount`'s doc references "Notion (issue: 1234)" without saying what system or
artifact that is — delete the comment.

### Good: A TODO that names what to read and where
```typescript
export function applyDiscount(price: number, codes: string[]): number {
  // TODO(#456): stacking rules for combined promo codes are not yet defined.
  return codes.reduce((p, c) => stackingEngine.apply(p, c), price);
}
```
A short `TODO(#456)` names exactly what to go read and where — the one exception this condition
allows. No finding.

## Condition 3: reference-scope closure

### Bad: Sending the reader to the top of the file
```typescript
/** Discount codes are 5-8 uppercase alphanumeric characters, optional campaign-tag prefix. */

export function validateDiscountCode(code: string): boolean {
  // Validation here follows the format rules described at the top of this file.
  return DISCOUNT_CODE_PATTERN.test(code);
}
```
The file-level docstring is real and reachable — it's in the same file — so this passes
referenceability. It still fails reference-scope closure: a reader checking
`validateDiscountCode` has to go open the file's header comment to find out what the pattern is
supposed to accept. Reachable was never the problem; being sent there was.

**Two facts**, kept separate (a defensible fix and an unsolved gap are different kinds of claims):

(a) `validateDiscountCode`'s doc sends the reader to the file's top docstring instead of stating
the rule here — delete the comment.

(b) The discount code format (5-8 uppercase alphanumeric, optional campaign prefix) is not
expressed at its point of use — a reader of `validateDiscountCode` alone cannot tell what
`DISCOUNT_CODE_PATTERN` actually accepts. No fix is named here, only that one is needed: either
restate the format next to the regex, or replace the regex with named pieces that make the rule
self-evident (e.g. a documented constant per component of the pattern).

### Good: Stating the rule at its point of use
```typescript
export function validateDiscountCode(code: string): boolean {
  // Discount codes: 5-8 uppercase alphanumeric characters, optional campaign-tag prefix.
  return DISCOUNT_CODE_PATTERN.test(code);
}
```
The rule now sits where it's used. A reader no longer has to leave this function to know what the
pattern is supposed to accept. No finding.

## Best: no comment, because none is needed

```typescript
export function isEven(n: number): boolean {
  return n % 2 === 0;
}
```

No unit is even extracted here — step 2 only pulls lines that start a comment, and there is none.
That absence is not a gap to fill; it is the best outcome this skill judges toward. An inline
comment restating what `return n % 2 === 0` already says (`// return true if n is even`) would
pass all three conditions and still be worse than nothing: the reader pays to read it and learns
nothing they didn't already see in the code. Judging whether an *existing* comment is
self-contained is this skill's job; whether an inline comment like that should exist at all is a
separate question, and this skill does not answer it. A declaration-level doc comment on an
exported function is a separate question again — some restatement can be warranted there, since
callers read it on hover instead of opening the source. No finding either way.

## Extraction edge case 1: a changed line redirects an unchanged one

The three conditions above can be shown as plain code, but this one is inherently about a diff —
what changed, and what an unchanged neighboring line now means because of it.

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

**Extracted unit**: all four lines, as one paragraph. "See the comment in this file for why."
carries no `+`/`-` marker, so a diff-only pass would skip it — but it is grammatically the closing
sentence of the paragraph the changed lines open, and what it points at has changed along with
them.

Condition 1 and 2 pass — the paragraph describes the current field, and "a comment in this file"
sounds reachable. Condition 3 fails, and worse than usual: sending the reader elsewhere for a fact
this doc could state directly is already a scope violation, and here the pointer is also wrong —
the actual reasoning lives in `src/analytics/resolvePath.ts`, a different file. A reader who
follows the pointer literally, as written, finds nothing there.

**Two facts** (condition 3's usual shape; the location error is part of what's wrong with (a), not
a separate fact):

(a) `types.ts`'s doc for `path` says the reasoning is "in this file," but it is in
`resolvePath.ts` — a reader following the pointer finds nothing. Fix the pointer to name the
right file, or delete it and state the reason (query kept, hash dropped) here directly.

(b) The contract for what `path` contains is not expressed at its own point of use. No fix is
named; this field's doc should be readable on its own, without opening another file at all —
that is the gap left open.

## Extraction edge case 2: a docstring describes a different declaration than the one it sits on

This is not a condition-3 violation — nothing in the text below sends the reader anywhere. The
docstring is accurate, complete, and reachable exactly where it is. The mistake happened earlier,
in step 2: whoever wrote it meant to document `validateDiscountCode`, but the physical line it
sits on is a different declaration.

```typescript
/** Discount codes are 5-8 uppercase alphanumeric characters, optional campaign-tag prefix. */
const VALIDATE_CODE_REGEX = /^[A-Z0-9]{5,8}$/;

export function validateDiscountCode(code: string): boolean {
  return VALIDATE_CODE_REGEX.test(code);
}
```

**Extracted unit**: the docstring + `VALIDATE_CODE_REGEX`, by step 2's default rule (the
declaration it physically sits on). Judged on that unit alone, nothing here violates any of the
three conditions — the text is true of `VALIDATE_CODE_REGEX`'s format, and it's local and
reachable right where it is. The finding comes from step 2's content check, not from the three
conditions: `validateDiscountCode` is the declaration whose callers need this contract (it's the
exported function; the regex is just how it's implemented), and it has no doc of its own — a
reader of the function has to notice a separately-named declaration above it and read that one
instead.

**Finding**: `validateDiscountCode` has no doc of its own; its contract only shows up on
`VALIDATE_CODE_REGEX`, the declaration above it — move the docstring to `validateDiscountCode`.
