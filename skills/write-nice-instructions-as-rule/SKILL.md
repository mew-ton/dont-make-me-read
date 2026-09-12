---
name: write-nice-instructions-as-rule
description: >
  Writes and revises rules that stay in force — a guideline, a convention, a policy, a checklist, or
  the rules inside a skill body or a reference file — so each one reads as an instruction the reader
  can act on rather than an explanation they can agree with. Does not apply when the text is a
  one-off instruction to one reader about one change, or when the document states no rules.
user-invocable: false
disable-model-invocation: false
context: fork
background: false
allowed-tools: []
---

## Why this exists

A rule the reader can agree with without acting is not a rule. Explaining the constraint and
leaving the action to be inferred produces exactly that, and its author cannot feel it: they
already know which action they mean, so the explanation reads complete to them.

Standing rules are also read out of order. Nobody reads a guideline front to back before the edit
that needed it, so each entry has to work where the eye lands rather than where it was written.

## DO

- **State each rule as an imperative.** The reader acts on a verb, not on a description of the
  problem the verb solves.
- **Write the instruction first, then the constraint that narrows it** — "state the fact at the
  point of use", then "and leave the original where it is".
- **Split several instructions and several prohibitions into a DO list and a DON'T list.** The
  polarity then sits in the structure instead of in one word the reader can skim past, and how
  many of each there are is visible without parsing prose.
- **Keep a constraint or an exception on the line of the entry it narrows**, so the pair survives
  a reader who lands on that line and reads nothing above it.
- **Give the cost in the same entry, where it fits in a clause.** A rule whose cost is invisible
  is the first one dropped under pressure.

## DON'T

- **Explain the constraint and leave the action to be inferred from it.** That is the failure this
  skill exists for, and it reads as finished prose.
- **Restate an entry's own heading before qualifying it.** Two layers of one sentence is how a
  one-line rule becomes a paragraph.
- **Number entries that will be inserted into.** The number is an address that moves; the entry's
  own opening words are one that does not.
- **Put a rule's reason somewhere other than the rule.** A reason behind a pointer is read by
  nobody at the moment the rule is being broken.
- **Keep an entry nobody can fail.** A rule with no way to violate it is a description of the
  status quo, and it dilutes the ones that can be broken.

## Common Rationalizations

| Rationalization | Reality |
|---|---|
| "The reasoning has to come first or the rule looks arbitrary." | A reader who agrees with the reasoning still does not know what to type. Give the imperative, then the reason in the same entry. |
| "A DON'T list is negative, so I'll phrase everything as a DO." | Then every prohibition arrives as its inverse and the reader inverts it back — badly, since "do X" and "never Y" are different claims. A document carrying only one of them is missing half its rules. |
| "One paragraph keeps related rules together." | It keeps them indistinguishable. A reader landing mid-paragraph cannot tell how many rules are in front of them, and neither can the next editor. |
| "Numbering makes the rules citable." | Until one is inserted, and every citation points one rule off. The entry's own words are the citable part, and they stay right. |
| "It reads clearly to me." | You knew which action you meant before you read the sentence. That is the one thing the reader does not have. |

## Related skills

- `dont-make-me-read` — the test this one sharpens: what the reader has to hold before they can
  act on the rule.
- `write-nice-instructions-as-comment` — the same demand for one instruction to one person about one change,
  where the shape is a finding rather than a standing list.
