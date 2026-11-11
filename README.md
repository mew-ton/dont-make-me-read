# dont-make-me-read

*No more detective work. Every paragraph carries what you need to act on it, or names exactly
where it is.*

A plugin for [Claude Code](https://claude.com/claude-code) and claude.ai. It changes how Claude
writes and reviews what someone reads in order to act, such as an issue, a review comment, a doc
or a commit message, as the description in [*How it works*](#how-it-works) says.

## Why install it

Text written without its reader in mind sends them hunting: "as discussed" points at a meeting
they were not in, and the number in the README is not the one in the config file. With this
plugin, Claude writes so that:

- **A paragraph can be acted on where it is read.** What it leans on is named by a file path, a
  heading or a name, never by "see above", so a teammate, or an agent that landed there by search,
  opens exactly that and nothing more. This is rule 3 in [*The rules*](#the-rules).
- **Docs do not drift from the code.** A value that a file owns is cited from that file, not
  copied, so there is no second copy to go stale. This is rule 4.
- **A review shows where a reader would get lost**, and what to write instead, as
  [`SKILL.md › Reporting`](skills/dont-make-me-read/SKILL.md#reporting) says, when you ask for one
  as [*Using it*](#using-it) says.

How well it does this is not measured yet, as [*Does it work?*](#does-it-work) says.

## Before / after

```diff
- A payment call is tried up to five times before the order is marked failed.
+ A payment call is tried at most `maxAttempts` times (`config/retry.json`).
```

The README no longer copies a number that `config/retry.json` owns.
[Case 01](samples/01-stale-copy.md).

```diff
- export async function withRetry<T>(fn: () => Promise<T>, fromCheckout: boolean): Promise<T> {
+ export async function withRetry<T>(fn: () => Promise<T>): Promise<T> {
```

The retry layer no longer knows who calls it. [Case 07](samples/07-callee-knows-caller.md).

More cases: [`samples/`](samples/README.md).

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

Chat on claude.ai does not load the agents, so there every step of an analysis runs in the
conversation, as [`SKILL.md › Delegating`](skills/dont-make-me-read/SKILL.md#delegating) says for a
step with no agent.

To try a checkout without installing it:

```bash
git clone https://github.com/mew-ton/dont-make-me-read.git
claude --plugin-dir ./dont-make-me-read
```

## Using it

There is nothing to type. The skill is meant to load on Claude's own judgment while it writes or
reviews; whether it does is a row of [*What it relies on Claude for*](#what-it-relies-on-claude-for).

To review something on purpose, type `/dont-make-me-read:dont-make-me-read <scope>` in Claude
Code. The scope is "a path, a diff, or a pull request; with nothing after it, the uncommitted
change in the working tree", as [`SKILL.md › Invoking`](skills/dont-make-me-read/SKILL.md#invoking)
says. On claude.ai, ask in
words.

## How it works

The plugin is built on one skill. Its description, quoted:

> Keeps what a reader has to gather before they can act as small as it can be, and in one place.
> Applies whenever writing, changing or reviewing prose or code that someone else, a person or an
> agent, reads in order to act: an issue, a review comment, a doc, a commit message, a declaration,
> a test. Does not apply to text nobody acts on later: a chat reply, a scratch note.

From [`SKILL.md › What the reader pays`](skills/dont-make-me-read/SKILL.md#what-the-reader-pays):

> The cost of writing is everything the reader has to reach, from where they landed, before they
> can act: the paragraph in front of them and every paragraph it leans on.

What decides that cost is where each piece of information lives and what form it takes, which is
what [*The rules*](#the-rules) set.

The skill's analysis is split into sub-skills, some of which an agent in `agents/` runs in a session
of its own, as [`SKILL.md › Analysis`](skills/dont-make-me-read/SKILL.md#analysis) says. The
conversation that asked for the analysis then holds what those sessions answer, and opens only what
judging it needs.

Every sub-skill and agent is named `dont-make-me-read--…`, so that it shares no name with another
plugin's skill or agent.

## The rules

Quoted from [`SKILL.md › Rules`](skills/dont-make-me-read/SKILL.md#rules), where each one
carries its reason:

1. **One claim per paragraph, under an address.**
2. **Everything in it changes what the reader does next.**
3. **A dependency is named by address.**
4. **A claim that has an owner is cited, not restated.**
5. **Depend only on what you explain, reproduce or use, and converge.**
6. **The derived names its source, and the source does not name it.**
7. **A claim has one place.**

## Does it work?

Not measured yet: there are no numbers here because none have been taken. How they will be taken
is in [`samples/README.md › How to use a case`](samples/README.md#how-to-use-a-case).

### What it relies on Claude for

The skills and agents work as this file says only if each row of this table holds. Each row is
checked by hand, as its *Checked by* says. The steps of a review start the agents as
[`SKILL.md › Delegating`](skills/dont-make-me-read/SKILL.md#delegating) says, so its transcripts show
what the agents do.

| Assumption | Checked by | Last checked |
|---|---|---|
| A skill with `disable-model-invocation: false` is loaded on the model's judgment, from its description alone | step 1 of [`samples/README.md › How to use a case`](samples/README.md#how-to-use-a-case) | not yet |
| A skill that says it stays in force is still in force on the next response | step 2 of [`samples/README.md › How to use a case`](samples/README.md#how-to-use-a-case) | not yet |
| An agent's `skills` loads each skill it lists into the agent's session, and the agent can read that skill's references | [a review of this tree](ARCHITECTURE.md#reviewing), in the agent's transcript | not yet |
| A model that has loaded a skill loads another skill the first one names, when told to | [a review of this tree](ARCHITECTURE.md#reviewing), in the reviewing session's transcript | not yet |
| An agent's session starts without the conversation that started it | [a review of this tree](ARCHITECTURE.md#reviewing), in the agent's transcript | not yet |
| An agent's `skills` cannot preload a skill with `disable-model-invocation: true` | [sub-agents](https://code.claude.com/docs/en/sub-agents) | 2026-10-30 |
| An agent with no `tools` has every tool, `Agent` and `Skill` included | [sub-agents](https://code.claude.com/docs/en/sub-agents) | 2026-10-30 |
| Chat on claude.ai loads a plugin's skills and skips its agents | [platform support](https://claude.com/docs/plugins/platform-support) | 2026-10-31 |
| Chat on claude.ai loads a skill whose frontmatter has fields only Claude Code reads, such as `user-invocable` | adding the marketplace on claude.ai, then asking a chat which skills it has from plugins | not yet |

A row that fails on re-check is a change to the skills or agents, not to this table.

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
