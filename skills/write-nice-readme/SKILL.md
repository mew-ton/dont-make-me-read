---
name: write-nice-readme
description: >
  Use this skill when writing or revising a README, and when adding a section to one that already
  exists. DO NOT use this skill when the artifact is an architecture doc, a SKILL.md, an issue
  body, reference documentation, a tutorial, or a changelog.
user-invocable: false
disable-model-invocation: false
context: fork
background: false
allowed-tools: []
---

## Scope

A README is read by someone who has agreed to nothing. They have not installed it, do not know
whether it solves their problem, and will leave the moment the file stops answering that. Every
other document in a repository is read by someone who has already decided; this one is read while
deciding.

That reader is not the only one, but they are the one who sets the order: a maintainer looking up
a flag can scroll, and a stranger deciding whether to keep reading cannot.

An architecture doc is the standing answer to "how do I decide this here"
(`write-nice-architecture-docs`). A README is the standing answer to **"is this mine, and what do
I do first"**. Reference docs, tutorials and changelogs all answer a question that comes after.

## The test

`dont-make-me-read`'s test, at this artifact's granularity:

> **Can a reader who has not decided to use this settle that, and take the first step, without
> reading further?**

"Without reading further" is the whole condition. Anything that has to be held before the decision
is paid for by everyone who arrives, including everyone who leaves.

## What a README owes its reader

Four things, in this order. Each earns its place by settling something; a section that settles
nothing goes, whatever convention put it there.

| | What it settles |
|---|---|
| **What this is** | whether the reader's problem is the one this solves — stated as the problem, not as the category |
| **The way in** | the commands that take them from nothing to the first working thing |
| **The surface** | what they type, call, or import — the set they choose from |
| **Where the rest lives** | that the other documents exist, by name, so nobody looks for them here |

What the project deliberately does not do belongs with the first: a boundary read before adoption
saves the reader the whole trip, and read after it reads as an apology.

## What this adds

Five conditions on how those are written. Name them when reviewing, so a finding says which failed.

### 1. The decision comes before the explanation

The reader's first decision is adopt or leave. Every line above the point where they can make it is
paid for by people who will not stay. Philosophy, history, badges, a table of contents, the
reasoning that convinced you — each of these is a section somebody read before finding out whether
they cared.

This is an ordering rule, not a length rule: the material can stay, further down, where it is read
by someone who has already decided they want it.

### 2. Describe the shape by its rule, never by walking the inventory

A paragraph per kind grows with the kinds. Every new kind adds one, every renamed kind edits one,
and none of them is where the reader's attention was.

State the rule that puts a thing in a kind, once, and the reader classifies the next one
themselves — including the one added after this file was last touched.

**A count is the same failure in miniature.** "The three helpers", "eight modules", "two of them
carry the weight": each is wrong the next time somebody adds one, and each reads as authority while
carrying none. Say what the kinds are and what puts a thing in each. The reader can count, and
their count will be current.

### 3. Only what the reader chooses between is a list

A list is a choice offered. If the reader picks one item and acts, the list is doing work: the
commands they can type, the entry points they can import, the platforms they can install on.

Anything that exists but that they will never pick from — internal components, every file in the
tree, everything the project contains — is not a choice, so listing it buys the reader nothing and
costs a maintenance edit per item. The directory already holds that list, and holds it correctly.

Where a list is genuinely a choice, write each entry as *the condition under which the reader picks
it*, not as a summary of what it is. The summary already exists wherever that thing is defined; the
condition is what this reader came for and what nothing else states.

### 4. Nothing here is the second copy of what another file owns

A README describes things it does not own, which is exactly how it goes stale in silence: the owner
is edited, the README is not, and nobody notices because nothing breaks.

The direction test: **if the owner is reworded, does this file become wrong?** If yes, you copied
what it owns. Name the thing and say what it is for — a name survives every rewording that matters,
and survives the rename too, because search finds it.

That includes the project's own principles. If a document, a skill or a spec is where a rule lives,
the README says what the reader gets, in the README's own words. Restating the rule verbatim makes
this file a mirror that has to be updated whenever the original is sharpened.

### 5. The way in is executable, and it is the real one

A reader who has decided to try it has one question left, and it is not answered by prose. Give
them the commands to paste, in the order they run, and check them against what actually works
today: an install path that is aspirational, or that was true before the project changed, wastes
exactly the reader who had already said yes.

If the easy path does not exist yet, give the one that does. A clumsy path that works beats an
elegant one that does not.

## Language

Write it in the language its readers already use. A project whose users read one language has no
reason to be read in another, and a project whose users are mixed has to choose rather than ship
both — the same content in two languages is duplication, with two files to keep in step and no
reader who needs both. The conditions above are about what the file settles, not which language
settles it.

## Common Rationalizations

| Rationalization | Reality |
|---|---|
| "The reader needs the philosophy to understand why this matters." | The reader needs to know whether it is theirs. Someone who has decided to stay will read the philosophy; someone deciding pays for it and leaves anyway. Put it after the decision, not before it. |
| "Listing everything the project contains shows how much is here." | It shows a list that is wrong within a month, and it is not a choice the reader makes. Volume is not a value proposition, and the directory listing is both current and free. |
| "A sentence explaining each kind makes the design legible." | The rule that generates the kinds does that in one sentence and stays right when a kind is added. A gloss per kind is the same content, sized to grow. |
| "The count makes it concrete." | It makes it wrong on the next commit. Nobody's decision turned on whether it was eight or nine. |
| "Copying the principle from the doc that owns it saves the reader a trip." | Restating it at the point of use is right; copying its wording is what makes this file downstream. Say what the reader gets in your own words, and name the file that owns the rule. |
| "The naming convention explains how the pieces fit together, so it belongs up front." | It is a design decision, owned wherever design decisions get settled, and it changes nothing the reader does next. Sharpen it there and this file silently becomes wrong — the arrow pointing in that nobody notices until a reader has already trusted it. |
| "The README is where people look, so everything should be reachable from it." | Reachable, yes — by name. Reproduced, no. An index of the repository is a second copy of the repository, and only one of them is kept up to date. |
| "I'll write the install steps once the packaging is sorted." | Then today's reader, who was ready to try it, has nothing to run. Ship the path that works now and replace it when the better one exists. |
| "It reads fine to me." | You knew what the project was before you opened the file. That is the one thing your reader does not have, and the only thing this file exists to give them. |

## Related skills

- `dont-make-me-read` — the test this one sharpens, and why the writer cannot feel the range they
  are asking for.
- `write-nice-architecture-docs` — the file a contributor decides *by*; this one is the file a
  stranger decides *from*. Condition 4's direction test is that skill's staleness rule, pointed at
  a file that cannot avoid describing what it does not own.
- `avoid-reference-detours` — what may be restated at the point of use, which condition 4 narrows
  to: the part the reader needs, in your words, never the owner's definition.
- `find-document-dependencies` — draws the arrows, so condition 4 can be run rather than eyeballed.
