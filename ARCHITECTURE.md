# Architecture

## Under its own rules

This tree is written under the rules in
[`skills/dont-make-me-read/SKILL.md`](skills/dont-make-me-read/SKILL.md). Contribute to it the way
that skill says to write anything.

## What each part is for

| Path | What it is, and for whom |
|---|---|
| `README.md` | the plugin's front page, for someone deciding whether to install it, and then using it |
| `ARCHITECTURE.md` | how this tree is made, for an agent or person changing it |
| `skills/` | the plugin's skills, for the model the plugin runs in |
| `agents/` | the agents that run a step of an analysis in a session of its own, for Claude Code |
| `commands/` | the plugin's slash commands, for someone typing one |
| `samples/` | cases to check the skills against, for whoever checks that the skills still work |
| `scripts/` | the check of the tree's form, for an agent or person changing the tree |
| `.claude-plugin/` | the plugin's manifest, for Claude Code and the marketplace |
| `.github/workflows/` | the version check and the release, for GitHub |
| `LICENSE` | the terms of use, for anyone using or copying the tree |

## What check.sh checks

[`scripts/check.sh`](scripts/check.sh) checks the form of the tree, as its header lists. Whether
what the tree says holds together is not its job; that is the job of *Reviewing*.

How the sizes are recorded is the comment on `snapshot` in `scripts/check.sh`.

Nothing runs the script for you. Run `bash scripts/check.sh` before proposing a change.

## Releasing

Every pull request is a release: it changes `version` in
[`.claude-plugin/plugin.json`](.claude-plugin/plugin.json) to one that is not tagged yet. One that
does not is not merged.

[`.github/workflows/version.yml`](.github/workflows/version.yml) fails on a pull request to `main`
that does not, as its steps say. It blocks the merge where the branch protection of `main` requires
its check, `version`.

Once it is on `main`, [`.github/workflows/release.yml`](.github/workflows/release.yml) tags and
publishes it, as its steps say.

## Reviewing

A review finds in the graph of claims the findings
[`SKILL.md › Reporting`](skills/dont-make-me-read/SKILL.md#reporting) names.

### Scope

- The skills, the references, the agents, the commands, and this tree's own documents:
  `README.md`, this file, `samples/README.md`, and the comments in `scripts/check.sh`. Every claim
  in them is in scope.
- Each case in `samples/`, on its own. Three questions only: does the Good fix what *What is wrong*
  names; does the Good bring in a finding of its own; do the graph and *Why* match the case's files.
- Out of scope: the logic of sample code, agreement between cases, and anything a judgment does not
  name. The code in a case has no owner; it is there to carry the case's graph.

### Steps

The steps in [`SKILL.md › Steps`](skills/dont-make-me-read/SKILL.md#steps), over *Scope*, run
and reported as [`dont-make-me-read--review`](skills/dont-make-me-read--review/SKILL.md) says.

### When it is done

A review is done when its scope has no finding. The next review takes as its scope only the claims
a change touched and the claims with an edge to them.
