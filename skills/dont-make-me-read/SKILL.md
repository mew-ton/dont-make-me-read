---
name: dont-make-me-read
description: >
  Keeps what a reader has to gather before they can act as small as it can be, and in one place.
  Applies while writing or changing anything someone else, a person or an agent, reads in order to
  act: code with its comments and tests, a doc, a commit message, an issue, a pull request
  description, a review comment. Runs a paragraph or a declaration at a time, as each is written,
  not once the whole is done. Does not apply to text nobody acts on later: a chat reply, a scratch
  note.
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
5. **Depend only on what you explain, reproduce or use, and converge.** Any other dependency is
   one more change that means checking this claim again, for nothing it gives the reader. Whether a
   dependency converges or diverges is as the skill `dont-make-me-read--judge` defines it.
6. **The derived names its source, and the source does not name it.** Say whether you explain,
   reproduce or use it, and keep its words: the reverse direction comes from an index, backlinks or
   search.
7. **A claim has one place.** The narrowest scope that holds every reproduction and every reader,
   set by the structure of the code or by the project's own instructions, which include what the
   project's `ARCHITECTURE.md` says each part of it is for. A link's label, or what a file already
   holds, sets none. If no place is set for this kind of claim, say so and stop rather than make a
   second one.

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

0. **Set the scope and the readers.** The scope is the paragraph or declaration being written or
   changed, and steps 1 to 4 run on it before the next one is written. A review sets its scope as
   the skill `dont-make-me-read--review` says. The readers are as *Reader* in
   `dont-make-me-read--glossary` defines them. A claim nothing depends on and nobody reads is not a
   starting point.
1. **Cut into claims.** Run `dont-make-me-read--extract-claims` over the scope.
2. **List what each claim depends on.** Run `dont-make-me-read--extract-dependencies` on each claim
   of the records, an address included. Follow a dependency further only while a change to it would
   still mean checking the starting claim again: run steps 1 and 2 on where it is. How far that goes
   is the task's to decide.
3. **List what depends on each claim.** Run `dont-make-me-read--extract-dependents` on each claim
   of the records of step 1 and on each claim the change removed, by the words it had. Each
   dependent found is an edge into that claim, wherever the dependent is: these are the edges rule
   6 leaves to search.
4. **Judge the graph.** Run `dont-make-me-read--judge` on the records of steps 1 to 3, for the
   readers set in step 0.

### Delegating

Steps 2 and 3 run in their agents once the scope is on disk, where an agent can read it: one
session for each claim, as many at once as can run. Steps 1 and 4, and a step whose scope is not on
disk yet, are run in your own session: load the step's skill and run it yourself.

The task given to a session names its claims and nothing else. It carries none of the conversation,
so the session reads them as a reader who lands on them by search does.

A record is checked as its skill's *Record* says before it is used, and a record that fails is run
again.

### Reporting

A finding is a judgment other than visible, converging and reversed, as `dont-make-me-read--judge`
defines them: those say how an edge runs and leave nothing to fix on their own. Every finding is a
signal to fix, not a bug in itself: whether to fix it, and how, is for the people who own the text
to decide.

While writing, a finding is fixed before the text is sent, and one whose fix is in a text the
writer does not own is one line in the conversation, with its address. Where a review's report goes
is the skill `dont-make-me-read--review`'s to say.

### What to do instead

What to do instead of each finding is the rule it breaks and, where one says how, a section of the
files *Which file to read* names:

| Finding | Rule | How to write it instead |
|---|---|---|
| missing | 3 | put what it leans on where its readers can open it, if it is not there already, and name it by an address: *Citing* in `references/prose.md`; *Saying which you are* in `references/program.md` |
| contradiction | 4 | *Citing* in `references/prose.md`; which side is right is the owner's to say |
| diverging | 5 and 6 | *Saying which you are* in each file; *Placement* and *Direction* in `references/program.md` |
| duplicate | 4 | *Citing* in `references/prose.md`: the owner's copy stays, the other cites it or goes |
| two claims | 1 | one paragraph for each, under its own address |
| noise | 2 | it goes |

## Persistence

In force from the response that loaded it onward, and while unsure whether what you are
writing or reviewing is read in order to act. Released when the work turns to what nobody acts on,
or when told.
