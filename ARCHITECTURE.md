# Architecture

## Bird's eye view

Anything someone reads in order to act — an issue, a review comment, a PR description, a doc, a
`SKILL.md`, the code itself — costs its reader whatever they have to gather before they can act. The
writer cannot feel that cost: they read their own draft while supplying what it leaves out. This
plugin is the rule that corrects for it, placed where the writing happens so nobody has to remember
to apply it.

One skill. Its `SKILL.md` holds the test every such piece of writing is held to and the ways it
fails, and is resident while anything of the kind is being written. One supplement hangs off it:
what the test works out to for each kind of artifact, written down once so it is not re-derived
every time. The supplement is a derivation, not a second set of rules — every line in it can be
traced back to the test, and a line that cannot is not allowed in.

Commands are what a person types. One settles what is not yet settled, hands one brief to the
skill, and shows what comes back. They are the whole typed surface and carry no rules of their own.

The plugin's own tree is held to the same standard as the writing it governs: nothing in it may
depend on a maintainer remembering to keep two places in agreement.

## Codemap

```
.claude-plugin/plugin.json                    the manifest
skills/dont-make-me-read/SKILL.md             the test, the failure modes, the one link below
skills/dont-make-me-read/references/artifacts.md   what the test works out to, per kind of artifact
commands/<name>.md                            one per thing a person types
scripts/check.sh                              every check a commit has to pass; runs with no model call
ARCHITECTURE.md                               what a contributor decides by
README.md                                     what a person decides from before installing
```

Nothing else: no second skill, no per-skill README, provenance, glossary or verification file, and
no translation of any of it. The reason each of those is absent is an invariant below.

## The golden rule

**A rule that has to be remembered will be broken. Build the machinery that makes it a property,
and put that machinery where the writing already happens.**

That rule was already here. What this revision adds is that it applies to this repository too. A
fact stated in two files has to be remembered to stay in agreement, and a quality the tree is meant
to have but nothing checks is a quality it will lose. So: one owner per fact, and a script for
whatever can be checked. What cannot be checked is not an invariant; it is a preference, and it
does not go in this file.

## Invariants

### One skill

The rule for writing to be acted on is one rule, so it is one skill. What an issue needs that a
review comment does not is not a second rule; it is the first rule applied to an issue. Giving each
kind of artifact a skill of its own gave each one a copy of the derivation, cut off from what it was
derived from, and every change to the thought had to be carried into every copy by hand. The
previous tree had ten such copies and rebuilt each at least once.

### The supplement is a derivation, and says so line by line

`references/artifacts.md` holds one section per kind of artifact. Each line in a section states
what the test works out to for that artifact and names the step of the test it follows from. A line
that cannot name one is a preference, and preferences go in a command's brief or nowhere.

This is what keeps the supplement from becoming the second set of rules it replaces. It is reached
from one line of the `SKILL.md`, under one condition: the kind of artifact is known. The `SKILL.md`
itself holds no list of kinds.

### One owner per fact

Every rule, figure, term and name is stated in exactly one file. A file that needs it links to it by
path and does not restate it. The test lives in the `SKILL.md`; the supplement applies it and does
not repeat it; a command names what it hands over and nothing about how it is to be written.

### The tree is checked, not reviewed, for consistency

`scripts/check.sh` fails when any of these holds:

- a relative link's target does not exist
- a file under `references/` is not linked from the `SKILL.md`
- the frontmatter `name` differs from the skill's directory
- a file is over its size limit

A consistency the script cannot test is not promised anywhere. The check runs on every commit and
costs nothing, so there is no reason it is ever skipped.

### One language in the tree

English, because a published plugin cannot know the language its users prompt in. What the skill
tells a writer to *produce* is a separate question with the same answer each time: the language the
artifact's readers already use, and only one.

A translation is made when someone needs one and is never committed. Two copies of a text cannot be
kept consistent by a rule, only by a check, and no check can read both and say they agree. The
mirror this replaces was half the tree and a twin commit for every change.

### Sizes are byte limits, with headroom, checked locally

| File | Limit |
|---|---|
| `SKILL.md` | 4 KB |
| `references/artifacts.md` | 12 KB |
| a command | 2 KB |

Bytes, because the check has to run on every commit with nothing to authenticate against; the
bytes-per-token ratio is stable enough that a byte figure stands in for the cost that matters. The
figures are chosen with room under them: a file at the ceiling has nowhere to go when the next case
arrives, and the previous standing skill measured within three tokens of its limit. A limit is a
failing figure, not a target.

When the supplement outgrows its limit, it splits by kind of artifact into files under
`references/`, each still reached from the `SKILL.md` under the condition that names its kind, and
each still a derivation line by line. Nothing else about the shape changes.

### Why a rule exists is not in the tree

Why a line of the supplement was derived the way it was, where it came from, and what it replaced
are not material the agent needs. They go in the commit and pull request that introduced the line,
where the history keeps them and nothing has to be kept in step with them.

### Only what the plugin controls is an invariant

What Claude Code does with a skill's frontmatter, with a loaded skill on the next turn, or with a
forked context is not this plugin's to promise. Each such behaviour the design relies on is listed
under *What this design assumes of Claude Code* with how it was checked. A design that leans on one
unchecked is one that can stop working without any file changing.

### Production never sees the conversation that reached it

When a command produces an artifact, the skill runs without the conversation. That keeps out both
what a reader could not check — "as discussed", the review that happened in chat — and the
session's pull on the standard: run inside the conversation that has been arguing about the
artifact and the test bends toward what was just said. A command settles everything unsettled
before the hand-off, and what crosses is one brief.

### The skill judges its own axis

Whether an artifact can be acted on from its text is the skill's question. Whether it is true of the
repository, complete, or in scope is the caller's, and the skill never holds a tool that would let it
answer those — a verdict about what a reader can see is sound only while the judge saw no more.

## What this design assumes of Claude Code

| Assumption | How it is checked | Last checked |
|---|---|---|
| A skill with `disable-model-invocation: false` is loaded on the model's judgment, from its description alone | run the triggering case with the plugin installed and without | not yet |
| A command body is sent as the prompt, with `$ARGUMENTS` substituted | run a command and read the transcript | not yet |
| `context: fork` runs the skill without the conversation that invoked it | fork the skill and have it report what it can see | not yet |
| `allowed-tools` pre-approves; `disallowed-tools` removes | invoke the skill with one of each and attempt both | not yet |

A row that fails on re-check is a design change, not a documentation fix.

## Out of scope

- No general-purpose "review this" entry point.
- No toolchain, package manager or install path assumed.
- No second-language keyword list in a description.
- No rule about how a reader's language is chosen beyond the one above.

## Decisions this draft leaves open

To be settled before this section is deleted.

1. **Which kinds of artifact the supplement covers first.** The previous commands show which were
   reached for most: the issue and the review comment. Each section is a derivation, so the first
   two also test whether the derivation rule can be kept.
2. **Whether commands exist at all.** With one skill that loads on its own, a command adds only the
   hand-off: settling, the brief, and running production outside the conversation. If that
   isolation turns out not to need a command, the typed surface is empty.
3. **The byte limits.** Chosen with headroom; nothing yet measured against them.

---

Shape from matklad's `ARCHITECTURE.md` (Alex Kladov, 2021).
