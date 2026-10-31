---
name: dont-make-me-read
description: >
  Keeps what a reader has to gather before they can act as small as it can be, and in one place.
  Applies whenever writing, changing or reviewing prose or code that someone else, a person or an
  agent, reads in order to act: an issue, a review comment, a doc, a commit message, a declaration,
  a test. Does not apply to text nobody acts on later: a chat reply, a scratch note.
user-invocable: false
disable-model-invocation: false
---

## What the reader pays

The cost of writing is everything the reader has to reach, from where they landed, before they can
act: the paragraph in front of them and every paragraph it leans on. The writer cannot feel that
cost, because they read their own draft while supplying what it leaves out.

## The unit

A paragraph makes one claim, under an address other paragraphs can name it by.

## Words

What *paragraph*, *claim* and *address* mean, with the rest of the words these rules use, is the
skill `dont-make-me-read--glossary`, and what the judgments mean is the skill
`dont-make-me-read--judge`: load both before writing or reviewing under these rules.

## Rules

1. **One claim per paragraph, under an address.** Two claims in one paragraph cannot be named,
   cited or corrected apart.
2. **Everything in it changes what the reader does next.** What does not, goes: the reader pays to
   read it and acts no differently.
3. **A dependency is named by address.** A path, a heading, a name. Never "above", "as discussed",
   or a state the body uses without naming: for the reader who arrives by search, those are gone.
4. **A claim that has an owner is cited, not restated.** Restate only the part this reader needs
   in order to act, in the owner's words, and name the owner.
5. **Depend only on what you explain, reproduce or use, and converge.** Whether a dependency
   converges or diverges is as the skill `dont-make-me-read--judge` defines it.
6. **The derived names its source, and the source does not name it.** Say whether you explain or
   reproduce it, and keep its words: the reverse direction comes from an index, backlinks or search.
7. **A claim has one place.** The narrowest scope that holds every reproduction and every reader,
   set by the structure of the code or by the project's own instructions. If no place is set for
   this kind of claim, say so and stop rather than make a second one.

## Which file to read

| Writing or reviewing | Read |
|---|---|
| prose: a paragraph, a comment, a message | [`references/prose.md`](references/prose.md) |
| a program: a declaration, a test | [`references/program.md`](references/program.md) |

## Analysis

How to find the claims in what you are writing or reviewing, the edges between them, and what is
wrong with them, in prose and in a program alike. Each step from 1 on is a skill of its own, run
as *Delegating* says on what the steps before it produced.

### Steps

0. **Set the scope and the readers.** The task sets where to start: the claims a diff touches, one
   document, a whole tree. A diff touches a claim when one of its hunks shares a line with the
   claim's location or its address's location, as *Location* in `dont-make-me-read--glossary`
   defines one, in the file as the diff leaves it; step 1 runs over each file the diff touches, and
   a claim it finds there that the diff does not touch is out of scope. The readers are as *Reader*
   in `dont-make-me-read--glossary` defines them. A claim nothing depends on and nobody reads is
   not a starting point.
1. **Cut into claims.** Run `dont-make-me-read--extract-claims` over the scope.
2. **List what each claim depends on.** Run `dont-make-me-read--extract-dependencies` on each claim
   of the records, an address included. Follow a dependency further only while a change to it would
   still mean checking the starting claim again: run steps 1 and 2 on where it is. How far that goes
   is the task's to decide.
3. **List what depends on each claim.** Run `dont-make-me-read--extract-dependents` on each claim
   of the records of step 1, and on each claim a diff in the scope removed, by the words it had.
   Each dependent found is one more edge into the scope, from a claim step 1 did not cut: these are
   the edges rule 6 leaves to search.
4. **Judge the graph.** Run `dont-make-me-read--judge` on the records of steps 1 to 3, for the
   readers set in step 0.

### Delegating

A step whose skill has an agent of the same name runs in that agent when the scope set in step 0
is more than the text you are writing and is on disk, where the agent can read it: one session for
each thing the skill's *What it does* says it takes, as many at once as can run. Otherwise, and for
a step with no such agent, load the skill and run it yourself.

The task given to a session names that thing and nothing else. It carries none of the conversation,
so the session reads that thing as a reader who lands on it by search does.

A record is checked as its skill's *Record* says before it is used, and a record that fails is run
again.

### Reporting

A finding is a judgment other than visible, converging and reversed, as `dont-make-me-read--judge`
defines them: those say how an edge runs and leave nothing to fix on their own. Every finding is a
signal to fix, not a bug in itself: whether to fix it, and how, is for the people who own the text
to decide. Report each finding with the address it sits at, the judgment, and the rule it breaks.

## Persistence

In force from the response that loaded it onward, and while unsure whether what you are
writing or reviewing is read in order to act. Released when the work turns to what nobody acts on,
or when told.
