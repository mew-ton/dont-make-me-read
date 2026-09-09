# What counts, and how to spot it

Read this when running the pass. The shapes below are what a dependency looks like on the page;
the section after them is how the strong ones surface, since nothing extracts those for you.

## The shapes

| The text | Is pinned to | Breaks when | Strength |
|---|---|---|---|
| A link, a path, a line number | the location | it moves | weak |
| An issue, ticket, or PR number | that item | it is closed, moved, or renumbered | weak |
| A citation of an external source | someone else's decision | they revise it, or it goes away | weak |
| A name carried in the prose | that definition | it is renamed, removed, or its meaning moves | strong |
| A count, or a set claimed to be complete | the membership | anything joins or leaves | strong |
| A definition or plan copied from wherever it is owned | the owner | the owner changes and this copy does not | strong |
| A claim about how something is arranged | that arrangement | it is restructured | strong |
| A translation, mirror, or second copy | the whole original | any part of the original changes | strong |

The list is not closed. A shape that is not here still counts if fixing the other end obliges a fix
here — that definition is the test, and the table is only the part of it that recurs.

## Spotting the strong ones

They do not announce themselves, so read for the shape of the sentence rather than for a marker.

- **Every proper noun is a question: who owns this name?** If the answer is somewhere else, the
  sentence is pinned to that somewhere else.
- **Every present-tense claim about something outside this file** — what it does, what it contains,
  how it is put together — is a claim about that thing's current state, and it expires when the
  state does.
- **Every enumeration.** "A and B", "the three phases", "each of the modules": a set is a
  membership claim whether or not it says how many.
- **Every sentence you could only have written with the other thing open.** That is the tell for a
  copied definition. If writing it required reading the source, keeping it true will too.
- **Every "as described in", "per", "same as".** The pointer is weak; what the sentence asserts
  around the pointer usually is not.

## What is not a dependency

- Vocabulary the whole field shares. Naming HTTP, or a merge conflict, pins nothing.
- A statement about this document's own contents.
- A example invented for the page, which nothing outside it owns — which is also why an example
  written against the tree you are documenting is worth more scrutiny than one that is not.
