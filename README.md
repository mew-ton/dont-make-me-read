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
Rationalizations table for the excuses that arrive while writing, and two of the eight exist only
to be run against text you just wrote.

## One test

At every granularity — a word, a sentence, a section, a file:

> **Does this change what the reader does next?**

No: cut it. Yes, and it is missing: add it. Shorter and longer are both outcomes, never goals.
Restating a rule at its point of use costs a line and saves a round trip to another file; pointing
at `path:line` instead of quoting a diff back saves re-reading what the reader already has open.
Same call, opposite direction.

The same test at word level is why an internal field name, an invented label, and "as appropriate"
fail together: each leaves the reader something to resolve before they can act.

## Commands

Commands are the whole user-facing surface. Type one when you want something written or checked.

| Command | What it does |
|---|---|
| `/write-issue` | Draft or revise a GitHub issue body, then audit the result. |
| `/write-review-comment` | Draft or revise a PR review finding. |
| `/write-skill` | Write or review a `SKILL.md`. |
| `/review-issue` | Audit an existing issue body. |
| `/review-text` | Audit a PR's description and the code comments it changes. |

## Skills

No skill appears in the `/` menu. They load on the model's own judgment while it writes, and the
commands above call the ones they need. That is the point: these rules have to reach a code comment
written in the middle of some other task, where nobody was going to stop and invoke a writing skill
by hand.

| Skill | Role |
|---|---|
| [`dont-make-me-read`](skills/dont-make-me-read/SKILL.md) | The entry: the test above, what may never be cut for it, where the length cap applies, and which skill owns the artifact in hand. |
| [`write-nice-issue-description`](skills/write-nice-issue-description/SKILL.md) | Write a GitHub issue body an implementer can act on alone: a determinable problem, checkable acceptance criteria, an out-of-scope boundary. |
| [`write-nice-instructions`](skills/write-nice-instructions/SKILL.md) | Shape a PR review finding: one fixed template (title / summary / details), and how firmly to state the remedy. |
| [`avoid-unverifiable-context`](skills/avoid-unverifiable-context/SKILL.md) | Keep out of persisting text what its reader cannot go and check: the conversation, the review thread, a past state the code no longer shows. |
| [`avoid-reference-detours`](skills/avoid-reference-detours/SKILL.md) | Stop sending the reader somewhere reachable to understand the sentence in front of them. State it at the point of use; the original stays put. |
| [`write-nice-skills`](skills/write-nice-skills/SKILL.md) | Write and review a `SKILL.md`'s description and body so it fires reliably and stays lean. |
| [`review-nice-issues`](skills/review-nice-issues/SKILL.md) | Audit an issue body against the same conditions `write-nice-issue-description` writes to, from the text alone. |
| [`review-self-contained-docs`](skills/review-self-contained-docs/SKILL.md) | Audit a PR's description and every comment it changes for self-containment (time-closure, referenceability, reference-scope closure). |

They sit in three layers. **`dont-make-me-read` is the entry**: it carries the two propositions
and the test, and routes to whatever else applies. It holds no template and no budget, so reading
it is never a substitute for loading what it points at. **The two `avoid-*` skills** carry failure
modes that hold whatever the text is — a code comment, a JSDoc block, a PR description, a commit
message — which is why they have the broadest triggers here and why most writing needs nothing
beyond them. **A few artifacts have enough fixed shape to earn rules of their own**: an issue
body, a review finding, a `SKILL.md`, each with its own sections, budgets, and worked examples.

The two `review-*` skills are proposition 2 made operational: the authoring skill states the
conditions, the review skill applies them to text already written, per unit, instead of trusting a
read-through. They have no tools beyond reading, and `review-nice-issues` has none at all — it must
judge from the same text a reader holds, so its caller does any fetching.

The verb says which direction the skill subtracts in. A `write-*` skill fixes the shape of a whole
artifact — an issue, a finding, a `SKILL.md`. An `avoid-*` skill names one thing that puts reading
between the reader and acting, wherever the text lives. `avoid-unverifiable-context` and
`avoid-reference-detours` are the two halves of one question: the first is what the reader cannot
reach at all and the fix is to delete, the second is what they *can* reach and were made to travel
to, where the fix is to restate it here and leave the original where it is.

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
