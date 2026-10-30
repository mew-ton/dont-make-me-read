# Glossary

What the words in `SKILL.md` mean, in prose and in a program alike, each with instances. Where to
find each of them in the thing you are writing is in the file `SKILL.md › Which file to read`
names for it.

## Explanation

Anything a reader takes in to act on: an agreement, a subject, a supplement, a trap, a reason, a
summary, a proposal, a principle, a program. The list is not closed.

## Claim

The unit explanations come in: the smallest part that can be cited on its own and rewritten on its
own. Each claim is a node, and each dependency an edge.

- "Checkout times out after 30 seconds when the provider is slow. It is 30 because the provider's
  SLA is 25. Please raise it to 60.": three claims, an observation, a reason and a request.
- A commit message "Fix the checkout timeout and rename `fmt` to `formatPrice`": two claims. Each
  can be reverted alone.
- A function that rejects an empty order and then saves it: two claims. The rule can change while
  saving stays.
- A test named "adds an item" that also checks the total: two claims, and the name summarises one.
- "A payment call is tried at most `maxAttempts` times, and then the order is marked failed": two
  claims. What happens when the tries run out can change while the limit stays.
- `const MAX_ATTEMPTS = 3`: one claim. No part of it can change alone.

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

- Addresses: `config/retry.json` in the same repository; `withRetry` in a module that imports it;
  `#231` in an issue of the same repository; `example/orderly#231` anywhere on GitHub;
  `README.md › Retries` from another file; a Figma URL, for readers who can open the file.
- Not addresses: "the config"; "the section below"; `#231` pasted into a chat tool; the URL of a
  chat session, for a pull request's author who cannot open it; the name of a function its module
  does not export, written in another module; a Figma URL, for a reader without access to the file.

## Dependency

A claim depends on another when a change to the other means the claim has to be checked again.

- Dependencies: a doc comment that cites a decision, on the decision; a README sentence that gives
  the retry limit, on `config/retry.json`; a test body, on the set-up it uses.
- Not dependencies: a sentence using "timeout" as everyone uses it, unless the project defines the
  word; two functions that happen to look alike, when a change to one does not mean checking the
  other.

## Duplicate

A claim that holds no information the claims it depends on do not already hold.

- Duplicates: `// print the text to the console` over `console.log(text)`; `// checks 2 + 3 is 5`
  inside a test named "adding 2 and 3 gives 5"; a README sentence that says "three times" where
  `config/retry.json` says `3`, naming no owner.
- Not duplicates: a function's name over its body, or a test's name over its body, since the name
  is the address; a quote in the owner's words that names the owner, since the address it gives is
  information the owner does not hold; a comment that warns of what the body cannot show, such as
  "stdout is buffered: flush before exit".

## Source and derived

Of two claims, the one that explains, reproduces or uses the other is derived from it, and the
other is its source: a doc comment from the decision it cites, an implementation from its
interface, a caller from what it calls, a test from its subject, a name from its body.

## Edge judgments

Of an edge from A to B, where A depends on B:

| Judgment | Meaning |
|---|---|
| visible | a reader can reach both ends: A names B by an address that holds for A's readers |
| missing | a reader cannot reach one end, or both: A names B by nothing, by a position, a role or a conversation, or by a name that is not an address for A's readers, or an end has no address |
| contradiction | what A holds of B's information disagrees with B as it is now |

- Visible: a README that names `config/retry.json`; a doc comment that names
  `docs/architecture.md › Retries are bounded`; a body that calls a `withRetry` it imports.
- Missing: "see the section below"; "as discussed in standup"; "the usual retry config"; `#231` in
  a chat message; a value copied from `config/retry.json` without naming it; the edge from a caller
  of `formatPrice` to module state that `formatPrice` reads and its signature does not declare.
- Contradiction: a README that says five where the config says `3`; a doc comment that says "returns
  null when not found" over a body that throws.

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
| two claims | a part of it can be cited or rewritten on its own, so it is more than one claim; instances are under *Claim* |
| noise | it changes nothing its reader does next; judged against the reader, not read off the graph |

- Noise: an export that production code holds only for a test to reset it; a block of code left in
  as a comment. Instances in prose are in `prose.md › What noise does`.
- Not noise: the reason for a decision, the constraint the reader would otherwise walk into, the
  fact that makes an ask defensible. Each changes what the reader decides.
