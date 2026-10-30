# Architecture

## Under its own rules

This tree is written under the rules in
[`skills/dont-make-me-read/SKILL.md`](skills/dont-make-me-read/SKILL.md). Contribute to it the way
that skill says to write anything.

The skill is meant to load while you do. Whether it does is a row of
[`README.md › What it relies on Claude Code for`](README.md#what-it-relies-on-claude-code-for).

## What check.sh checks

[`scripts/check.sh`](scripts/check.sh) checks the form of the tree, as its header lists. Whether
what the tree says holds together is not its job; that is the job of *Reviewing*.

The sizes of `SKILL.md` and the references are not capped. They are recorded in
`scripts/sizes.snapshot`, and a change to one is recorded with `bash scripts/check.sh --update`, so
a change shows in its diff how much each read grows.

Nothing runs the script for you. Run `bash scripts/check.sh` before proposing a change.

## Reviewing

A review finds in the graph of claims the findings
[`analysis.md › Reporting`](skills/dont-make-me-read/references/analysis.md#reporting) names, and
nothing else.

### Scope

- The skill, its references, and this tree's own documents: `README.md`, this file,
  `samples/README.md`, and the comments in `scripts/check.sh`. Every claim in them is in scope.
- Each case in `samples/`, on its own. Three questions only: does the Good fix what *What is wrong*
  names; does the Good bring in a finding of its own; do the graph and *Why* match the case's files.
- Out of scope: the logic of sample code, agreement between cases, and anything a judgment does not
  name. The code in a case has no owner; it is there to carry the case's graph.

### Steps

The steps in [`analysis.md › Steps`](skills/dont-make-me-read/references/analysis.md#steps), over
the scope above, reported as
[`analysis.md › Reporting`](skills/dont-make-me-read/references/analysis.md#reporting) says.

### When it is done

A review is done when its scope has no finding. The next review takes as its scope only the claims
a change touched and the claims with an edge to them.
