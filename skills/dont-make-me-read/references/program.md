# Program

How to write a program, as `dont-make-me-read--glossary` › *Reading it* says what a program is,
under the rules in `SKILL.md`. What the words mean, with instances, is that skill too.

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
