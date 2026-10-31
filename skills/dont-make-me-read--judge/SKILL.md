---
name: dont-make-me-read--judge
description: >
  Judges each edge and each claim of the graph that the records of
  dont-make-me-read--extract-claims, dont-make-me-read--extract-dependencies and
  dont-make-me-read--extract-dependents form, and defines each judgment it makes.
user-invocable: false
disable-model-invocation: false
---

## What it does

Judges each edge and each claim of the graph that the records of
`dont-make-me-read--extract-claims`, `dont-make-me-read--extract-dependencies` and
`dont-make-me-read--extract-dependents` form, for the readers the task gives. The fields are as
each skill's *Record* lists them, and the words as `dont-make-me-read--glossary` defines them. The
judgments are defined here, each with instances under its heading or named there: read them before
judging, and judge a new case by the instance nearest it. What to do instead of each finding is
*Reporting* in the skill `dont-make-me-read`.

## Steps

1. **Judge each edge** as visible or missing, and whether it is a contradiction.
2. **Judge each edge again** as converging or diverging, and say whether it is reversed.
3. **Judge each claim** as a duplicate or noise, and each paragraph as two claims, where it is
   one.

## Edge judgments

Each judges an edge from A to B, where A depends on B. A record of dependencies gives the edges
from its claim; a record of dependents gives the edges into its claim.

### Visible

A reader can reach both ends: A names B by an address that holds for A's readers.

- In prose: a path, a link, a heading named, or an identifier in backticks, leading to something
  the paragraph's readers can open. A script can check that the target exists.
- In a program: a parameter, an import, a call by name, or an explicit statement that a type
  implements an interface. The toolchain can follow it.

### Missing

A reader cannot reach one end, or both: A names B by nothing, or by something that is not an
address for A's readers, or an end has no address.

Which places a reader can open, a repository, a Figma file, a Notion page, depends on the access a
team gives. Whether an edge missing for that reason is fixed by moving the claim or by giving the
access is the team's to decide.

It shows as a dependency named by something other than an address, as the instances of
*Dependency* in `dont-make-me-read--glossary` list them. What to do instead is the same for each:
put what it leans on where its readers can open it, if it is not there already, and name it by an
address.

### Contradiction

What A holds of B's information disagrees with B as it is now.

- A README that says five where the config says `3`; a doc comment that says "returns null when
  not found" over a body that throws.

### Converging

Adding another claim like B leaves A as it is, because A points at whatever a scope holds.

- Set-up that every test in its scope depends on; a router that serves whatever the pages
  directory holds.

### Diverging

Adding another claim like B means rewriting A, because A names each such claim one by one, or sits
in a scope wider than the claims that depend on it, so each new claim costs a change elsewhere. To
find one, ask which existing claims have to be rewritten to add a claim, one that is only planned
included; the edges from those to the new one diverge.

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

The edge runs from a source to a claim derived from it, as *Source and derived* in
`dont-make-me-read--glossary` defines them. That says which way it runs.

- The edge from shared set-up to the tests whose needs it holds, which is converging when every
  test in its scope depends on it; the edge from a callee to the caller its parameter is named
  after, which is diverging. In both, what is used leans on what uses it.

## Node judgments

### Duplicate

A claim that holds no information the claims it depends on do not already hold, or that says of
a claim nothing another claim depending on it does not already say. What is compared is what each
says of the claim they depend on; their own addresses are not part of it.

Each copy is one more place to keep right.

- Duplicates: a comment that says what the body does in other words, such as
  `// print the text to the console` over `console.log(text)`; `// checks 2 + 3 is 5` inside a
  test named "adding 2 and 3 gives 5"; a README sentence that says "three times" where
  `config/retry.json` says `3`, naming no owner; a second test that asserts of its subject what
  another test already asserts, under a different name.
- Not duplicates, because an address is information (*Address* in `dont-make-me-read--glossary`):
  a function's name over its body, or a test's name over its body; a quote in the owner's words
  that names the owner.
- Not a duplicate, because it holds what the body cannot show: a comment such as "stdout is
  buffered: flush before exit".

### Two claims

A paragraph, or anything cited as one, that holds more than one claim, as *Claim* in
`dont-make-me-read--glossary` defines one, with its instances. In the records, claims that share a
`paragraph` show it.

### Noise

It changes nothing its reader does next. It is judged against the reader, not read off the graph.
Each such line is one more thing the reader pays to read and may act on wrongly.

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
