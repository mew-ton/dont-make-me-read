# Architecture

## Under its own rules

This tree is written under the rules in
[`skills/dont-make-me-read/SKILL.md`](skills/dont-make-me-read/SKILL.md). Contribute to it the way
that skill says to write anything.

The skill is meant to load while you do. Whether it does is a row of
[*What it relies on Claude for*](#what-it-relies-on-claude-for).

## What check.sh checks

[`scripts/check.sh`](scripts/check.sh) checks the form of the tree, as its header lists. Whether
what the tree says holds together is not its job; that is the job of *Reviewing*.

How the sizes are recorded is the comment on `snapshot` in `scripts/check.sh`.

Nothing runs the script for you. Run `bash scripts/check.sh` before proposing a change.

## Releasing

A release is a change to `version` in
[`.claude-plugin/plugin.json`](.claude-plugin/plugin.json), proposed in a pull request like any
other. Once it is on `main`, [`.github/workflows/release.yml`](.github/workflows/release.yml) tags
and publishes it, as its steps say.

## Reviewing

A review finds in the graph of claims the findings
[`SKILL.md › Reporting`](skills/dont-make-me-read/SKILL.md#reporting) names.

### Scope

- The skills, the references, the agents, and this tree's own documents: `README.md`, this file,
  `samples/README.md`, and the comments in `scripts/check.sh`. Every claim in them is in scope.
- Each case in `samples/`, on its own. Three questions only: does the Good fix what *What is wrong*
  names; does the Good bring in a finding of its own; do the graph and *Why* match the case's files.
- Out of scope: the logic of sample code, agreement between cases, and anything a judgment does not
  name. The code in a case has no owner; it is there to carry the case's graph.

### Steps

The steps in [`SKILL.md › Steps`](skills/dont-make-me-read/SKILL.md#steps), over *Scope*,
reported as [`SKILL.md › Reporting`](skills/dont-make-me-read/SKILL.md#reporting) says.

A review also checks, in the transcripts its steps leave, each row of
[*What it relies on Claude for*](#what-it-relies-on-claude-for)
that names a review of this tree, and dates the row it checked.

### When it is done

A review is done when its scope has no finding. The next review takes as its scope only the claims
a change touched and the claims with an edge to them.

## What it relies on Claude for

The skills and agents work as they are written only if each row of this table holds. Each row is
checked by hand, as its *Checked by* says. The steps of a review start the agents as
[`SKILL.md › Delegating`](skills/dont-make-me-read/SKILL.md#delegating) says, so its transcripts show
what the agents do.

| Assumption | Checked by | Last checked |
|---|---|---|
| A skill with `disable-model-invocation: false` is loaded on the model's judgment, from its description alone | step 1 of [`samples/README.md › How to use a case`](samples/README.md#how-to-use-a-case) | not yet |
| A skill that says it stays in force is still in force on the next response | step 2 of [`samples/README.md › How to use a case`](samples/README.md#how-to-use-a-case) | not yet |
| An agent's `skills` loads each skill it lists into the agent's session, and the agent can read that skill's references | [a review of this tree](#reviewing), in the agent's transcript | not yet |
| A model that has loaded a skill loads another skill the first one names, when told to | [a review of this tree](#reviewing), in the reviewing session's transcript | not yet |
| An agent's session starts without the conversation that started it | [a review of this tree](#reviewing), in the agent's transcript | not yet |
| An agent's `skills` cannot preload a skill with `disable-model-invocation: true` | [sub-agents](https://code.claude.com/docs/en/sub-agents) | 2026-10-30 |
| An agent with no `tools` has every tool, `Agent` and `Skill` included | [sub-agents](https://code.claude.com/docs/en/sub-agents) | 2026-10-30 |
| Chat on claude.ai loads a plugin's skills and skips its agents | [platform support](https://claude.com/docs/plugins/platform-support) | 2026-10-31 |
| Chat on claude.ai loads a skill whose frontmatter has fields only Claude Code reads, such as `user-invocable` | adding the marketplace on claude.ai, then asking a chat which skills it has from plugins | not yet |

A row that fails on re-check is a change to the skills or agents, not to this table.
