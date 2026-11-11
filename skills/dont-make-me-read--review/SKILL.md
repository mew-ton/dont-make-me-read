---
name: dont-make-me-read--review
description: >
  Reviews a path, a diff or a pull request under the rules of the skill dont-make-me-read, and
  reports where a reader will have to gather more than they need and what to write instead. Applies
  when asked to review such text, or when typed as /dont-make-me-read:review.
user-invocable: false
disable-model-invocation: false
---

## What it does

Runs *Analysis* in the skill `dont-make-me-read` over a scope the task names, rather than over the
paragraph being written, and reports what it finds. Load `dont-make-me-read` first, and the skills
its *Words* names.

## Scope

The scope is what the task names: a path, a diff, or a pull request; with nothing named, the
uncommitted change in the working tree. It takes the place of the scope that step 0 of *Steps* in
`dont-make-me-read` sets, and the readers are as that step says.

### What a diff touches

A diff touches a claim when one of its hunks adds or removes a line within the claim's location or
within its address's location, as *Location* in `dont-make-me-read--glossary` defines one, in the
file as the diff leaves it. Step 1 runs over each file the diff touches, and a claim it finds there
that the diff does not touch is out of scope.

## Delegating

Every step that has an agent runs in it once the scope is on disk. Step 1 takes one session for each
file in the scope. Steps 2 and 3 take one session for the claims under each address, and one for
the claims of a file that have no address, in place of one for each claim: a review's scope holds
many more claims than a paragraph does. The rest is as *Delegating* in `dont-make-me-read` says.

## Reporting

Report each finding with the address it sits at, the judgment, and the rule it breaks. What a
finding is, is *Reporting* in `dont-make-me-read`. Where the report goes is set by the scope:

- A pull request: one review comment per finding, on a line of its location the diff shows, as
  *Location* in `dont-make-me-read--glossary` defines one. A finding none of whose lines the diff
  shows goes in the review's body, with its address.
- A document, a tree, or a diff in no pull request, such as the uncommitted change: one list in the
  conversation, one line per finding, each with the address, the judgment and the rule.
