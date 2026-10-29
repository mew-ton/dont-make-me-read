# 04 · A report retold in other words

**Pattern.** Two speakers, two vocabularies. The derived document translates the source into its
own words and drops the original, so the two can no longer be matched, by a reader or by search.

## Bad

**Bad** `docs/qa-report-142.md`

```md
## Steps

Add any item, go to checkout, pay with the test card ending 0002.

## Observed

The screen freezes for about ten seconds after pressing Pay, then shows "contact support".

## Expected

Either a quick failure with "try again", or a successful payment.
```

**Bad** `https://github.com/example/orderly/issues/231`

```md
QA found that paying with a declining card locks the page for several seconds and then shows the
wrong message.
```

### Graph

| Node | Address | Source or derived |
|---|---|---|
| the observation | `docs/qa-report-142.md › Observed` | source |
| the task | `https://github.com/example/orderly/issues/231` | derived from the observation |

| From | To | Edge |
|---|---|---|
| `https://github.com/example/orderly/issues/231` | `docs/qa-report-142.md › Observed` | **missing**: not named; the content is translated instead |

### What is wrong

"Declining card" is not what QA said; QA named a test card. "Several seconds" is not "about ten
seconds". "The wrong message" is not "contact support". Each is a small drift, and together they
describe a different bug. A search for QA's words finds nothing in the issue, and an edit to the
report never reaches it.

## Good

**Good** `https://github.com/example/orderly/issues/231`

```md
QA report 142 (`docs/qa-report-142.md`), paying with "the test card ending 0002": "The screen
freezes for about ten seconds after pressing Pay, then shows 'contact support'." In our terms:
"contact support" is the text for the `"contact-support"` outcome of `pay` (`src/checkout.ts`).
```

### Why

Rule 4 and the *Citing* section of `references/prose.md`: name the owner, quote the words the reader
needs, then translate beside the quote if the reader's vocabulary differs. The translation maps
words and adds no cause; a cause nobody has established is case 05. The report is unchanged.
