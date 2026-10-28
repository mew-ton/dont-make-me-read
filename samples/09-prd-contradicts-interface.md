# 09 · A PRD and an interface that contradict

**Pattern.** A requirement and the interface that reproduces it disagree. Code is derived from
requirements, so the interface is the one that is wrong. What makes that hard to act on is that
nothing in either paragraph says which reproduces which, so the defect gets argued instead of fixed.

## Bad

**Bad** `docs/prd-payment.md`

```md
## Failed payments

A payment that fails is tried up to three times. If every try fails, the user sees "Try again"
and the order stays open so they can.
```

**Bad** `src/checkout.ts`

```ts
export type PaymentOutcome = "paid" | "contact-support";

export async function pay(orderId: string, amount: number): Promise<PaymentOutcome> {
  // ...
}
```

### Graph

| Node | Address | Source or derived |
|---|---|---|
| the product requirement | `docs/prd-payment.md › Failed payments` | source |
| the interface | `src/checkout.ts › PaymentOutcome` | derived: it reproduces the requirement, and does not say so |

| From | To | Edge |
|---|---|---|
| `src/checkout.ts › PaymentOutcome` | `docs/prd-payment.md › Failed payments` | **missing**: the reproduction does not cite its source |
| the two paragraphs | each other | **contradiction**: "Try again" against `"contact-support"` |

### What is wrong

The PRD says the user sees "Try again"; the interface cannot produce it. Since the code reproduces
the requirement, the interface is the defect. But the interface does not say it reproduces anything,
so a reader of `PaymentOutcome` has no reason to open the PRD, and a reader of the PRD has to
search to learn that the code disagrees. Until someone does, both stand, and whichever a new reader
finds first is the one they believe.

If the PRD was in fact written after the code to describe it, it is not a requirement, and the fix
is one sentence in the PRD saying so; see rule 5. That is the exception, and it has to be stated to
exist.

## Good

**Good** `src/checkout.ts`

```ts
/** Reproduces "Failed payments" (docs/prd-payment.md). */
export type PaymentOutcome = "paid" | "try-again";

export async function pay(orderId: string, amount: number): Promise<PaymentOutcome> {
  // ...
}
```

### Why

Rule 5: a paragraph depends on what it reproduces and says so. The interface now names its source,
in the source's words, and agrees with it. The PRD is unchanged. The next disagreement between them
is a defect in one known place, and a search for the PRD's heading finds it.
