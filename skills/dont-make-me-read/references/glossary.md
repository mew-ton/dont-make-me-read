# Glossary

What the words in `SKILL.md` mean, in prose and in a program alike. Where to find each of them in
the thing you are writing is in the file `SKILL.md › Which file to read` names for it.

## Explanation

Anything a reader takes in to act on: an agreement, a subject, a supplement, a trap, a reason, a
summary, a proposal, a principle, a program. The list is not closed.

## Claim

The unit explanations come in: the smallest part that can be cited on its own and rewritten on its
own. Each claim is a node, and each dependency an edge.

## Address

A name that leads, from where it is written, to exactly one claim. It holds only within a scope,
and outside that scope it is not an address:

- an identifier in a program: where it resolves, inside its own scope, and outside it once exported
- an issue or a pull request: its number inside its repository, and `owner/repo#number` or its URL
  outside it
- a page in another tool, such as Figma or Notion: its URL, down to the node or block where the
  tool has one
- a heading: inside its file, and with the file's path outside it

A URL holds only for the readers who can open it. One the writer can open and the reader cannot, a
chat session, a private channel, a file on the writer's disk, is not an address for that reader,
however exact it is.

An address is information: a name says what to call the thing it names, which that thing does not
say.

## Dependency

A claim depends on another when a change to the other means the claim has to be checked again.

## Duplicate

A claim that holds no information the claims it depends on do not already hold.
