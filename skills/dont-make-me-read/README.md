# dont-make-me-read

Holds any writing down to the range a reader has to hold in their head before they know
what to do — and stays in force while you write, because the writer is the one person who
cannot feel that range.

It is the foundation the rest of this plugin sharpens: every other skill here applies this
test to one artifact, and cites it rather than restating it.

It does not judge style, length, or tone, and it does not decide what an artifact should
contain — the skill that owns that artifact does.

## The way in

Install the plugin as the [root README](../../README.md) describes. There is nothing to
type: this skill is model-invoked, it fires on any writing task, and it stays in force for
the rest of that task rather than for the one response that loaded it.

## Where the rest lives

`SKILL.md` holds the range, how to apply it, and the guard against skipping it. The
artifact-specific skills beside it — a README, an architecture doc, an issue body, a
`SKILL.md`, a code comment — each name this one and narrow it to what their reader is
deciding.

## The two propositions

Nothing loads this file: it is not referenced from `SKILL.md`, so it costs the agent no
context. What follows is why the skill exists, for whoever maintains it.

Every rule in this plugin follows from them.

1. **Nobody wants to hold a lot in their head to work out what to do.** Not for
   beautiful text, not for thorough text, not for polite text.
2. **The writer cannot tell how much that is.** You read your own draft while
   supplying the context it is missing, so the range reads small to you, and only to
   you.

## Why these are skills and not advice

The second proposition is the whole reason. Advice is taken by someone who can already
see the problem, and the writer cannot see this one — the draft reads fine to them, and
will go on reading fine however long they look at it.

So the judgment has to arrive from outside the moment of writing. That is what makes it
a skill that fires mid-task rather than a style guide somebody consults, and it is why
several of these skills exist only to be run against text that is already written.

## Why the operative half is in the guard, not here

`SKILL.md` keeps "you are supplying the intent the text is missing as you read it" in
its Common Rationalizations, because there it refutes the excuse at the moment the
agent reaches for it. Stated here as a proposition it would be read once and agreed
with, which is not the same thing as being applied.
