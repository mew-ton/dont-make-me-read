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
- a page in another tool, such as Figma or Notion: its URL
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

## Source and derived

Of two claims, the one that explains, reproduces or uses the other is derived from it, and the
other is its source.

## Edge judgments

Of an edge from A to B, where A depends on B:

| Judgment | Meaning |
|---|---|
| visible | a reader can reach both ends: A names B by an address that holds for A's readers |
| missing | a reader cannot reach one end, or both: A names B by nothing, by a position, a role or a conversation, or by a name that is not an address for A's readers, or an end has no address |
| contradiction | what A holds of B's information disagrees with B as it is now |

Every edge also converges or diverges, by what adding another claim like B does to A:

- **converging**: A stays as it is. A points at whatever a scope holds: set-up that every test in
  its scope depends on, a router that serves whatever the pages directory holds.
- **diverging**: A has to be rewritten. A names each such claim one by one, or sits in a scope
  wider than the claims that depend on it: a route table with a line per page, a parameter per
  caller, a decision that lists its implementations. It is a defect.

To find diverging edges, ask which existing claims have to be rewritten to add a claim, one that
is only planned included. The edges from those to the new one diverge.

An edge from a source to a claim derived from it is **reversed**. That says which way it runs; it
is a defect only when it diverges.

## Node judgments

| Judgment | Meaning |
|---|---|
| duplicate | as *Duplicate* says |
| two claims | a part of it can be cited or rewritten on its own, so it is more than one claim |
| noise | it changes nothing its reader does next; judged against the reader, not read off the graph |
