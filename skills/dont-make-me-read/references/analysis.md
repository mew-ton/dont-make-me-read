# Analysis

How to find the claims in what you are writing or reviewing, the edges between them, and what is
wrong with them, in prose and in a program alike. The words are as `glossary.md` defines them, and
each word a step judges by, the judgments included, has instances there under its heading, in
prose and in a program: read them before judging, and judge a new case by the instance nearest it.

## Steps

0. **Set the scope and the readers.** The task sets where to start: the claims a diff touches, one
   document, a whole tree. A claim's readers are the people and agents who can open the place it
   sits in. A claim nothing depends on and nobody reads is not a starting point.
1. **Cut into claims.** One file at a time, as the skill `dont-make-me-read--extract-claims` says.
2. **List what each claim depends on.** One claim at a time, as the skill
   `dont-make-me-read--extract-dependencies` says. Follow a dependency further only while a change
   to it would still mean checking the starting claim again: cut the file it is in, then list what
   it depends on. How far that goes is the task's to decide.
3. **Check that each edge can be followed.** It is visible or missing.
4. **Check what a claim holds of what it depends on.** Where it restates part of it, the two agree,
   or the edge is a contradiction. Where it holds nothing they do not, or says of one of them
   nothing another claim depending on it does not already say, it is a duplicate.
5. **Check what adding one more does.** Ask which existing claims have to be rewritten to add
   another claim like this one, a planned one included. The edges from those to it diverge; the
   others converge.
6. **Check what each claim changes.** One that changes nothing its reader does next is noise.

## Delegating

Steps 1 and 2 each have an agent named as its skill is, which runs the skill in a session of its
own and answers with the skill's record. Use them when the scope set in step 0 is more than the
text you are writing: one session per file for step 1, one per claim for step 2, as many at once
as can run. Otherwise run the skill yourself.

The task given to a session names its unit and nothing else: a file's path for step 1, a claim's
`at` for step 2. It carries none of the conversation, so the session reads the unit as a reader
who lands on it by search does.

A record is checked before it is used: it parses as JSON with the fields its skill's *Record*
lists, and for step 1 every non-blank line of the file is in exactly one claim, one address or one
`uncovered` range. A record that fails is run again.

## Reporting

A finding is a judgment other than visible, converging and reversed, which say how an edge runs
and leave nothing to fix on their own. Every finding is a signal to fix, not a bug in itself:
whether to fix it, and how, is for the people who own the text to decide. Report each finding with
the address it sits at, the judgment, and the rule in `SKILL.md` it breaks.
