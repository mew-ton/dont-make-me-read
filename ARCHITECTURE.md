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

The size limits are stated in `scripts/check.sh` and nowhere else.

Nothing runs the script for you. Run `bash scripts/check.sh` before proposing a change.

## Reviewing

A review finds defects in the graph of claims, and nothing else. A finding is one of the judgments
in
[`glossary.md › Edge judgments`](skills/dont-make-me-read/references/glossary.md#edge-judgments)
and
[`glossary.md › Node judgments`](skills/dont-make-me-read/references/glossary.md#node-judgments)
other than *visible* and a *converging* reversed edge.

### Scope

- The skill, its references, and this tree's own documents: `README.md`, this file,
  `samples/README.md`, and the comments in `scripts/check.sh`. Every claim in them is in scope.
- Each case in `samples/`, on its own. Three questions only: does the Good fix what *What is wrong*
  names; does the Good bring in a defect of its own; do the graph and *Why* match the case's files.
- Out of scope: the logic of sample code, agreement between cases, and anything a judgment does not
  name. The code in a case has no owner; it is there to carry the case's graph.

### Steps

1. List the claims in scope as nodes, each by its address, and say whether it is a source or what
   it is derived from.
2. List the edges between them with their direction, and judge each edge and each node.
3. Report each judgment other than *visible*, with the address it sits at and the rule in
   `SKILL.md` it breaks.

### When it is done

A review is done when its scope has no finding. The next review takes as its scope only the claims
a change touched and the claims with an edge to them.
