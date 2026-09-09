# dont-make-me-read

A [Claude Code](https://claude.com/claude-code) plugin: skills for writing text someone else has to
act on — a GitHub issue, a PR review finding, a persistent doc, a `SKILL.md` — so they can act on it
without wading through it.

## Two propositions

Every rule in every skill here follows from these.

1. **Nobody wants to read a lot of text to work out what to do.** Not beautiful text, not thorough
   text, not polite text. What is measured is how much a reader gets through before they can act —
   and the reader is a person or an agent, since both pay to collect it and both act on what they
   end up holding.
2. **The writer cannot tell how much that is.** You read your own draft while supplying the context
   it is missing, so it reads short to you, and only to you.

The second is why this is a set of skills and not advice. Each skill carries a Common
Rationalizations table for the excuses that arrive while writing, and two of the nine exist only
to be run against text already written.

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
| `/write-architecture` | Write or revise an architecture doc. |
| `/review-issue` | Audit an existing issue body. |
| `/review-text` | Audit a PR's description and the code comments it changes. |

A writing command is the instruction layer, not an alias for a skill. It does the messy part —
fetching an existing issue, asking about what is not yet settled, working out what the finding even
is — and hands one consolidated brief to the skill that owns the artifact. That skill runs with
none of this conversation (`context: fork`), so nothing that produced the brief can surface in what
it writes: `avoid-unverifiable-context`'s rule, enforced by structure instead of by asking the
writer to remember it.

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
| [`write-nice-architecture-docs`](skills/write-nice-architecture-docs/SKILL.md) | Carry the criteria a contributor decides by, so they can decide with the implementation closed. |
| [`review-nice-issues`](skills/review-nice-issues/SKILL.md) | Audit an issue body against the same conditions `write-nice-issue-description` writes to, from the text alone. |
| [`review-self-contained-docs`](skills/review-self-contained-docs/SKILL.md) | Audit a PR's description and every comment it changes for self-containment (time-closure, referenceability, reference-scope closure). |
| [`find-document-dependencies`](skills/find-document-dependencies/SKILL.md) | Surface what a document would have to be rewritten for, weak (a pointer a tool already finds) or strong (a name or explanation in prose, which only reading finds), and leave the verdict to its caller. |

Two of them carry the weight. **`dont-make-me-read` is the entry**: it carries the two propositions
and the test, and routes to whatever else applies. It holds no template and no budget, so reading
it is never a substitute for loading what it points at. **A `write-*` skill holds the best practice
for one artifact** — its sections, its budgets, the conditions it has to satisfy — for the artifacts
whose shape is fixed enough to have one.

The rest serve that second job rather than standing beside it. An **`avoid-*`** skill names one
failure mode that holds whatever the text is — a code comment, a JSDoc block, a PR description, a
commit message — so it applies underneath every artifact, which is why these carry the broadest
triggers here and why most writing needs nothing more. A **`review-*`** skill runs the same
conditions backwards over text already written, per unit, which is proposition 2 made operational:
the authoring skill states them, and a writer cannot judge their own draft. They have no tools
beyond reading, and `review-nice-issues` has none at all — it must judge from the same text a reader
holds, so its caller does any fetching.

A **`find-*`** skill returns material rather than a verdict, so a pass that does judge has
something to judge from — because a finding is only worth what its grounds are worth.

The verb tells you which of those you are looking at, and the direction it subtracts in.
`avoid-unverifiable-context` and `avoid-reference-detours` are the two halves of one question: the
first is what the reader cannot reach at all and the fix is to delete, the second is what they *can*
reach and were made to travel to, where the fix is to restate it here and leave the original where
it is.

Which reader sets the bar differs by artifact — `write-nice-instructions` is pitched at the person
who decides within a few lines whether to act or skim, `write-nice-skills` at the agent deciding
whether to load a file — but every artifact here is read by both, and the two reach different wrong
conclusions from the same noise.

## Language

The skills are written in English, and so are their triggers and worked examples — a published
skill cannot know which language its users prompt in. What they tell you to *write* is a separate
question: each writing skill says to produce the issue, the finding, or the doc in the language its
readers already use, and to write it in one language only. The rules fix the text's shape and the
context it carries, not the language it carries them in.

## Architecture

What settles a decision about this plugin's own shape — where a new entry point goes, what context
a skill runs in, what tools it gets — is in [`ARCHITECTURE.md`](ARCHITECTURE.md), along with the
frontmatter contract that follows from it.

## License

MIT — see [LICENSE](LICENSE).
