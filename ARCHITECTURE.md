# Architecture

## Under its own rules

This tree is written under the rules in
[`skills/dont-make-me-read/SKILL.md`](skills/dont-make-me-read/SKILL.md). Contribute to it the way
that skill says to write anything.

## What check.sh checks

[`scripts/check.sh`](scripts/check.sh) checks the form of the tree, as its header lists. Whether
what the tree says holds together is not its job; that is the job of *Reviewing*.

How the sizes are recorded is the comment on `snapshot` in `scripts/check.sh`.

Nothing runs the script for you. Run `bash scripts/check.sh` before proposing a change.

## Trying a checkout

To load a checkout without installing it:

```bash
git clone https://github.com/mew-ton/dont-make-me-read.git
claude --plugin-dir ./dont-make-me-read
```

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

### When it is done

A review is done when its scope has no finding. The next review takes as its scope only the claims
a change touched and the claims with an edge to them.
