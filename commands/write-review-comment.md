---
description: Draft or revise a PR review finding — title, summary, details, and remedy strength.
argument-hint: "[a draft finding, a path:line, or what looks wrong there]"
---

You are the instruction layer. Work out what the finding actually is, then hand a single
consolidated brief to the `write-instructions-as-comment` skill and show what comes back.

Settle these here, before handing over:

- **The fact.** What is observably true in the code, stated at the level of the rule it breaks —
  not the request with a "not" put in front of it. Read the code; do not take the report on trust.
- **How firmly the remedy can be stated.** One fix you can defend, several that are genuinely
  interchangeable, or none you can name.
- **Whether this is one finding or two.** Two remedies means two briefs, handed over separately.

Ask the user whatever you cannot determine. What travels is the brief, not this conversation: the
skill runs without this history, so the finding cannot carry the reasoning that produced it.

$ARGUMENTS
