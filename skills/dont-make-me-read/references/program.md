# Program

What the words in `SKILL.md` mean when what you are writing or reviewing is a program: a
declaration, its body, a test. Stated without any language's syntax; where an example uses one, it
is one instance.

## The words

| In `SKILL.md` | In a program |
|---|---|
| paragraph | a named unit: a function, a type, a constant, a module, a test case |
| claim | its body, which explains what it does |
| address | its name |
| reader | the person reading the file, and an agent landing on the declaration by search |

The name, with what it declares to take and to give back, is a claim of its own: it summarises
the body. So it depends on the body, since a change to what the body does means checking the name
again. It is not a duplicate, because the name is the address, which the body does not hold.

A test is a named unit like any other: its name summarises its body. Whether the name is a string
or an identifier is the framework's business, not this file's.

## Edges

A visible edge is a parameter, an import, a call by name, or an explicit statement that a type
implements an interface. The reader can follow it, and so can the toolchain.

A hidden edge is any of these. Each is a red flag:

- state the body uses without naming: a global, an environment variable, module state, setup that
  runs by position rather than by being called, such as a before-each block, a fixture file or a
  test's main
- a name that carries a caller's knowledge: a parameter or a branch named after who calls it
- a hook that production code holds only so a test can reach in
- an interface satisfied structurally, with nothing in the implementation saying so
- a comment that says what the body does in other words: a second owner of the same claim

One instance, a test whose setup is a hidden edge and one whose setup is named:

```ts
// Not this: the claim cannot be read without the block above it.
beforeEach(() => { store = makeStore({ items: fiveItems() }); });
it("shows at most three items", () => {
  expect(render(store.items, 3)).toHaveLength(3);
});

// This: the body names what it leans on.
it("shows at most three items", () => {
  const items = fiveItems();
  expect(render(items, 3)).toHaveLength(3);
});
```

## Saying which you are

A reproduction cites its source. A doc comment names the decision's heading, in the decision's
words. An implementation names its interface. Where the language leaves that implicit, add the line
that makes it explicit; one instance, in Go, is `var _ Iface = (*Impl)(nil)`.

A declaration never names what calls it. Where a body would need to know who called it, that
knowledge belongs in the caller, and crosses as a value the body does not interpret.

One instance:

```ts
// Not this: the callee knows its caller, and every later caller edits it.
function render(items: Item[], isDetailPage: boolean) {
  const shown = isDetailPage ? items : items.slice(0, 3);
  // ...
}

// This: the caller decides, the callee takes what it needs.
function render(items: Item[], limit: number) {
  const shown = items.slice(0, limit);
  // ...
}
```

## Placement

- A test is next to its subject: the same file or the same module, not a distant tree ordered by
  something else.
- An interface is where every implementation imports it from.

## Direction

The test depends on its subject and never the other way: production code holds nothing that exists
only for a test.
