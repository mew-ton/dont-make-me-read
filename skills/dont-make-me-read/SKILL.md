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
act: the paragraph in front of them and every paragraph it leans on. The
writer cannot feel that cost, because they read their own draft while supplying what it leaves out.

## The unit

A paragraph makes one claim and carries its explanation. It has an address other paragraphs can
name: a heading in prose, a name in a program. What those words mean in the thing you are writing
is in the file the table below names.

## Rules

1. **One claim per paragraph, under an address.** Two claims in one paragraph cannot be named,
   cited or corrected apart.
2. **Everything in it changes what the reader does next.** What does not, goes.
3. **A dependency is named by address.** A path, a heading, a name. Never "above", "as discussed",
   or a state the body uses without naming: for the reader who arrives by search, those are gone.
4. **A claim that has an owner is cited, not restated.** Restate only the part this reader needs
   in order to act, in the owner's words, and name the owner.
5. **Depend only on what you explain or reproduce.** Never on what explains or reproduces you, and
   say which you are. The reverse direction comes from an index, backlinks or search, so keep the
   source's words.
6. **A claim has one place.** The narrowest scope that holds every reproduction and every reader,
   set by the structure of the code or by the project's own instructions. If no place is set for
   this kind of claim, say so and stop rather than make a second one.

## Which file to read

| Writing or reviewing | Read |
|---|---|
| prose: a paragraph, a comment, a message | [`references/prose.md`](references/prose.md) |
| a program: a declaration, a test | [`references/program.md`](references/program.md) |

## Persistence

In force for every response after the one that loaded it, and while unsure whether what you are
writing or reviewing is read in order to act. Released when the work turns to what nobody acts on, or when told.
