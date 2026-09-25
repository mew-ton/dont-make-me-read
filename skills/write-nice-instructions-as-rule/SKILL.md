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
---

## Overview

This skill writes and revises the rules a document keeps in force — a guideline, a convention, a
policy, a checklist, the entries in a skill body — so that each one states an action its reader can
carry out. A rule the reader can agree with without acting is not a rule, and its author is the one
person who cannot feel the difference: they already know which action they mean.

## How to work

- **Ask of each entry what the reader does next, and answer it from that entry's own words alone.**
- **Read each entry on its own, in the order the eye reaches it rather than the order you wrote
  them in.**

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
- **Close an instruction with the road not taken.** "Use `$ARGUMENTS`, not the indexed form",
  "call the API, don't shell out" — the instruction was finished at the comma, and the clause
  after it hands the reader a second thing to hold plus an option to weigh that you had already
  discarded. Where a reader really would reach for the other thing, it is its own DON'T entry,
  with its own cost.
- **Deny an assumption the reader had no reason to hold.** "The name is not what hides it", "no
  API key is needed", "these are not requirements" — each reads only to someone who already made
  that mistake, and tells everyone else what to start worrying about. State the positive
  instruction. A denial belongs where the belief it denies is on the page beside it: the left
  column of a Common Rationalizations row, or the Bad half of a pair.
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

## Red Flags

- A rule entry whose opening words are a noun phrase about the problem rather than a verb for the
  reader.
- A `never` or a `don't` inside an entry on the DO list.
- Numbers in front of entries in a list that will be added to.
- An entry whose closing clause names the option you discarded, or corrects a belief the document
  never gave the reader.
- An entry you cannot say what breaking would look like for.

## Verification

- [ ] A reader who lands on one entry, having read nothing above it, can act on it.
- [ ] Every entry can be broken, and says in its own words what breaking it costs.
