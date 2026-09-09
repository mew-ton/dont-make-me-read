---
description: Audit an issue body — could an implementer act on it without asking for more?
argument-hint: "[issue number or URL, or the body text itself]"
---

If an issue number or URL is given, fetch the body first. Then hand the body text — and nothing
else — to the `review-nice-issues` skill.

That skill judges from the same text a reader holds, so fetching is this command's job and nothing
you know beyond the body may reach it. Fetch before you hand over: once that skill has run, this
turn cannot fetch either.

$ARGUMENTS
