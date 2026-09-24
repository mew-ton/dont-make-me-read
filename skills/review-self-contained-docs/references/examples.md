# Worked examples

A Bad/Good pair for each condition — condition 1 gets a second Bad, for a unit that fails on one
clause — and a best case with no comment at all. Read this when judging a
unit and you want to check your reasoning against a known-good case.

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

No unit is even extracted here — extraction only pulls lines that start a comment, and there is
none. That absence is not a gap to fill; it is the best outcome this skill judges toward. An inline
comment restating what `return n % 2 === 0` already says (`// return true if n is even`) would
pass every condition and still be worse than nothing: the reader pays to read it and learns
nothing they didn't already see in the code. Judging whether an *existing* comment is
self-contained is this skill's job; whether an inline comment like that should exist at all is a
separate question, and this skill does not answer it. A declaration-level doc comment on an
exported function is a separate question again — some restatement can be warranted there, since
callers read it on hover instead of opening the source. No finding either way.
