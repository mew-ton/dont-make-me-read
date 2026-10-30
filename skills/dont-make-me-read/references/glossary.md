# Glossary

What the words of `SKILL.md` and of a review mean, in prose and in a program alike, each with
instances. Prose is a paragraph of a document, an issue, a review comment, a commit message, a
comment in code. A program is a declaration, its body, a test; it is described without any
language's syntax, and where an instance uses one, it is one instance.

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

The address of a paragraph summarises the paragraph and is a claim of its own, which depends on
what it summarises: a heading in prose, and in a program the name, with what it declares to take
and to give back. It is not counted as a second claim of the paragraph.

Instances:

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

## Reader

Whoever acts on a claim. There are always two: one who reads in order, and an agent that lands on
the claim by search.

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
- In a program: the name of the unit.
- Addresses: `config/retry.json` in the same repository; `withRetry` in a module that imports it;
  `#231` in an issue of the same repository; `example/orderly#231` anywhere on GitHub;
  `README.md › Retries` from another file; a Figma URL, for readers who can open the file.
- Not addresses: "the config"; "the section below"; `#231` pasted into a chat tool; the URL of a
  chat session, for a pull request's author who cannot open it; the name of a function its module
  does not export, written in another module; a Figma URL, for a reader without access to the file.

## Dependency

A claim depends on another when a change to the other means the claim has to be checked again.

- Dependencies: a doc comment that cites a decision, on the decision; a README sentence that gives
  the retry limit, on `config/retry.json`; a test body, on the set-up it uses; a name, on the body
  it summarises.
- Not dependencies: a sentence using "timeout" as everyone uses it, unless the project defines the
  word; two functions that happen to look alike, when a change to one does not mean checking the
  other.

## Source and derived

Of two claims, the one that explains, reproduces or uses the other is derived from it, and the
other is its source: a doc comment from the decision it cites, an implementation from its
interface, a caller from what it calls, a test from its subject, a name from its body.

## Edge judgments

Each judges an edge from A to B, where A depends on B. An edge is visible, missing or a
contradiction, and it also converges or diverges.

### Visible

A reader can reach both ends: A names B by an address that holds for A's readers.

- In prose: a path, a link, a heading named, or an identifier in backticks, leading to something
  the paragraph's readers can open. A script can check that the target exists.
- In a program: a parameter, an import, a call by name, or an explicit statement that a type
  implements an interface. The toolchain can follow it.

### Missing

A reader cannot reach one end, or both: A names B by nothing, or by something that is not an
address for A's readers, or an end has no address.

In prose it shows as any of these, each with what to do instead:

- "see above", "below", "the previous section": a position. Name the heading.
- "as discussed", "we originally went with", "not A but B": a past only the participants hold.
  Write down what was settled where the reader can open it, and name that.
- "as requested", "you said", an instruction with nothing in front of it: the conversation that
  produced this text, which its reader was not in. The same.
- "the config", "the usual way", "same as the other one": a thing named by its role. Name its
  address.
- a count, a name or a definition copied from the file that owns it, without naming that file.
  Name the owner.
- a sentence that only means something with another file open. Name the file.
- an address the paragraph's readers cannot open: a chat session, a private channel, a file on the
  writer's disk. Put the claim where they can open it, and name that.

In a program it shows as any of these:

- state the body uses and the signature does not declare: a global, an environment variable,
  module state. The body names it, and a caller, who reads only the name and the signature, cannot
  reach it.
- an interface satisfied structurally, with nothing in the implementation saying so

### Contradiction

What A holds of B's information disagrees with B as it is now.

- A README that says five where the config says `3`; a doc comment that says "returns null when
  not found" over a body that throws.

### Converging

Adding another claim like B leaves A as it is, because A points at whatever a scope holds. There is
nothing to fix.

- Set-up that every test in its scope depends on; a router that serves whatever the pages
  directory holds.

### Diverging

Adding another claim like B means rewriting A, because A names each such claim one by one, or sits
in a scope wider than the claims that depend on it. It is not a bug in itself; it is a tendency
that makes each new claim cost a change elsewhere, and a signal to fix. To find one, ask which
existing claims have to be rewritten to add a claim, one that is only planned included; the edges
from those to the new one diverge.

- In prose: a decision that lists the declarations implementing it.
- In a program: a list that names its members one by one where they could be found by a
  convention, such as a route table with a line per page; a name that carries a caller's
  knowledge, a parameter or a branch named after who calls it; a hook that production code holds
  only so a test can reach in; shared set-up, such as a before-each block, a fixture file or a
  test's main, holding what only some of the tests in its scope depend on.

One instance, set-up that holds what only one of its tests depends on, and the same tests with
that test holding it itself:

```ts
// Not this: only the first test depends on there being five items.
beforeEach(() => { store = makeStore({ items: fiveItems() }); });
it("shows at most three items", () => {
  expect(render(store.items, 3)).toHaveLength(3);
});
it("shows the store's name", () => {
  expect(renderName(store)).toBe("Shop");
});

// This: the set-up holds what every test depends on, and the test holds the rest.
beforeEach(() => { store = makeStore(); });
it("shows at most three items", () => {
  const items = fiveItems();
  expect(render(items, 3)).toHaveLength(3);
});
it("shows the store's name", () => {
  expect(renderName(store)).toBe("Shop");
});
```

### Reversed

The edge runs from a source to a claim derived from it. That says which way it runs; it signals
something to fix only when it also diverges.

- Set-up that every test in its scope depends on, which is converging; a callee with a parameter
  named after its caller, which is diverging.

## Node judgments

### Duplicate

A claim that holds no information the claims it depends on do not already hold.

- Duplicates: a comment that says what the body does in other words, such as
  `// print the text to the console` over `console.log(text)`; `// checks 2 + 3 is 5` inside a
  test named "adding 2 and 3 gives 5"; a README sentence that says "three times" where
  `config/retry.json` says `3`, naming no owner.
- Not duplicates, because an address is information (*Address*): a function's name over its body,
  or a test's name over its body; a quote in the owner's words that names the owner.
- Not a duplicate, because it holds what the body cannot show: a comment such as "stdout is
  buffered: flush before exit".

### Two claims

It is not one claim, as *Claim* defines one; the instances are under *Claim*.

### Noise

It changes nothing its reader does next. It is judged against the reader, not read off the graph.

Not noise: the reason for a decision, the constraint stated as the wall the reader would walk into,
the fact that makes an ask defensible. Without them the reader decides with less than the writer
had. Noise is what makes a reader confident about the wrong thing:

| Noise | What the reader concludes |
|---|---|
| a menu of fixes the writer could have weighed | that the choice is theirs, to make with less information than the writer had |
| the paths the writer happened to sample, given as the fix | an agent: that those are the complete set to touch |
| "handle this appropriately" | that the spec is complete |
| the implementation method, in an issue | that the shape seen while writing is still the shape today |
| an export production code holds only for a test to reset it | a production reader: that it is part of the module's use |
| a block of code left in as a comment | that it may still matter |
