# dont-make-me-read

*No more detective work. Every paragraph carries what you need to act on it, or names exactly
where it is.*

A plugin for [Claude Code](https://claude.com/claude-code) and claude.ai. With it, what Claude
writes for someone to act on, such as an issue, a review comment, a doc, a commit message or code,
can be acted on without hunting for context.

## Why install it

- **Nobody has to ask "which discussion?"** What a paragraph leans on is named by a file path, a
  heading or a name, never by "as discussed" or "see above". A teammate, or an agent that lands
  there from search, opens exactly that and nothing more.
- **Docs stop going out of date against the code.** A value is pointed to where it is defined,
  not copied, so there is no second copy to forget.
- **A review shows where a reader will get lost**, and what to write instead.

What Claude follows to do this is [`SKILL.md › Rules`](skills/dont-make-me-read/SKILL.md#rules).

## Before / after

```diff
- Payments are retried up to 5 times.
+ Payments are retried up to `maxAttempts` times (`config/retry.json`).
```

The docs cannot disagree with the config.

```diff
- As discussed in standup, checkout hangs.
+ Checkout hangs: QA report 142 (`docs/qa-report-142.md`).
```

Someone who was not at standup can act on it.

```diff
- // Add one to the count.
  count += 1;
```

Less to read, and nothing to fall out of date.

More examples: [`samples/`](samples/README.md).

## What it is not

- **Not a linter.** It is judgment, applied while writing or reviewing. The only script here,
  [`scripts/check.sh`](scripts/check.sh), checks this repository and nothing of yours.
- **Not a style guide.** It does not care about tone or grammar.

## Install

This repository is a marketplace that lists this one plugin.

On claude.ai or in the Claude desktop app, open **Customize › Plugins**, choose **Add › Add
marketplace**, enter `mew-ton/dont-make-me-read`, and add **dont-make-me-read** from it. It is then
on your account, and Claude Code signed in to the same account loads it as a synced plugin.

In Claude Code:

```text
/plugin install dont-make-me-read --marketplace mew-ton/dont-make-me-read
```

To try a checkout without installing it:

```bash
git clone https://github.com/mew-ton/dont-make-me-read.git
claude --plugin-dir ./dont-make-me-read
```

## Using it

There is nothing to type: it is meant to apply on its own whenever Claude writes or reviews such
text.

To ask for a review, type `/dont-make-me-read:dont-make-me-read <scope>` in Claude Code, where the
scope is a path, a diff or a pull request, or nothing for your uncommitted change, as
[`SKILL.md › Invoking`](skills/dont-make-me-read/SKILL.md#invoking) says. On claude.ai, ask in
words.

## Does it work?

Not measured yet: there are no numbers here because none have been taken. How they will be taken
is in [`samples/README.md › How to use a case`](samples/README.md#how-to-use-a-case).

## Language

It works in any language. The skill is written in English, and says nothing about which language
to write in.

## Contributing

See [`ARCHITECTURE.md`](ARCHITECTURE.md).

## License

MIT, see [LICENSE](LICENSE).
