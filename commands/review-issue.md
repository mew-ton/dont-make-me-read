---
description: Audit an issue body — could an implementer act on it without asking for more?
argument-hint: "[issue number or URL, or the body text itself]"
---

If an issue number or URL is given, fetch the body first. Then hand the body text — and nothing
else — to the `review-nice-issues` skill.

That skill takes its own outward-looking tools away while it judges, so it holds the same text a
reader holds and nothing more. Fetch before you hand over: the removal is released by the user's
next message, so once that skill has run, nothing in this turn can read or fetch either. Nothing
you know beyond the body may reach it.

$ARGUMENTS
