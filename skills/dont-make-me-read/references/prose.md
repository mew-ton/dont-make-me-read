# Prose

How to write prose under the rules in `SKILL.md`: a paragraph of a document, an issue, a review
comment, a commit message, a comment in code. What the words mean, with instances, is the
skill `dont-make-me-read--glossary`.

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
