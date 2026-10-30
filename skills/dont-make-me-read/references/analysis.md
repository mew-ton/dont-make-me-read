# Analysis

How to find the claims in what you are writing or reviewing, the edges between them, and what is
wrong with them, in prose and in a program alike. The words are as `glossary.md` defines them, and
each word a step judges by, the judgments included, has instances there under its heading, in
prose and in a program: read them before judging, and judge a new case by the instance nearest it.

## Steps

0. **Set the scope and the readers.** The task sets where to start: the claims a diff touches, one
   document, a whole tree. A claim's readers are the people and agents who can open the place it
   sits in. A claim nothing depends on and nobody reads is not a starting point.
1. **Cut into claims.** Ask whether a part can be cited or rewritten on its own. If it can, it is a
   claim of its own, and the unit that held both is two claims.
2. **List what each claim depends on.** Ask what change elsewhere would mean checking this claim
   again. Look for a word or an identifier it uses and does not define, a value or a behaviour
   whose owner is elsewhere, the reason it holds, and a word that points by position, by role or at
   a conversation. Follow a dependency further only while a change to it would still mean checking
   the starting claim again; how far that goes is the task's to decide.
3. **Check that each edge can be followed.** It is visible or missing.
4. **Check what a claim holds of what it depends on.** Where it restates part of it, the two agree,
   or the edge is a contradiction. Where it holds nothing they do not, it is a duplicate.
5. **Check what adding one more does.** Ask which existing claims have to be rewritten to add
   another claim like this one, a planned one included. The edges from those to it diverge; the
   others converge.
6. **Check what each claim changes.** One that changes nothing its reader does next is noise.

## Reporting

A finding is a judgment other than visible, converging and reversed, which say how an edge runs
and are not defects on their own. Report each finding with the address it sits at, the judgment,
and the rule in `SKILL.md` it breaks.
