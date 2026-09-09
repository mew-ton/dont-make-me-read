---
name: find-document-dependencies
description: >
  A document depends on whatever it would have to be rewritten for, and a link is the least of it:
  a name whose definition lives elsewhere, a count, a definition copied from the file that owns it,
  a claim about a structure, a path. Surfaces each one with what it is pinned to and what change
  breaks it, so the caller can weigh what it buys. Apply when reviewing or revising a document, and
  before writing a sentence that names something you do not own. DO NOT expect a verdict on whether
  a dependency is stale, wrong, or worth keeping — this reports what the text is pinned to and
  leaves the judgement to whoever asked.
user-invocable: false
disable-model-invocation: false
allowed-tools: []
---

## Scope

A document's dependencies are not only the things it links to. Anything it names, counts, copies,
or claims about a structure it does not own is a dependency: when that thing changes, this document
becomes wrong, and somebody has to notice and rewrite it.

That cost is invisible while writing, because the sentence is true when you write it. It shows up
later, as a document that quietly stopped being true, or as an edit nobody could skip.

This skill reports what a document is pinned to. It does not judge. A dependency is not a defect —
a document with none says nothing about anything — and whether one earns its upkeep is a question
about what it buys, which the caller is holding and this skill is not.

## What counts

| The text | Is pinned to | Breaks when |
|---|---|---|
| A name defined elsewhere | that definition | it is renamed, removed, or its meaning moves |
| A count, or a set claimed to be complete | the membership | anything joins or leaves |
| A definition copied from the file that owns it | the owner | the owner changes and this copy does not |
| A claim about how something is arranged | that arrangement | it is restructured |
| A path, a link, a line number | the location | it moves |
| A cited external source | someone else's decision | they revise it, or it goes away |
| A translation, mirror, or second copy | the whole original | any part of the original changes |

Two things sharpen a report and cost nothing to include:

- **Role or instance.** A name for an architectural role outlives whatever currently fills it; a
  name for the filler does not. Same sentence, different upkeep, and the caller cannot tell them
  apart from the span alone.
- **Who owns the other end.** A dependency on something in this repository is one somebody here can
  see break. One on an external source is not.

## What to return

Per dependency: the span, what it is pinned to, what change breaks it, and whether it is pinned to
a role or an instance. Quote the span rather than describing it — the caller has to weigh the
actual sentence, and a paraphrase is a second copy with its own dependency.

Return the ones you found and say nothing about the ones you did not. A pass that reports "no other
dependencies" is claiming completeness it cannot have.

## Common Rationalizations

| Rationalization | Reality |
|---|---|
| "Only links are dependencies; the rest is just prose." | A name is a link the reader cannot click and the maintainer cannot grep for. It breaks the same way and announces it less. |
| "It is accurate right now, so it is fine." | Every dependency was accurate when it was written. What is being weighed is what happens on the day it stops being. |
| "Listing this many would be noise." | The list is the finding. Whether an entry is worth acting on is the caller's call, and they cannot make it for the entries you filtered out. |
| "This one is obviously fine, so I will leave it out." | Obviously fine is a verdict. Report it and let the caller agree with you. |
| "I will note that the rest of the document is clean." | You checked what you checked. A completeness claim is itself a dependency — on your own thoroughness, which nobody can verify later. |

## Related skills

- `avoid-reference-detours` — the reader's side of a pointer: the trip they were made to take. This
  skill is the maintainer's side: the edit somebody will be made to make.
- `write-nice-architecture-docs` — the artifact where these dependencies cost the most, and which
  states which ones an architecture doc may take.
