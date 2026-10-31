---
name: dont-make-me-read--glossary
description: >
  Defines the words used to write and review text so that a reader can act on it, each in prose
  and in a program, with instances.
user-invocable: false
disable-model-invocation: false
---

## Reading it

Each word is defined under its heading, in prose and in a program alike. Prose is a paragraph of a
document, an issue, a review comment, a commit message, a comment in code. A program is a
declaration, its body, a test; it is described without any language's syntax, and where an
instance uses one, it is one instance.

A word with instances links them. Read them before applying the word, and apply it to a new case
as to the instance nearest it.

## Explanation

Anything a reader takes in to act on: an agreement, a subject, a supplement, a trap, a reason, a
summary, a proposal, a principle, a program. The list is not closed.

## Paragraph

The unit a claim is written in.

- In prose: a paragraph. A list item or a table row stands alone the same way.
- In a program: a named unit: a function, a type, a constant, a module, a test case.

## Claim

The unit explanations come in: the smallest part that can be cited on its own and rewritten on its
own. Each claim is a node, and each dependency an edge.

- In prose: what the paragraph says, as one thing to cite or rewrite.
- In a program: the body of a named unit, which explains what it does. A test is a named unit
  like any other; whether its name is a string or an identifier is the framework's business.

The address of a paragraph, as *Address* says what it is, summarises the paragraph and is a claim
of its own, which depends on what it summarises. It is not counted as a second claim of the
paragraph.

Instances: [`references/claim.md`](references/claim.md).

## Reader

Whoever acts on a claim: the people and agents who can open the place it sits in. There are
always two kinds: one who reads in order, and an agent that lands on the claim by search.

- In prose: a person reading from the top, and an agent landing on the paragraph by search.
- In a program: the person reading the file, and an agent landing on the declaration by search.

## Address

A name that leads, from where it is written, to exactly one claim. It holds only within a scope,
and outside that scope it is not an address:

- an identifier in a program: where it resolves, inside its own scope, and outside it once exported
- an issue or a pull request: its number inside its repository, and `owner/repo#number` or its URL
  outside it
- a page in another tool, such as Figma or Notion: its URL
- a heading: inside its file, and with the file's path outside it

A URL holds only for the readers who can open it. One the writer can open and the reader cannot, a
chat session, a private channel, a file on the writer's disk, is not an address for that reader,
however exact it is.

An address is information: a name says what to call the thing it names, which that thing does not
say.

- In prose: the heading above the paragraph; for a comment in code, the name of the declaration it
  sits on. Reading order is not an address: the agent arrives mid-document, so a paragraph that
  needs the one before it leans on something that reader does not have.
- In a program: the name of the unit, with what it declares to take and to give back.

Instances: [`references/address.md`](references/address.md).

## Dependency

A claim depends on another when a change to the other means the claim has to be checked again.
Whether the claim names the other by an address is apart from whether it depends on it.

Instances: [`references/dependency.md`](references/dependency.md).

## Source and derived

Of two claims, the one that explains, reproduces or uses the other is derived from it, and the
other is its source: a doc comment from the decision it cites, an implementation from its
interface, a caller from what it calls, a test from its subject, a name from its body.

## Location

Where a claim is, as a record of an analysis gives it: in this repository, the file's path and
the claim's first and last line, `path:first-last`, 1-based and inclusive; outside it,
`owner/repo#number` or a URL.

A location is not an address: its lines move when the file changes, so it holds only while the
files it was taken from are as they were.
