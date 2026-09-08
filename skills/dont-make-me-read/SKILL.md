---
name: dont-make-me-read
description: >
  Text someone else has to act on, whatever it is — a GitHub issue, a PR description, a review
  comment, an explanatory code comment, a JSDoc block, a design doc, a SKILL.md — is measured by
  whether its reader decides correctly from it, not by how thorough or careful it reads. Noise costs a wrong decision, not just time, and
  whatever the decision depends on has to be there however much it costs to read. Use before
  writing or revising any of those, to get that test and to reach the rules for the artifact in
  hand. DO NOT use it instead of those rules — it carries no template, no budget, and no section
  list — or for ephemeral chat replies, scratchpads, and working notes nobody acts on later.
user-invocable: false           # entry points are commands/, never the / menu
disable-model-invocation: false
allowed-tools: []
---

## Why this exists

Two propositions. Every rule in this plugin follows from them.

1. **Nobody wants to read a lot of text to work out what to do.** Not beautiful text, not
   thorough text, not polite text.
2. **The writer cannot tell how much that is.** You read your own draft while supplying the
   context it is missing, so it reads short to you, and only to you.

The second is why these are skills and not advice, and why two of them exist only to be run
against text you have already written.

## The test

At every granularity — a word, a sentence, a section, a file:

> **Does this change, or protect, the decision the reader is about to make?**

No: cut it. Yes, and it is missing: add it. Shorter and longer are both outcomes, never goals.

What noise costs is not reading time. It is a **wrong decision, made confidently**:

| Noise | What the reader concludes |
|---|---|
| A menu of fixes you could have weighted yourself | that the choice is theirs — to be made with less information than you had |
| The paths you happened to sample, given as the fix | that those files are the complete set to touch |
| "handle this appropriately" | that the spec is complete |
| The implementation method, in an issue | that the shape you saw while writing is still the shape today |

## What must never be cut

Whatever the decision depends on and the reader cannot reconstruct:

- the rationale behind a spec or design — the business requirement, the regulation, the domain
  constraint, the product decision
- the constraint that rules out the obvious wrong move, stated as the wall they would walk into
  rather than as an option offered to them
- the fact that makes the ask defensible at all

Cutting one of these does not make the text lean. It hands a decision to someone with less to
decide on, which is the failure this whole set exists to prevent. A line that is expensive to read
and that the decision needs, stays.

## Where the length cap applies

Only to the path a reader must take to find out what to do. Backing material is fetched by whoever
needs it and is not capped.

| | Capped | Because |
|---|---|---|
| The mandatory path | yes | everyone pays for it, every time |
| Backing material — worked examples, evidence, the original a pointer leads to | no | only the reader who needs it pays |

That is why a review finding's details are capped at 20 lines while its evidence in a code block
is not, and why a skill's `references/` has a depth rule and no size rule.

## Which skill owns what

Most of what this applies to has no template and needs none — an explanatory code comment, a
JSDoc block, a PR description, a design doc, a commit message. For those the test above, plus two
failure modes, is the whole of it:

- `avoid-unverifiable-context` — the text carries something the reader cannot go and check.
- `avoid-reference-detours` — the text sends the reader somewhere reachable in order to be
  understood.

Both hold whatever the artifact is, so they also apply on top of everything below.

A few artifacts have enough fixed shape to earn rules of their own. Load the one that matches;
this skill holds the test, not those rules.

| Writing | Skill |
|---|---|
| A GitHub issue body | `write-nice-issue-description` |
| A PR review finding, or any comment telling a person what to change | `write-nice-instructions` |
| A `SKILL.md` | `write-nice-skills` |

| Checking what is already written | Skill |
|---|---|
| An issue body | `review-nice-issues` |
| A PR's description and every comment its diff changes | `review-self-contained-docs` |

## Common Rationalizations

| Rationalization | Reality |
|---|---|
| "I have the principle now, so I can write the issue without loading that skill." | The principle does not carry the section list, the budgets, or the gates. It says what to aim at, never what the artifact must contain. Loading this is not a substitute for loading that one. |
| "Shorter is better, so cut it." | Shorter is a result, never the goal. A line the decision depends on stays however much it costs to read. |
| "More context is safer." | Context the decision does not use is exactly what makes a reader confident about the wrong thing. Safety is the second list above, not volume. |
| "It reads fine to me." | You are supplying the intent the text is missing as you read it. Judge it as someone holding only the text — that is the whole failure mode. |
