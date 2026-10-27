# Architecture

## Bird's eye view

Anything someone reads in order to act — an issue, a review comment, a PR description, a doc, a
`SKILL.md`, the code itself — costs its reader whatever they have to gather before they can act. The
writer cannot feel that cost: they read their own draft while supplying what it leaves out. This
plugin is the rules that correct for it, placed where the writing happens so nobody has to remember
to apply them.

Three kinds of thing, and nothing else:

- **The standing skill** holds the one test every piece of such writing is held to, and the ways it
  fails. It is resident while anything of the kind is being written, so it is held to the smallest
  size of all.
- **An artifact skill** holds what one kind of artifact needs that the test alone cannot supply — a
  section list, a template, a budget. One exists only for an artifact that has already been written
  badly with the standing skill alone.
- **A command** is what a person types. It settles what is not yet settled, hands one brief to the
  artifact skill, and shows what comes back.

The plugin's own tree is held to the same rule as the writing it governs: nothing in it may depend
on a maintainer remembering to keep two places in agreement.

## Codemap

```
.claude-plugin/plugin.json      the manifest
skills/<name>/SKILL.md          the only file an agent loads for that skill
skills/<name>/references/*.md   read on one branch, from one line in that SKILL.md
commands/<name>.md              one per thing a person types
scripts/check.sh                every check a commit has to pass; runs with no model call
ARCHITECTURE.md                 what a contributor decides by
README.md                       what a person decides from before installing
```

Nothing else: no per-skill README, provenance, glossary or verification file, and no translation of
any of it. The reason each of those is absent is an invariant below.

## The golden rule

**A rule that has to be remembered will be broken. Build the machinery that makes it a property,
and put that machinery where the writing already happens.**

That rule was already here. What this revision adds is that it applies to this repository too. A
fact stated in two files has to be remembered to stay in agreement, and a quality the tree is meant
to have but nothing checks is a quality it will lose. So: one owner per fact, and a script for
whatever can be checked. What cannot be checked is not an invariant; it is a preference, and it
does not go in this file.

## Invariants

### One owner per fact

Every rule, figure, term and name is stated in exactly one file. A file that needs it links to it by
path and does not restate it. This is what removes the per-skill provenance and neighbourhood files:
each one restated what another file owned, and each restatement was a place that could disagree.

### The tree is checked, not reviewed, for consistency

`scripts/check.sh` fails when any of these holds:

- a relative link's target does not exist
- a file under `references/` is not linked from its skill's `SKILL.md`
- a skill's directory name appears in any file outside that directory, other than a command
- a `SKILL.md`'s frontmatter `name` differs from its directory
- a file is over its size limit

A consistency the script cannot test is not promised anywhere. The check runs on every commit and
costs nothing, so there is no reason it is ever skipped.

### One language in the tree

English, because a published plugin cannot know the language its users prompt in. What the skills
tell a writer to *produce* is a separate question with the same answer each time: the language the
artifact's readers already use, and only one.

A translation is made when someone needs one and is never committed. Two copies of a text cannot be
kept consistent by a rule, only by a check, and no check can read both and say they agree. The
mirror this replaces was half the tree and a twin commit for every change.

### Sizes are byte limits, with headroom, checked locally

| File | Limit |
|---|---|
| the standing `SKILL.md` | 4 KB |
| any other `SKILL.md` | 10 KB |
| any file under `references/` | 12 KB |

Bytes, because the check has to run on every commit with nothing to authenticate against; the
bytes-per-token ratio is stable enough that a byte figure stands in for the cost that matters. The
figures are chosen with room under them: a file at the ceiling has nowhere to go when the next case
arrives, and the previous standing skill measured within three tokens of its limit. A limit is a
failing figure, not a target.

### A skill is one file until a branch proves otherwise

A skill is its `SKILL.md`. It gains a file under `references/` only for material that one branch of
its work needs and the others never load, and that file is reached from one line of the `SKILL.md`
that names the branch. A checklist, if the skill ends in one, is the last section of the `SKILL.md`.

Why a rule exists, where it came from, and what it sits next to are not material the agent running
the skill needs. They go in the commit and pull request that introduced the rule, where the history
keeps them and nothing has to be kept in step with them.

### An artifact earns a skill by a failure, not by existing

An artifact skill is added when the standing skill alone produced a bad artifact of that kind, and
the pull request adding the skill shows that artifact and what the skill would have changed. One
per kind of artifact; none in advance.

The rule this replaces granted a skill to every activity someone could name. It produced ten, each
rebuilt at least once, before any had been shown to be needed.

### The plugin does not govern its own files with a skill it ships

The rules this tree's files follow are this document and `scripts/check.sh`. They are not also a
shipped skill, because a skill that governs every file in the tree turns each change to it into a
change to all of them: that cascade accounted for a fifth of the previous history. Whether a
general skill for writing a `SKILL.md` belongs in this plugin at all is a decision left open below.

### Only what the plugin controls is an invariant

What Claude Code does with a skill's frontmatter, with a loaded skill on the next turn, or with a
forked context is not this plugin's to promise. Each such behaviour the design relies on is listed
under *What this design assumes of Claude Code* with how it was checked. A design that leans on one
unchecked is one that can stop working without any file changing.

### The standing skill holds no inventory

No table of artifacts and the skills that own them. It would be a second place to update, and it
grows with what it lists in the one file that has to stay small. An artifact skill is reached by its
own description or not at all.

### A skill that produces an artifact never sees the conversation that reached it

That keeps out both what a reader could not check — "as discussed", the review that happened in
chat — and the session's pull on the standard: run inside the conversation that has been arguing
about the artifact and the rules bend toward what was just said. A command settles everything
unsettled before the hand-off, and what crosses is one brief.

### A skill judges its own axis

Whether an artifact can be acted on from its text is the skill's question. Whether it is true of the
repository, complete, or in scope is the caller's, and a skill never holds a tool that would let it
answer those — a verdict about what a reader can see is sound only while the judge saw no more.

## What this design assumes of Claude Code

| Assumption | How it is checked | Last checked |
|---|---|---|
| A skill with `disable-model-invocation: false` is loaded on the model's judgment, from its description alone | run the triggering case with the plugin installed and without | not yet |
| A command body is sent as the prompt, with `$ARGUMENTS` substituted | run a command and read the transcript | not yet |
| `context: fork` runs the skill without the conversation that invoked it | fork a skill that reports what it can see | not yet |
| `allowed-tools` pre-approves; `disallowed-tools` removes | invoke a skill that lists one of each and attempt both | not yet |

A row that fails on re-check is a design change, not a documentation fix.

## Out of scope

- No general-purpose "review this" entry point.
- No toolchain, package manager or install path assumed.
- No second-language keyword list in a description.
- No rule about how a reader's language is chosen beyond the one above.

## Decisions this draft leaves open

To be settled before this section is deleted.

1. **The first artifact skills.** The rule above says none in advance. The previous tree's commands
   show which artifacts were reached for most: the issue and the review comment. Whether either
   starts with a skill, or both wait for a failure, is the first case of the rule.
2. **A skill for writing skills.** It is the one artifact the plugin's own maintainers write
   constantly, and the one whose rules cascaded. Options: leave it out; ship it and exempt this
   tree from it; ship it and accept the cascade.
3. **The review commands.** The previous tree had two that audited an existing text. Under *earns a
   skill by a failure* they have no skill to call yet.
4. **The byte limits.** Chosen with headroom; nothing yet measured against them.

---

Shape from matklad's `ARCHITECTURE.md` (Alex Kladov, 2021).
