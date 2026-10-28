# Samples

One file per case. Each case is a few files shown as code blocks, the graph of explanations they
form, what is wrong with it, and what the rule in
[`skills/dont-make-me-read/SKILL.md`](../skills/dont-make-me-read/SKILL.md) says to do. The files
are not on disk, so nothing here runs; the case is the graph.

## How to use a case

Hand an agent the code blocks of one case, without the rest of the file, and ask:

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
| [09 A PRD and an interface that contradict](09-prd-contradicts-interface.md) | two sources, no declared direction |
| [10 A limit set in two places](10-ambient-state.md) | hidden edge, second place |
| [11 A hook only tests use](11-test-only-hook.md) | reversed edge |
| [12 Setup that runs by position](12-test-setup-by-position.md) | hidden edge |
| [13 Three tests, one claim](13-three-tests-one-claim.md) | duplicate nodes, no claim |
| [14 A menu of fixes](14-menu-of-fixes.md) | noise |
| [15 "The issue QA reported"](15-by-role-not-address.md) | hidden edge by role |
| [16 A comment that restates the body](16-comment-restates-body.md) | duplicate node |
| [17 An issue that designs the fix](17-issue-designs-the-fix.md) | design the problem did not require |
| [18 A TODO that outlived its fix](18-todo-that-outlived-its-fix.md) | stale derived explanation |
