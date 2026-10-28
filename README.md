# dont-make-me-read

A [Claude Code](https://claude.com/claude-code) plugin. It is one skill, loaded on the model's own
judgment while it writes, with nothing for you to type.

## What it does

The skill's own description, quoted:

> Keeps what a reader has to gather before they can act as small as it can be, and in one place.
> Applies whenever writing or changing prose or code that someone else, a person or an agent, reads
> in order to act: an issue, a review comment, a doc, a commit message, a declaration, a test. Does
> not apply to text nobody acts on later: a chat reply, a scratch note.

The rule itself, and what its words mean in prose and in a program, is in
[`skills/dont-make-me-read/SKILL.md`](skills/dont-make-me-read/SKILL.md).

## Install

There is no marketplace entry yet. Clone the repository and point Claude Code at the checkout:

```bash
git clone https://github.com/mew-ton/dont-make-me-read.git
claude --plugin-dir ./dont-make-me-read
```

## Language

The skill is written in English, because a published plugin cannot know which language its users
prompt in. What it tells you to *write* is a separate question, and it answers it the same way every
time: in the language the reader already uses, and in one language only.

## What it relies on Claude Code for

The skill is in force only if Claude Code behaves as the table says. Each row is checked by running
the case with the plugin installed and without, so a case the skill reached is told apart from one
the model would have handled anyway. The case is
[`samples/dependency-extraction/`](samples/dependency-extraction/ANSWER.md), which carries its own answer key.

| Assumption | Last checked |
|---|---|
| A skill with `disable-model-invocation: false` is loaded on the model's judgment, from its description alone | not yet |
| A skill that says it stays in force is still in force on the next response | not yet |

A row that fails on re-check is a change to the skill, not to this table.

## Contributing

See [`ARCHITECTURE.md`](ARCHITECTURE.md).

## License

MIT, see [LICENSE](LICENSE).
