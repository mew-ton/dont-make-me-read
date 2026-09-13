---
name: write-nice-architecture-docs
description: >
  Writes and revises an architecture doc — ARCHITECTURE.md, an ADR, a decision record — including
  when a decision just made by reading the code is one the next contributor will have to make again.
  Does not apply when the artifact is a GitHub issue body, a SKILL.md, a changelog, a tour of the
  code, or a record of who decided what when.
user-invocable: false
disable-model-invocation: false
context: fork
background: false
---

## Overview

An architecture doc is the standing answer to "how do I decide this here", read long after whoever
wrote it has stopped being available. This extends **matklad's `ARCHITECTURE.md`** (Alex Kladov,
2021) — his shape is settled, and the sections below are his — with the reader who is not
navigating but *adding*: each section is written so it also **places a case the doc has never
seen**.

## The test

`dont-make-me-read`'s test, at this artifact's granularity:

> **Could a reader settle their decision from this, with the implementation closed?**

The code already shows what is there and git already shows when it changed. What neither shows is
what would settle the next decision — which is why a section that narrates the current shape has no
reader: everything in it is available faster somewhere else.

The same test from the maintenance side: **nothing may oblige a fix in this file.** Write a
dependency as an arrow — A → B means fixing A obliges fixing B — and every arrow this file is on
has to leave it: it moves and the tree follows, never the reverse. It does not matter what the
arrow comes from, the code or another document; an arrow pointing in has put this file downstream
of what it governs, where it goes stale in silence and every contributor who trusted it was
misplaced before anyone noticed.

## The shape, from matklad

In this order.

| Section | What goes in it |
|---|---|
| **Bird's eye view** | The problem the project solves, before any structure. A few lines. |
| **Codemap** | The coarse-grained modules and how they relate — "a map of a country, not an atlas of maps of its states". It answers *where is the thing that does X* and *what does the thing I am looking at do*. |
| **Cross-cutting concerns and invariants** | What holds across modules, and the boundaries between layers and systems. Its own section, not scattered through the other two. |

Standing rules come with them, the first three matklad's:

- **Keep it short, and specify only what is unlikely to change.** Every recurring contributor reads
  it. Do not try to keep it synchronised with the code; revisit it a couple of times a year.
- **Name important files, modules and types; do not link into them.** Links go stale, and a stale
  link is worse than a name the reader can search for. Naming an entity and letting symbol search
  find it survives every rename that matters.
- **A criterion carries a reason only where the reason places a case the criterion alone does
  not.** Stating the rule and then explaining it is how these files get long, and length is itself
  the failure: the reader came for one decision and pays for the argument that convinced you.
  Compress until every remaining sentence would change somebody's next move.
- **Name roles, not instances.** An architectural role — the entry point, the thing that holds the
  standard — is stable and worth naming. The component that currently fills it is not: name it and
  every rename in the tree points an arrow back into this file.
- **Never defer the substance to another document.** "The rest is in `README.md`" hands the reader
  a trip in place of the thing they came for, and it is the failure `avoid-reference-detours`
  exists to stop — so a doc that commits it has broken the rule its own project is built on. Naming
  another file so the reader knows it exists is fine; making them go there to finish the sentence
  in front of them is not. Keeping it short means writing less, never relocating what a contributor
  needs.

Writing the codemap is also the cheapest chance you get to notice that the physical structure of
the code and its logical architecture have come apart.

## What this adds

Conditions on *how* those sections are written. Name them when reviewing, so a finding says which
one failed.

### Every section settles a decision somebody faces

Start from the decisions, not from the parts. "Which layer does this belong in", "does this fork",
"where does this entry point live" are decisions. "What the layers are" is a description, and
earns a section when a decision needs it.

The codemap is the section where this is easiest to lose: a list of directories with a sentence
each is a description, and becomes a codemap the moment each entry says what belongs there — which
is what lets a reader place a new file rather than only find an old one.

**A count is the purest form of the failure.** "Nine modules do X and six do Y" settles nothing, is
wrong the next time somebody adds one, and reads as authority while carrying none. Say what the
kinds are and what puts a thing in each; the reader can count for themselves, and their count will
be right.

### Lead the invariants with the rule that generates them

The top of that section is the **golden rule**: the thinking every other decision in the project
follows from. Without it a reader has a list of constraints to obey; with it they can derive the
one nobody wrote down. It is the highest-leverage sentence in the file, and it is the one matklad's
"call out your invariants" leaves implicit — an invariant is worth far more when the reader can see
what it is an instance of.

Then the invariants themselves. matklad is right that **invariants are often expressed as absence**,
and that stating them is the highest-value part of the file — an absence is exactly what no amount
of reading the code reveals. That is not the same as a doc built out of Don'ts, and the difference
is testable:

> **Does it place a case the doc has never seen?**

- "No layer imports from the one above it" is an absence and a criterion: it settles where anything
  new goes, including the module nobody has written yet.
- "The parser does not call the type checker" is an absence and *not* a criterion: it is one fact
  about two modules that exist, and it settles nothing about a third.

The second becomes the first by being raised to the rule it was an instance of.

**A convention is not an invariant, and writing it down as one manufactures a constraint nobody
imposed.** Before stating a rule, ask what happens to someone who breaks it. If the answer is
"nothing — everyone just does it this way, because the examples did", it is a habit. Say so, or say
nothing: a doc that promotes the habit to a rule has spent the reader's trust to make a choice they
were free to make, and every later contributor pays a decision they did not owe. The requirement
underneath is usually a sentence away and worth stating instead — what the platform actually
enforces, or what this project would break without.

**Where an absence cannot be raised, the level it may take is a list — never a section.** A flat
*out of scope* list is worth its lines: it tells a contributor what the project deliberately does
not do, the absence they would otherwise spend a day rediscovering. Turning the same content into
chapters is what fails, because a chapter is where a criterion should have been and a reader
reading the table of contents now sees a project defined by what it refuses.

So: no single refusal gets a section of its own. One heading over a flat list is the level they are
allowed, and the headings that remain go to the golden rule and the invariants. Counting negated
headings is the cheap check.

### A classification covers everything it claims to classify

When the doc partitions what exists — layers, kinds, categories — every existing thing lands in
exactly one bucket, and a reader can place a new thing by the same partition.

A table that names three of eight teaches the reader that the partition is unreliable, and they
stop using it to decide. Either widen it until it is total, or narrow what it claims: a table of
*three examples* is honest and useful; a table presented as *the layers* is not, unless it holds
them all.

### Restate what the decision needs; never re-derive a definition another file owns

Exit codes belong to the script that returns them. Frontmatter fields belong to the platform that
parses them. The list of what exists belongs to the directory that holds it. And how an artifact is
arranged internally belongs to that artifact's own rules — a doc that says which artifacts have
rules has already said enough.

`avoid-reference-detours` already settles whether you may repeat something: bring the part **this
reader needs in order to act**, in the shortest form that does the job. What this narrows is
*which* part:

| | Bring |
|---|---|
| The reader must decide something now | the part that settles it — "non-zero means do not commit it yet" |
| Another file defines the thing | the entity's name, not the enumeration — the script's own header lists which code means what |

The direction test, narrowed to a definition: **if the other file changes, does this doc become
wrong?** If yes, you copied a definition. If no, you restated an input. This is matklad's staleness
rule one step in: a definition you copied goes stale exactly the way a link does.

## Organising the file

Inside the three sections, index by decision rather than by component. A contributor arrives with
one question, and headings are what they scan to find it.

The file sits on the mandatory path for anyone changing the repository, so what is capped is **the
distance to the decision they came for** — which is what "keep it short" is protecting. A file
whose headings are decisions stays cheap as it grows; one that must be read end to end does not.

## Language

Write it in the language its contributors already use — the repository's.

## Common Rationalizations

| Rationalization | Reality |
|---|---|
| "Everything here is laid out this way, so that is the convention and I will write it down." | Ask what breaks when someone does it differently. If the honest answer is "nothing", you are about to turn a habit into a rule, and the next contributor will spend real thought obeying something you invented while transcribing. State the requirement underneath it, or leave the choice where it was. |
| "The README already covers that, so I will point at it." | Then the reader arrives here, gets sent away, and comes back having paid for a trip. Short is achieved by writing less, not by relocating what the contributor came for. Bring the part the decision needs; name the other file only so they know it exists. |
| "Explaining what we currently do *is* the architecture." | The code shows what you currently do, faster and without drifting. What it cannot show is the invariant and what would settle the next decision — that is the only thing this file adds. |
| "A section per thing we refuse is honest about our boundaries." | A table of contents made of refusals tells a reader what the project will not do and nothing about what it will. Give the refusals a flat out-of-scope list, which is cheap and genuinely useful, and keep the headings for the rule that generates them. |
| "The prohibition is the real content; the criterion is obvious." | It is obvious to you, because you already hold the criterion you derived it from. The reader gets one closed path and an unmapped space. Raise it to the rule it was an instance of, and check that the rule places a case you have not seen. |
| "matklad says to call out what is deliberately absent, so a list of absences is the doc." | He says an invariant is often an absence, not that an absence is always an invariant. "No layer imports upward" places everything; "the parser does not call the type checker" places nothing. Keep both, but only the first can carry a section. |
| "The table only lists the interesting cases." | Then say so in the table's own words. Presented as the classification, a partial table teaches the reader it cannot be trusted to place anything — including the thing they came to place. |
| "Linking the module is friendlier than naming it." | Until it moves. A name survives the rename and search finds it; the link becomes a lie nobody notices for a year. Name it. |
| "Recording why we chose this over the alternative is useful history." | The rationale stays; the deliberation goes (`avoid-unverifiable-context`). Write the constraint that rules the alternative out, as a wall the reader would hit — not the account of the two of you weighing it. |
| "It reads fine to me." | You are supplying the criteria you already hold. Judge it as someone who has the file open and the implementation closed — that is the whole failure mode. |

## Red Flags

- A section that narrates the current shape, which the code shows faster.
- An invariant that places no case the doc has never seen.
- A definition re-derived from the file that owns it.
- A classification with a case that falls outside every class it claims to cover.

## Verification

- [ ] Every section settles a decision somebody faces, with the implementation closed.
- [ ] Each invariant leads with the rule that generates it.
- [ ] Nothing here becomes wrong when a file it describes is reworded.

## Related skills

- `dont-make-me-read` — the test this one sharpens, and the rule that a constraint is stated as the
  wall the reader would walk into.
- `avoid-unverifiable-context` — what keeps deliberation out while the rationale stays.
- `avoid-reference-detours` — what to restate at the point of use, which the last condition above
  narrows for the definitions another file owns.
- `find-document-dependencies` — draws the arrows, so the test above can be run rather than
  eyeballed. Every arrow it finds pointing into this file is a finding here.
- `write-nice-skills` — a `SKILL.md` is an instruction to an agent, not an architecture doc; this
  skill stops where that one starts.
