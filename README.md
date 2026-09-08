# dont-make-me-read

A [Claude Code](https://claude.com/claude-code) plugin: skills for writing text someone else has to
act on — a GitHub issue, a PR review finding, a persistent doc, a `SKILL.md` — so they can act on it
without wading through it.

## Two propositions

Every rule in every skill here follows from these.

1. **Nobody wants to read a lot of text to work out what to do.** Not beautiful text, not thorough
   text, not polite text. What is measured is how much a reader gets through before they can act.
2. **The writer cannot tell how much that is.** You read your own draft while supplying the context
   it is missing, so it reads short to you, and only to you.

The second is why this is a set of skills and not advice. Each skill carries a Common
Rationalizations table for the excuses that arrive while writing, and two of the six exist only to
be run against text you just wrote.

## One test

At every granularity — a word, a sentence, a section, a file:

> **Does this change what the reader does next?**

No: cut it. Yes, and it is missing: add it. Shorter and longer are both outcomes, never goals.
Restating a rule at its point of use costs a line and saves a round trip to another file; pointing
at `path:line` instead of quoting a diff back saves re-reading what the reader already has open.
Same call, opposite direction.

The same test at word level is why an internal field name, an invented label, and "as appropriate"
fail together: each leaves the reader something to resolve before they can act.

## Skills

| Skill | Role |
|---|---|
| [`write-nice-issue-description`](skills/write-nice-issue-description/SKILL.md) | Write a GitHub issue body an implementer can act on alone: a determinable problem, checkable acceptance criteria, an out-of-scope boundary. |
| [`write-nice-instructions`](skills/write-nice-instructions/SKILL.md) | Shape a PR review finding: one fixed template (title / summary / details), and how firmly to state the remedy. |
| [`write-self-contained-docs`](skills/write-self-contained-docs/SKILL.md) | Write any persisting text — issues, PR descriptions, code comments, design docs — assuming the reader shares none of your context. |
| [`write-nice-skills`](skills/write-nice-skills/SKILL.md) | Write and review a `SKILL.md`'s description and body so it fires reliably and stays lean. |
| [`review-nice-issues`](skills/review-nice-issues/SKILL.md) | Audit an issue body against the same conditions `write-nice-issue-description` writes to. Also usable directly to self-check an issue draft. |
| [`review-self-contained-docs`](skills/review-self-contained-docs/SKILL.md) | Audit a PR's description and comments for self-containment (time-closure, referenceability, reference-scope closure). Also usable directly to self-check text you just wrote. |

The four `write-*` skills are direct entry points — invoke them to write something. The two
`review-*` skills are primarily invoked by a caller as one axis of a larger review, but can also be
invoked directly by name to self-check a draft before it ships. That pairing is proposition 2 made
operational: the writing skill states the conditions, the review skill applies them to you.

`write-nice-skills` is the odd one out only in its reader — a `SKILL.md` is read by an agent
deciding whether to load it, on the same terms a person decides whether to keep reading.

## Language

The skills are written in English, and so are their triggers and worked examples — a published
skill cannot know which language its users prompt in. What they tell you to *write* is a separate
question: each writing skill says to produce the issue, the finding, or the doc in the language its
readers already use, and to write it in one language only. The rules fix the text's shape and the
context it carries, not the language it carries them in.

## License

MIT — see [LICENSE](LICENSE).
