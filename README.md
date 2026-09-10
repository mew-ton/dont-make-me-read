# dont-make-me-read

A [Claude Code](https://claude.com/claude-code) plugin for the writing other people have to read
before they can act — a GitHub issue, a PR review finding, a doc, a `SKILL.md`, a code comment,
the code itself.

The cost of that writing is not its length. It is how much the reader has to hold in their head
before they know what to do, and you cannot feel it: you read your own draft while supplying
everything it leaves out, so it reads clear to you and to nobody else. That is why this ships as
rules that load while you write, rather than advice you would have to remember to apply. They
reach the comment dashed off in the middle of some other task, which is the writing that needs
them most and the writing nobody stops to review.

The reader who pays is a person or an agent. Both collect the context, and both act on what they
end up holding.

## Install

There is no marketplace entry yet. Clone the repository and point Claude Code at the checkout:

```bash
git clone https://github.com/mew-ton/dont-make-me-read.git
claude --plugin-dir ./dont-make-me-read
```

## Commands

Commands are the whole user-facing surface.

| Command | Pick it when |
|---|---|
| `/write-issue` | you are handing a problem to someone else and they will have to act on it without you |
| `/write-review-comment` | you found something in a PR and want the fix to land without a round trip |
| `/write-skill` | you are writing or revising a `SKILL.md` |
| `/write-architecture` | a decision you just made by reading the code is one the next contributor will have to make again |
| `/write-readme` | someone will land on this project cold and has to work out whether it is theirs |
| `/review-issue` | an issue is already written and you want to know whether it can be acted on as it stands |
| `/review-text` | a PR is up and you want its description and the comments it changes read by someone with none of your context — optionally posted back as review comments |

A writing command settles what is not yet settled — fetching the existing issue, asking what is
still open, working out what the finding even is — and hands one brief to the skill that owns the
artifact. Nothing of the back-and-forth that produced the brief ends up in what gets written.

## Skills

You never type a skill name. Skills load on the model's own judgment while it writes, and the
commands above call the ones they need.

A skill's name leads with a verb, and the verb is the direction it works in: what it supplies to
your text, what it takes out, or what it gathers for something else to judge. Underneath all of
them stands `dont-make-me-read`, which is on whenever anything is being written and carries what
the reader has to hold and what it costs them.

## Language

The skills are written in English, because a published plugin cannot know which language its users
prompt in. What they tell you to *write* is a separate question, and they answer it the same way:
produce the issue, the finding or the doc in the language its readers already use, and write it in
one language only.

## Architecture

What settles a decision about this plugin's own shape — where a new entry point goes, what context
a skill runs in, what tools it gets — is in [`ARCHITECTURE.md`](ARCHITECTURE.md).

## License

MIT — see [LICENSE](LICENSE).
