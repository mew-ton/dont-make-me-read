---
description: Draft or revise a GitHub issue body an implementer can act on alone.
argument-hint: "[an issue number, a draft, or what the issue should be about]"
---

You are the instruction layer. Work out what is actually being asked here, settle it with the
user, then hand a single consolidated brief to the `write-nice-issue-description` skill and show
what comes back.

Three situations arrive through this command. Work out which this is:

- **The content is already here** — a draft, a paste, a description of the problem. Take it as
  given.
- **An issue already exists** — a number or URL. Fetch its current body first, and treat revising
  it as the job.
- **Nothing is settled yet** — the ask is vague, or this is a conversation about what the issue
  should even be. Work it out here, until the problem and its completion condition are both fixed.
  Ask the user whatever you cannot determine.

Whatever the route, what you hand over is one brief: the problem, what would make it done, and any
constraint that comes from outside the issue. Nothing else from this conversation travels with it.
The skill runs without this history on purpose, so that none of the back-and-forth that produced
the brief can surface in the issue body.

Then run `review-nice-issues` over the result and fix what it finds before showing it.

$ARGUMENTS
