# dont-make-me-read (beta)

*No more detective work. Every paragraph carries what you need to act on it, or names exactly
where it is.*

---

You open an issue. It says "as discussed". You find the thread; it links a doc. The doc says "see
the section below", and the section below gives a number the config file disagrees with. Forty
minutes later you know what the issue meant, and you have not written a line.

That is not reading. It is detective work: tracing claims across five tabs, checking which copy is
the current one, reconstructing a meeting you were not in. Nobody was hired to do it, and everybody
does it, every day, because the writer could not feel the gap they left. They were carrying the
missing part in their head.

Good engineers do not work that way with each other. They talk in source code: a name, a signature,
a test, a path. The other one reads it and knows what was meant, with no meeting, no glossary, and
no "let me give you some context". The code carries its own context, or names where it lives.

This plugin is there to make your agent write everything that way, the prose included.

## What it does

A [Claude Code](https://claude.com/claude-code) plugin with one skill, meant to load on the model's
own judgment while it writes or reviews, with nothing for you to type. The skill's own description,
quoted:

> Keeps what a reader has to gather before they can act as small as it can be, and in one place.
> Applies whenever writing, changing or reviewing prose or code that someone else, a person or an
> agent, reads in order to act: an issue, a review comment, a doc, a commit message, a declaration,
> a test. Does not apply to text nobody acts on later: a chat reply, a scratch note.

## The idea

From [`SKILL.md › What the reader pays`](skills/dont-make-me-read/SKILL.md#what-the-reader-pays):

> The cost of writing is everything the reader has to reach, from where they landed, before they
> can act: the paragraph in front of them and every paragraph it leans on.

What decides that cost is where each piece of information lives and what form it takes. Keep every
claim in its one right place, in a form that names what it leans on, and two things get better
with it, without being aimed at. An agent that lands on a paragraph by search finds what it needs
there, or the exact address of it. And the code and the documents stop contradicting each other,
because each claim has one copy to keep right, and everything else points at it.

## Before / after

A README that restates a value it does not own. From
[case 01](samples/01-stale-copy.md):

```md
A payment call is tried up to five times before the order is marked failed. The wait between
tries doubles each time.
```

`config/retry.json` says `"maxAttempts": 3`. Nothing tells the reader there are two places, and
nothing told whoever changed `config/retry.json` that the README existed. After:

```md
A payment call is tried at most `maxAttempts` times (`config/retry.json`), and then the order is
marked failed.
```

The README no longer holds the number, so it cannot drift from it.

A function that knows who calls it. From [case 07](samples/07-callee-knows-caller.md):

```ts
export async function withRetry<T>(fn: () => Promise<T>, fromCheckout: boolean): Promise<T> {
```

To read the retry layer, you now have to know what checkout is, and the next caller adds a
`fromAdmin`. After, checkout catches the error and picks its own message, and `withRetry` takes
only `fn`.

The rest of the cases, each with the graph of what depends on what, are in
[`samples/`](samples/README.md).

## The rules

Quoted from [`SKILL.md › Rules`](skills/dont-make-me-read/SKILL.md#rules), where each one
carries its reason:

1. **One claim per paragraph, under an address.**
2. **Everything in it changes what the reader does next.**
3. **A dependency is named by address.**
4. **A claim that has an owner is cited, not restated.**
5. **Depend only on what you explain or reproduce.**
6. **A claim has one place.**

## What it is not

- **Not a linter.** It is judgment, applied while writing or reviewing. The only script here,
  [`scripts/check.sh`](scripts/check.sh), checks this repository and nothing of yours.
- **Not a style guide.** It does not care about tone or grammar.

## Does it work?

Not measured yet: there are no numbers here because none have been taken. How they will be taken
is in [`samples/README.md › How to use a case`](samples/README.md#how-to-use-a-case).

### What it relies on Claude Code for

The skill is in force only if each row of this table holds. Each row is checked by hand, by the
step of a case it names.

| Assumption | Checked by | Last checked |
|---|---|---|
| A skill with `disable-model-invocation: false` is loaded on the model's judgment, from its description alone | step 1 | not yet |
| A skill that says it stays in force is still in force on the next response | step 2 | not yet |

A row that fails on re-check is a change to the skill, not to this table.

## Install

There is no marketplace entry yet. Clone the repository and point Claude Code at the checkout:

```bash
git clone https://github.com/mew-ton/dont-make-me-read.git
claude --plugin-dir ./dont-make-me-read
```

## Language

The skill is written in English, because a published plugin cannot know which language its users
prompt in. It says nothing about which language to write in.

## FAQ

**Why does it never write "see above"?**
Because the next reader is often an agent that landed on this paragraph by search. For that reader
there is no "above".

**Why does it cite instead of explaining things again?**
A copy is a second place the claim lives, and the one nobody updates. A citation sends the reader
to the one place that is kept current.

**Why the name?**
Because the paragraph in front of you should be enough. If it is not, it should say exactly what
else to open, and nothing more.

## Contributing

See [`ARCHITECTURE.md`](ARCHITECTURE.md).

## License

MIT, see [LICENSE](LICENSE).
