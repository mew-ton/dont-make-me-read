---
name: dont-make-me-read--judge
description: >
  Judges each edge and each claim of the graph that the records of
  dont-make-me-read--extract-claims and dont-make-me-read--extract-dependencies form, and defines
  the judgments of a dont-make-me-read review.
user-invocable: false
disable-model-invocation: false
---

## What it does

Judges each edge and each claim of the graph that the records of
`dont-make-me-read--extract-claims` and `dont-make-me-read--extract-dependencies` form, for the
readers the task gives. The fields are as each skill's *Record* lists them, and the words as
`dont-make-me-read--glossary` defines them. The judgments are defined here, each with instances
under its heading: read them before judging, and judge a new case by the instance nearest it.

## Steps

1. **Check that each edge can be followed.** It is visible or missing.
2. **Check what a claim holds of what it depends on.** Where it restates part of it, the two agree,
   or the edge is a contradiction. Where it holds nothing they do not, or says of one of them
   nothing another claim depending on it does not already say, it is a duplicate.
3. **Check what adding one more does.** Ask which existing claims have to be rewritten to add
   another claim like this one, a planned one included. The edges from those to it diverge; the
   others converge.
4. **Check that each paragraph is one claim.** One that holds more than one claim of the record is
   two claims.
5. **Check what each claim changes.** One that changes nothing its reader does next is noise.

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

Which places a reader can open, a repository, a Figma file, a Notion page, depends on the access a
team gives. Whether an edge missing for that reason is fixed by moving the claim or by giving the
access is the team's to decide.

It shows as a dependency named by something other than an address, as the instances of
*Dependency* in `dont-make-me-read--glossary` list them. What to do instead, by what names it:

- a position: name the heading.
- a past only its participants hold, or the conversation that produced the text: write down what
  was settled where the reader can open it, and name that.
- a role: name its address.
- nothing: name the file that owns it, or the file it only means something with.
- an address its readers cannot open: put the claim where they can open it, and name that.
- in a program, nothing a caller reads: the body names the state, and a caller, who reads only the
  name and the signature, cannot reach it.

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

The edge runs from a source to a claim derived from it. That says which way it runs; it signals
something to fix only when it also diverges.

- Set-up that every test in its scope depends on, which is converging; a callee with a parameter
  named after its caller, which is diverging.

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

It is not one claim, as *Claim* in `dont-make-me-read--glossary` defines one, with its
instances.

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
