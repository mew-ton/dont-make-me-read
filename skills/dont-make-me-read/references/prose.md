# Prose

What the words in `SKILL.md` mean when what you are writing or reviewing is prose: a paragraph of
a document, an issue, a review comment, a commit message, a comment in code.

## The words

| In `SKILL.md` | In prose |
|---|---|
| paragraph | a paragraph; a list item or a table row stands alone the same way |
| claim | what the paragraph says, as one thing to cite or rewrite |
| address | the heading above it; for a comment in code, the name of the declaration it sits on |
| reader | a person reading from the top, and an agent landing on this paragraph by search |

Reading order is not an address. The agent arrives mid-document, so a paragraph that needs the one
before it leans on something that reader does not have.

## Edges

A visible edge is a path, a link, a heading named, or an identifier in backticks, leading to
something this paragraph's readers can open. The reader can follow it, and so can a script that
checks the target exists.

A missing edge (`glossary.md › Missing`) shows as any of these. Each is a red flag, and each
names what to do instead:

- "see above", "below", "the previous section": a position. Name the heading.
- "as discussed", "we originally went with", "not A but B": a past only the participants hold.
  Write down what was settled where the reader can open it, and name that.
- "as requested", "you said", an instruction with nothing in front of it: the conversation that
  produced this text, which its reader was not in. The same.
- "the config", "the usual way", "same as the other one": a thing named by its role. Name its
  address.
- a count, a name or a definition copied from the file that owns it, without naming that file.
  Name the owner.
- a sentence that only means something with another file open. Name the file.
- an address this paragraph's readers cannot open: a chat session, a private channel, a file on
  the writer's disk. Put the claim where they can open it, and name that.

## Saying which you are

A paragraph that explains something names it and says so: "This describes what `foo` does today."
A paragraph that something reproduces is the source, and it does not list what reproduces it: the
implementation cites the decision, the decision does not name its implementations. One clause
settles it. A reader of the decision who wants the code searches for the decision's words, which
the code carries.

## Citing

Name the owner by address, quote the words the reader needs in order to act, and only then
translate into the reader's vocabulary if it differs. Keep the quote: a translation on its own
cannot be searched for and cannot be checked against the owner.

One instance. A task tracked in another tool, written up as an issue for an agent:

> **Not this.** The whole task restated in the engineer's words, a guessed cause added, and from
> then on edited here while the tracker is not.
>
> **This.** "Task: `<tracker link>`. Reported as 'the screen freezes after saving' (QA report,
> `<report link>`). Reproduce by … Done when …". The parts the agent needs, in the reporters'
> words, each with its owner, so an edit to the substance goes to the owner.

## Placement

- A decision reproduced by one declaration, and read only by readers of that declaration, is that
  declaration's doc comment.
- A decision that readers reach from elsewhere too, an issue, another module, a product document,
  is in the narrowest document all of them reach, and each declaration's doc comment cites it.
- Which tool holds which kind of claim, an observation, a task, a decision, is set by the project's
  own instructions. Where they set nothing for this kind, rule 6 in `SKILL.md` applies.

## What noise does

The rationale, the constraint stated as the wall the reader would walk into, and the fact that
makes the ask defensible change what the reader does, so rule 2 keeps them: without them the reader
decides with less than you had. What rule 2 cuts is what makes a reader confident about the wrong
thing:

| Noise | What the reader concludes |
|---|---|
| a menu of fixes you could have weighed yourself | that the choice is theirs, to make with less information than you had |
| the paths you happened to sample, given as the fix | an agent: that those are the complete set to touch |
| "handle this appropriately" | that the spec is complete |
| the implementation method, in an issue | that the shape you saw while writing is still the shape today |
