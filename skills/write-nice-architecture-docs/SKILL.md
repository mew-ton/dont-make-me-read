---
name: write-nice-architecture-docs
description: >
  An architecture doc — ARCHITECTURE.md, an ADR, a decision record — gives a contributor the
  bird's eye view, the codemap, and the invariants, written so they can also place something the
  doc has never seen. Apply when writing or revising one, and when a decision you just made by
  reading the code is one the next contributor will have to make again. DO NOT use for a GitHub
  issue body (that is write-nice-issue-description), for a SKILL.md (that is write-nice-skills),
  or for a changelog, a tour of the code, or a record of who decided what when.
user-invocable: false
disable-model-invocation: false
context: fork
background: false
allowed-tools: []
---

## Scope

This extends **matklad's `ARCHITECTURE.md`** (Alex Kladov, 2021), which proposes the file and the
shape it takes. Follow it: that part is settled, and the sections below are his.

What it leaves open is the reader who is not navigating but *adding*. His codemap answers "where's
the thing that does X?"; it does not answer "what shape should the thing I am about to write
take?", and a contributor who cannot answer the second induces it from whatever is already in the
tree. The extension here is that each of his sections is written so it also **places a case the doc
has never seen**.

An issue is a problem plus a completion condition (`write-nice-issue-description`). A `SKILL.md` is
an instruction to an agent (`write-nice-skills`). An architecture doc is neither: it is the
standing answer to "how do I decide this here", read long after whoever wrote it has stopped being
available.

## The test

`dont-make-me-read`'s test, at this artifact's granularity:

> **Could a reader settle their decision from this, with the implementation closed?**

The code already shows what is there and git already shows when it changed. What neither shows is
what would settle the next decision — which is why a section that narrates the current shape has no
reader: everything in it is available faster somewhere else.

## The shape, from matklad

Three sections, in this order.

| Section | What goes in it |
|---|---|
| **Bird's eye view** | The problem the project solves, before any structure. A few lines. |
| **Codemap** | The coarse-grained modules and how they relate — "a map of a country, not an atlas of maps of its states". It answers *where is the thing that does X* and *what does the thing I am looking at do*. |
| **Cross-cutting concerns and invariants** | What holds across modules, and the boundaries between layers and systems. Its own section, not scattered through the other two. |

Two standing rules come with them, and both are about what the file costs a year from now:

- **Keep it short, and specify only what is unlikely to change.** Every recurring contributor reads
  it. Do not try to keep it synchronised with the code; revisit it a couple of times a year.
- **Name important files, modules and types; do not link into them.** Links go stale, and a stale
  link is worse than a name the reader can search for. Naming an entity and letting symbol search
  find it survives every rename that matters.

Writing the codemap is also the cheapest chance you get to notice that the physical structure of
the code and its logical architecture have come apart.

## What this adds

Four conditions on *how* those three sections are written. Name them when reviewing, so a finding
says which one failed.

### 1. Every section settles a decision somebody faces

Start from the decisions, not from the parts. "Which layer does this belong in", "does this fork",
"where does this entry point live" are decisions. "What the layers are" is a description, and
earns a section when a decision needs it.

The codemap is the section where this is easiest to lose: a list of directories with a sentence
each is a description, and becomes a codemap the moment each entry says what belongs there — which
is what lets a reader place a new file rather than only find an old one.

### 2. An invariant is a criterion; a list of prohibitions is not

matklad is right that **invariants are often expressed as absence**, and that stating them is the
highest-value part of the file — an absence is exactly what no amount of reading the code reveals.
That is not the same as a doc built out of Don'ts, and the difference is testable:

> **Does it place a case the doc has never seen?**

- "No layer imports from the one above it" is an absence and a criterion: it settles where anything
  new goes, including the module nobody has written yet.
- "The parser does not call the type checker" is an absence and *not* a criterion: it is one fact
  about two modules that exist, and it settles nothing about a third.

The second becomes the first by being raised to the rule it was an instance of. Where you cannot
raise it — the absence really is about those two — keep it in the invariants section, where a
reader looking for constraints will find it, rather than as a heading. **A heading that names a
prohibition announces a section of Don'ts**; the same section titled by its decision forces the
criterion into the body. Counting negated headings is the cheap check.

### 3. A classification covers everything it claims to classify

When the doc partitions what exists — layers, kinds, categories — every existing thing lands in
exactly one bucket, and a reader can place a new thing by the same partition.

A table that names three of eight teaches the reader that the partition is unreliable, and they
stop using it to decide. Either widen it until it is total, or narrow what it claims: a table of
*three examples* is honest and useful; a table presented as *the layers* is not, unless it holds
them all.

### 4. Restate what the decision needs; never re-derive a definition another file owns

Exit codes belong to the script that returns them. Frontmatter fields belong to the platform that
parses them. The list of what exists belongs to the directory that holds it.

`avoid-reference-detours` already settles whether you may repeat something: bring the part **this
reader needs in order to act**, in the shortest form that does the job. What this narrows is
*which* part:

| | Bring |
|---|---|
| The reader must decide something now | the part that settles it — "non-zero means do not commit it yet" |
| Another file defines the thing | the entity's name, not the enumeration — the script's own header lists which code means what |

The test: **if the other file changes, does this doc become wrong?** If yes, you copied a
definition. If no, you restated an input. This is matklad's staleness rule one step in: a
definition you copied goes stale exactly the way a link does.

## Organising the file

Inside the three sections, index by decision rather than by component. A contributor arrives with
one question, and headings are what they scan to find it.

The file sits on the mandatory path for anyone changing the repository, so what is capped is **the
distance to the decision they came for** — which is what "keep it short" is protecting. A file
whose headings are decisions stays cheap as it grows; one that must be read end to end does not.

## Language

Write it in the language its contributors already use — the repository's. The conditions above are
about what the doc settles, not which language settles it. The examples here are in English only
because this skill is.

## Common Rationalizations

| Rationalization | Reality |
|---|---|
| "Explaining what we currently do *is* the architecture." | The code shows what you currently do, faster and without drifting. What it cannot show is the invariant and what would settle the next decision — that is the only thing this file adds. |
| "The prohibition is the real content; the criterion is obvious." | It is obvious to you, because you already hold the criterion you derived it from. The reader gets one closed path and an unmapped space. Raise it to the rule it was an instance of, and check that the rule places a case you have not seen. |
| "matklad says to call out what is deliberately absent, so a list of absences is the doc." | He says an invariant is often an absence, not that an absence is always an invariant. "No layer imports upward" places everything; "the parser does not call the type checker" places nothing. Keep both, but only the first can carry a section. |
| "The table only lists the interesting cases." | Then say so in the table's own words. Presented as the classification, a partial table teaches the reader it cannot be trusted to place anything — including the thing they came to place. |
| "Linking the module is friendlier than naming it." | Until it moves. A name survives the rename and search finds it; the link becomes a lie nobody notices for a year. Name it. |
| "Recording why we chose this over the alternative is useful history." | The rationale stays; the deliberation goes (`avoid-unverifiable-context`). Write the constraint that rules the alternative out, as a wall the reader would hit — not the account of the two of you weighing it. |
| "It reads fine to me." | You are supplying the criteria you already hold. Judge it as someone who has the file open and the implementation closed — that is the whole failure mode. |

## Related skills

- `dont-make-me-read` — the test this one sharpens, and the rule that a constraint is stated as the
  wall the reader would walk into.
- `avoid-unverifiable-context` — what keeps deliberation out while the rationale stays.
- `avoid-reference-detours` — what to restate at the point of use, which condition 4 narrows for
  the definitions another file owns.
- `write-nice-skills` — a `SKILL.md` is an instruction to an agent, not an architecture doc; this
  skill stops where that one starts.
