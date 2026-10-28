# Samples

One file per case, in two halves. **Bad** shows the files as code blocks, each labelled `**Bad**`
with its path or URL, then the graph of explanations they form and what is wrong with it. **Good**
shows the files that have a correction, each labelled `**Good**`, then why, naming the rule in
[`skills/dont-make-me-read/SKILL.md`](../skills/dont-make-me-read/SKILL.md). A file that did not
change is not shown again, and a case whose correction depends on a decision it does not make
says so instead of showing one. The files are not
on disk, so nothing here runs; the case is the graph.

## How to use a case

Hand an agent the **Bad** blocks of one case, without the rest of the file, and ask:

> List the explanations in these files as nodes, each by its address. List every edge between
> them with its direction, and say whether it is visible, hidden, missing or pointing the wrong
> way. Then say what is wrong.

Run it with the plugin installed and without, and compare each run to the case's graph. A finding
that appears only with the plugin is one the skill reached.

## Cases

| Case | Pathology |
|---|---|
| [01 A copy that went stale](01-stale-copy.md) | duplicate node |
| [02 "See the section below"](02-reading-order.md) | hidden edge by position |
| [03 "As discussed in standup"](03-dangling-discussion.md) | dangling edge |
| [04 A report retold in other words](04-translation-without-quote.md) | translation without the quote |
| [05 An observation that guesses its cause](05-observation-guesses-cause.md) | reversed edge |
| [06 A decision that names its implementation](06-decision-names-implementation.md) | reversed edge, missing edge |
| [07 A callee that knows its caller](07-callee-knows-caller.md) | reversed edge |
| [08 A doc comment that describes the caller](08-jsdoc-describes-caller.md) | reversed edge |
| [09 A PRD and an interface that contradict](09-prd-contradicts-interface.md) | a reproduction that contradicts its source |
| [10 A precedence stated nowhere](10-ambient-state.md) | a claim with no address |
| [11 State the interface does not declare](11-test-only-hook.md) | hidden edge |
| [12 A default that hides the claim](12-test-setup-by-position.md) | a visible edge carrying the whole claim |
| [13 Three tests, one claim](13-three-tests-one-claim.md) | duplicate nodes, no claim |
| [14 A menu of fixes](14-menu-of-fixes.md) | noise |
| [15 "The issue QA reported"](15-by-role-not-address.md) | hidden edge by role |
| [16 A comment that restates the body](16-comment-restates-body.md) | duplicate node |
| [17 An issue that designs the fix](17-issue-designs-the-fix.md) | design the problem did not require |
| [18 A TODO that outlived its fix](18-todo-that-outlived-its-fix.md) | stale derived explanation |
