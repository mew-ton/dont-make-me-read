# Writing the description

Read this when writing or revising a skill's `description`, or when judging whether an existing
one will fire.

A skill's `name` and `description` are all the agent has when it decides whether to fire:
the body is not in context yet. So the `description` has to be judge-able on its own, and
it must not carry the procedure the body holds.

## Contents

- DO
- DON'T
- The leading word
- Choosing the lead
- The description and the body serve different readers
- Measuring whether it fires

## DO

- **Write it in the third person**, as `Writes and revises a README`. It is injected into
  the system prompt, where a point of view that shifts between skills costs accuracy in
  choosing among them.
- **Show the intent the skill was created for** — what its author wanted enforced, in one
  clause and in their terms. For example, `keeps a callee from branching on which caller
  invoked it`.
- **Name the occasion**: the artifact being written, or the activity underway.
- **State when it must not fire** — the **bound** — as that occasion negated and in the same
  person: `Does not apply when …`, so the pair reads as one condition of use.
- **Write the `description` in English**, whatever language the body and the skill's output
  are in. English terms are the ones that survive into a prompt whatever language it is typed
  in, and a skill other people install cannot know which language its users type. A skill that
  will never leave one team may add the phrases that team really types.
- **Add a reach clause** where another skill will need the rules this one holds: "also applies
  when another skill needs …", naming the need rather than the skill.
- **Keep it inside 1024 characters, hard.** If the intent, the occasion and the bound will
  not fit, the skill is doing too much: split it rather than padding or truncating.

## DON'T

- **Summarise the skill's implementation** — the steps, the criteria it applies, and the
  argument the body makes for each: why the rule is right, what ignoring it costs, what the
  alternatives were. Put them here and the agent reads them as the skill, skipping the body it
  took them from. What the skill *forces* stays, since that is the intent, and so do the words
  the work itself uses, since those are what fires.
- **Explain concepts that are not this skill's** — what a callee is, what a pull request
  is, why coupling costs anything. Noise: the agent knows, and the characters come out of
  the intent.
- **Name another skill.** Wanting to name one usually means you are routing — telling the agent
  which skill owns what — and a routing table is the body's to hold, if anyone's, so the name
  carries the body out into the description. A name also reads as a routing table, which
  stops the agent asking whether *this* artifact is the skill's: for example,
  `DO NOT use for an architecture doc (that is write-nice-architecture-docs)`. A reach
  clause is the exception, since it names nobody: "also applies when another skill needs
  …".
- **Write a tag list or a keyword-stuffed sentence.** `Skill / SKILL.md / description —`
  matches nothing anyone types.
- **Put an angle bracket in the description's text.** `<` and `>` are rejected outright there,
  so a description carrying a tag or a `<placeholder>` does not load at all. The `>` that opens a
  YAML folded block is part of the frontmatter, not of the text, and is fine.

## The leading word

The skill fires on a word shared between the description and whatever the agent is working
from: a prompt, or — for a skill that fires mid-task with no prompt — the work itself. Put that word
near the start, where it does its invocation work.

- **Real words**: the terms that show up in your prompts, docs, and code.
- **One per branch**: synonyms that rename the same branch are duplication.
- **Survives translation**: a file name, a tool name, a term of art typed as-is — for
  example, `SKILL.md`, `issue`, `PR`.

## Choosing the lead

**Does the work name the artifact?**

**It does → lead with the occasion.** The work says the word and the word fires the skill.
For example, an issue, a README, an `ARCHITECTURE.md`, a `SKILL.md`. Here the lead *is* the
occasion, and the bound closes it:

```text
Writes and revises a README, including adding a section to one that already
exists. Does not apply when the artifact is an architecture doc, a SKILL.md,
an issue body, reference documentation, a tutorial, or a changelog.
```

**It does not → lead with what the skill forces**, opening `Forces …`: the thing it insists on,
and, where there is one, the thing that thing displaces. A rule that holds while
someone writes code or a comment has no word in the prompt to share, and an occasion nobody names
is one the agent forgets mid-diff. Here the lead comes first, then the occasion, then the bound:

```text
Forces the narrowest range a reader has to hold before they can act — the
range its writer cannot feel, since a writer reads their own draft while
supplying what it is missing, so it reads small to them and only to them.
Applies while writing or revising anything another person or an agent reads in
order to act: drafting, documenting, commenting, specifying, explaining,
reviewing, or writing the code itself, and it stays in force for the rest of
that work. Does not apply when nobody acts on the text later: chat replies,
scratchpads, working notes.
```

The occasion still follows, named as an activity — for example, "writing, revising, reviewing, or
designing code". The description names that activity; keeping the skill in force for the rest of
it is the body's job.

## The description and the body serve different readers

The `description` is material for one judgment — whether to fire. The body explains the
skill to whoever has to act once it has. Their purposes differ, so where they say the same
thing the overlap is intended: cutting either because the other carries it leaves one of
the two readers short.

What overlaps is what the skill is for and what occasions it — the two the firing judgment runs
on, and the two the body opens with. The steps, the criteria and the argument stay in the body
alone, because an agent handed those has what it needs to act and stops there.

## Measuring whether it fires

Whether a skill is reached is its own measurement. Write the cases that should reach it — a
handful of prompts a user would really send — and run them against the models it will run under,
first with the skill installed and then without, so you can tell a case its `description` reached
from one the model would have handled anyway. A skill the cases do not reach has a `description`
problem, and rewriting the body does not touch it.
