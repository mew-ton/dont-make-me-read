# Writing the description

Read this when writing or revising a skill's `description`, or when judging whether an existing
one will fire.

A skill's `name` and `description` are all the agent has when it decides whether to fire: the body
is not in context yet, so the `description` has to be judge-able on its own.

## Principles

**DO**

- **Write it in the third person**, as `Writes and revises a README`. It is injected into the
  system prompt, where a point of view that shifts between skills costs accuracy in choosing among
  them.
- **Write it in English**, whatever language the body and the skill's output are in. English terms
  are the ones that survive into a prompt whatever language it is typed in, and a skill other
  people install cannot know which language its users type. A skill that will never leave one team
  may add the phrases that team really types.
- **Keep it inside 1024 characters** — the field's own limit, so it is enforced rather than
  advisory. If the parts below will not fit, the skill's scope is too wide.

**DON'T**

- **Summarise the skill's implementation** — the steps, the criteria it applies, and the argument
  the body makes for each: why the rule is right, what ignoring it costs, what the alternatives
  were. Put them here and the agent reads them as the skill, skipping the body it took them from.
- **Explain concepts that are not this skill's** — what a callee is, what a pull request is, why
  coupling costs anything. Noise: the agent knows, and the characters come out of the intent.
- **Name another skill.** The name is a dependency on somebody else's file: it goes wrong the day
  they rename it, and nothing checks that. It also answers "is *this* artifact the skill's?" for
  the agent, which is the question the description exists to make it ask — for example,
  `Does not apply when the artifact is an architecture doc (that is write-nice-architecture-docs)`.
- **Write a tag list or a keyword-stuffed sentence.** `Skill / SKILL.md / description —` matches
  nothing anyone types.
- **Put an angle bracket in the description's text.** `<` and `>` are rejected outright there, so a
  description carrying a tag or a `<placeholder>` does not load at all. The `>` that opens a YAML
  folded block is part of the frontmatter, not of the text, and is fine.
- **Say that the skill stays in force.** What keeps it in force is the body's `## Persistence`, and
  this reader is deciding whether to load the body at all. The clause spends characters on what
  happens after the only judgment the description is read for.

## The description's shape

```text
<the occasion, or Forces …>
<the intent>
Applies to|when <the occasion>               — where `Forces …` opened it
Also applies when another skill needs …     — where another skill needs these rules
Does not apply …                            — where the occasion sweeps something in
```

**Does the work name the artifact?**

**It does → open with the occasion.** The work says the word and the word fires the skill. For
example, an issue, a README, an `ARCHITECTURE.md`, a `SKILL.md`. Here the opening *is* the
occasion, and the bound closes it:

```text
Runs a determinacy-and-duplication pass over the text of a GitHub issue body
that is already written — someone else's, or the author's own draft. Does not
apply as a general-purpose "review this issue" entry point, when the issue is
still being written or revised, or when what is wanted is a judgement of
repo-groundedness, dependency closure, or scope.
```

**It does not → open with what the skill forces**, as `Forces …`: the thing it insists on, and,
where there is one, the thing that thing displaces. Nothing in the work names a rule like this: a
prompt asks for a feature, a diff shows a function, and neither says which rule applies — so the
occasion cannot open it, and an occasion nobody names is one the agent forgets mid-diff. What the
work *does* supply is the shape the rule catches, and the words it uses for that shape go in the
opening's own examples:

```text
Forces the text a stranger can go and check: the rationale a reader who was
never in the room can still trace, never the conversation that produced it, the
review feedback, the discarded alternatives, or a past state the current code
no longer shows. Applies when writing an issue, a PR description, a code
comment, an API or design doc, or any text or code that will be read later.
Does not apply when the material is reachable and what it costs is the trip to
it, when the question is an issue body's sections and criteria, or when the text
is an ephemeral chat reply or a working note.
```

## The leading word

The word the description shares with whatever the agent is working from — a prompt, or, for a
skill that fires mid-task with no prompt, the work itself. It is what fires the skill. Put it at
the start when something in the prompt or the work names the artifact, and inside the opening's own
examples when nothing names it.

- **Real words**: the terms that show up in your prompts, docs, and code.
- **One word per branch the description must fire on cold**: a second near-synonym for one of those
  is duplication, and a branch reached only after the skill has loaded is gated inside it rather
  than named here. Which branches are this skill's at all is settled before the description is
  written.
- **Survives translation**: a file name, a tool name, a term of art typed as-is — for example,
  `SKILL.md`, `issue`, `PR`.

## Intent

What the skill's author wanted enforced, in one clause and in their terms — for example, `keeps a
callee from branching on which caller invoked it`. A verb that already carries it needs no separate
clause: `Writes and revises a README` is the intent.

## Occasion

The artifact being written, or the activity underway. It opens the description where the work names
it, and follows the `Forces …` clause where it does not. `Applies` is the fixed word there; the
preposition is whatever the occasion itself takes — `Applies when writing an issue`, `Applies to
any coding task`.

## Bound

`Does not apply …`, in the same person and opening the same way every time — written where the
occasion sweeps in something it should not. What it takes back is a neighbouring artifact the
occasion really does reach, a mode of use that is somebody else's entry point, a case inside the
occasion that belongs to someone else, or a case where the rule has no purchase at all.

An occasion narrow enough to sweep in nothing needs no bound: artifacts it never reached are a
routing table in prose, and the reader pays for each one.

## Reach clause

`Also applies when another skill needs …`, naming the need rather than the skill. It admits a second
way in, for the skill that needs these rules and would otherwise have to name this one.

## The description and the body serve different readers

The `description` is material for one judgment — whether to fire. The body explains the skill to
whoever has to act once it has. Their purposes differ, so where they say the same thing the overlap
is intended: cutting either because the other carries it leaves one of the two readers short.

What overlaps is what the skill is for and what occasions it — the two the firing judgment runs on.
The body's opening restates the first always; the occasion gets its own short section where being
in scope is not obvious from the description alone. The steps, the criteria and the argument stay
in the body alone, because an agent handed those has what it needs to act and stops there.

## Measuring whether it fires

Whether a skill is reached is its own measurement. Write the cases that should reach it — a handful
of prompts a user would really send — and run them against the models it will run under, first with
the skill installed and then without, so you can tell a case its `description` reached from one the
model would have handled anyway. For a skill nothing in a prompt names, the cases are the work
itself — a diff, a draft, a file — and the comparison is the same. A skill the cases do not reach
has a `description` problem, and rewriting the body does not touch it.
