# 09 · A PRD and an interface that contradict

**Pattern.** Two paragraphs make the same claim, disagree, and neither says whether it is the
source or the reproduction of the other. The contradiction cannot be resolved, only argued.

## Bad

**Bad** `docs/prd-payment.md`

```md
## Failed payments

A payment that fails is retried up to three times. If every try fails, the user sees "Try again"
and the order stays open so they can.
```

**Bad** `src/payment.ts`

```ts
export type PaymentOutcome = "paid" | "contact-support";

export async function pay(orderId: string, amount: number): Promise<PaymentOutcome> {
  // ...
}
```

### Graph

| Node | Address | Source or derived |
|---|---|---|
| the product requirement | `docs/prd-payment.md › Failed payments` | says nothing |
| the interface | `src/payment.ts › PaymentOutcome` | says nothing |

| From | To | Edge |
|---|---|---|
| `src/payment.ts › PaymentOutcome` | `docs/prd-payment.md › Failed payments` | **absent in both directions**: no paragraph says which reproduces which |

### What is wrong

The PRD says "Try again"; the interface can only say "contact-support". One of them is wrong, and
the graph does not say which, because neither declared itself. If the PRD was written first, the
interface is a defective reproduction and the fix is in code. If the interface shipped first and
the PRD was written from it, the PRD is a stale explanation and the fix is in the document. Both
fixes are cheap; the argument about which one is not.

## Good

Either paragraph may be the source. Each pair below is one answer; the point is that one of them
is declared.

If the PRD is the source, the PRD is unchanged and the interface moves:

**Good** `src/payment.ts`

```ts
/** Reproduces "Failed payments" (docs/prd-payment.md). */
export type PaymentOutcome = "paid" | "try-again";
```

If the interface is the source, the interface is unchanged and the PRD moves:

**Good** `docs/prd-payment.md`

```md
## Failed payments

This describes what `pay` in `src/payment.ts` does today. A payment that fails is retried up to
three times; if every try fails, the user sees "Contact support".
```

### Why

Rule 5: a paragraph says whether it is the source or the derived side. Once the interface says it
reproduces the PRD, the contradiction is a defect with an owner, and search for the PRD's heading
finds the code that has to change. Once the PRD says it describes the code, it is the PRD that
changes.
