# dont-make-me-read

A [Claude Code](https://claude.com/claude-code) plugin: skills for writing what someone else has to
read before they can act — a GitHub issue, a PR review finding, a persistent doc, a `SKILL.md`, a
comment, the code itself — so they can act on it without wading through it.

## Two propositions

Every rule in every skill here follows from these.

1. **Nobody wants to hold a lot in their head to work out what to do.** Not for beautiful text,
   not for thorough text, not for polite text. What is measured is the range a reader has to hold
   to understand what is in front of them — and the reader is a person or an agent, since both pay
   to collect it and both act on what they end up holding.
2. **The writer cannot tell how much that is.** You read your own draft while supplying the context
   it is missing, so the range reads small to you, and only to you.

The second is why this is a set of skills and not advice. Each skill carries a Common
Rationalizations table for the excuses that arrive while writing, and some of them exist only to
be run against text already written.

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
| [`dont-make-me-read`](skills/dont-make-me-read/SKILL.md) | The standing layer: the range a reader has to hold, the three ways it goes wrong, the test above, and what may never be cut for it. |
| [`write-nice-issue-description`](skills/write-nice-issue-description/SKILL.md) | Write a GitHub issue body an implementer can act on alone: a determinable problem, checkable acceptance criteria, an out-of-scope boundary. |
| [`write-nice-instructions`](skills/write-nice-instructions/SKILL.md) | Shape a PR review finding: one fixed template (title / summary / details), and how firmly to state the remedy. |
| [`avoid-unverifiable-context`](skills/avoid-unverifiable-context/SKILL.md) | Keep out of persisting text what its reader cannot go and check: the conversation, the review thread, a past state the code no longer shows. |
| [`avoid-reference-detours`](skills/avoid-reference-detours/SKILL.md) | Stop sending the reader somewhere reachable to understand the sentence in front of them. State it at the point of use; the original stays put. |
| [`avoid-caller-knowledge`](skills/avoid-caller-knowledge/SKILL.md) | Keep a module from knowing which caller invoked it. The same range failure in code, where restating is what creates the dependency — so the knowledge comes out instead. |
| [`write-nice-skills`](skills/write-nice-skills/SKILL.md) | Write and review a `SKILL.md`'s description and body so it fires reliably and stays lean. |
| [`write-nice-architecture-docs`](skills/write-nice-architecture-docs/SKILL.md) | Carry the criteria a contributor decides by, so they can decide with the implementation closed. |
| [`review-nice-issues`](skills/review-nice-issues/SKILL.md) | Audit an issue body against the same conditions `write-nice-issue-description` writes to, from the text alone. |
| [`review-self-contained-docs`](skills/review-self-contained-docs/SKILL.md) | Audit a PR's description and every comment it changes for self-containment (time-closure, referenceability, reference-scope closure). |
| [`find-document-dependencies`](skills/find-document-dependencies/SKILL.md) | Surface what a document would have to be rewritten for, as a graph of what is pinned to what and which end has to move — weak where the pin is a location, strong where it is content — and leave the verdict to its caller. |

Two of them carry the weight. **`dont-make-me-read` is the standing layer**: the two propositions,
the range, and the test. It names no artifact and points at no skill, which is what holds it to a
fixed size however many activities exist — and it holds no template and no budget, so having it in
force is never a substitute for loading the rules for the artifact in hand. **A `write-*` skill
holds the best practice for one activity** — its sections, its budgets, the conditions it has to
satisfy.

The rest serve that second job rather than standing beside it. An **`avoid-*`** skill names one
failure mode that holds whatever the work is — a code comment, a JSDoc block, a PR description, a
commit message, a module's interface — so it applies underneath every artifact, which is why these
carry the broadest triggers here and why most writing needs nothing more. A **`review-*`** skill runs the same
conditions backwards over text already written, per unit, which is proposition 2 made operational:
the authoring skill states them, and a writer cannot judge their own draft. None of them holds a
tool that would let it confirm what its reader could not; where standing on that same footing is
the whole product, the skill holds no tools at all and its caller does any fetching.

A **`find-*`** skill returns material rather than a verdict, so a pass that does judge has
something to judge from — because a finding is only worth what its grounds are worth.

The verb tells you which of those you are looking at, and the direction it subtracts in. The three
`avoid-*` skills split one question — how far past the artifact does the reader's range reach.
`avoid-unverifiable-context` is what they cannot reach at all, and the fix is to delete.
`avoid-reference-detours` is what they *can* reach and were made to travel to, where the fix is to
restate it here and leave the original where it is. `avoid-caller-knowledge` is that second case in
code, where restating is what creates the dependency, so the knowledge comes out instead.

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
