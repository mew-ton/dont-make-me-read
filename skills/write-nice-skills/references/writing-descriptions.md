# Writing the description

The `description` is the only text loaded when the agent decides whether to fire the
skill. It must be judge-able on its own, and must not leak the procedure.

## DO

- **Write it in the imperative.** `Use this skill when …` — not `I check your issue for
  …`, not `you are an expert at …`. A subject appears only where leaving it out would make
  the sentence read as a description of the work.
- **Show the intent the skill was created for** — what its author wanted enforced, in one
  clause and in their terms. For example, `keeps a callee from branching on which caller
  invoked it`.
- **Name the occasion**: the artifact being written, or the activity underway.
- **State when it must not fire**, as that occasion negated: `DO NOT use this skill when
  …`. The pair then reads as one condition of use; in any other shape the bound reads as
  trivia.
- **Write it in English.** English terms are the ones that survive into a prompt whatever
  language it is typed in, and a published skill cannot know which its users type. This
  settles the description alone — the body's language and the skill's output are decided
  elsewhere.
- **Keep it inside 1024 characters, hard.** If the intent, the occasion and the bound will
  not fit, the skill is doing too much: split it rather than padding or truncating.

## DON'T

- **Summarise the skill's implementation** — the steps, the criteria it applies (for
  example, "a determinable problem, checkable acceptance criteria, and an out-of-scope
  boundary"), and the argument, the cost and the remedy the body gives for each. Put them
  here and the agent reads them as the skill, skipping the body it took them from.
  Recognisable terms stay, because those are what fires: a `variant` named after a screen
  is what the work looks like.
- **Explain concepts that are not this skill's** — what a callee is, what a pull request
  is, why coupling costs anything. Noise: the agent knows, and the characters come out of
  the intent.
- **Name another skill.** Wanting to name one usually means this skill orchestrates, and
  what it orchestrates is the body's to state — so the name is the leak above, one level
  out. It also reads as a routing table, which stops the agent asking whether *this*
  artifact is the skill's: for example, `DO NOT use for an architecture doc (that is
  write-nice-architecture-docs)`. The repository's invariant says the same: a skill is
  reached by its own description or not at all. A file name or a path that is the occasion
  itself is the trigger rather than a routing table — and placing the skill at the root of
  the subfolder it governs often removes the need to name anything.
- **Write a tag list or a keyword-stuffed sentence.** `Skill / SKILL.md / description —`
  is not a sentence and matches nothing anyone types.
- **Put an angle bracket in it.** `<` and `>` are rejected outright, so a description
  carrying a tag or a `<placeholder>` does not load at all.
- **Quote keywords in a second language.** A single-team skill may add the phrases that
  team really types; a published one must not, since the list only bloats the description
  and drifts out of sync.

The one naming that earns its place is a reach clause — for example, "also applies when
another skill needs …" — where another skill genuinely depends on this one. It names
nobody.

## Choosing the lead

**Does the work name the artifact?** — the same question, from the other side, as whether
the skill is finished when that artifact is.

**It does → lead with the occasion.** The work says the word and the word fires the skill.
For example, an issue, a README, an `ARCHITECTURE.md`, a `SKILL.md`:

```text
Use this skill when writing or revising a README, and when adding a section to
one that already exists. DO NOT use this skill when the artifact is an
architecture doc, reference documentation, a tutorial, or a changelog.
```

**It does not → lead with the stance, `Forces the X that Y.`** A rule that holds while
someone writes code or a comment has no word to share, and an occasion nobody names is one
the agent forgets mid-diff:

```text
Forces the fact restated at the point of use over the pointer that sends the
reader away to get it … Use this skill when writing a code comment, a docstring,
a PR description, or any text that points elsewhere to be understood. DO NOT use
this skill when the target does not exist …
```

The occasion still follows, named as an activity — for example, "writing, revising,
reviewing, or designing code". Keeping the skill in force for the rest of that activity is
the body's job.

## The leading word

The skill fires on a word shared between the description and whatever the agent is working
from: a prompt, or — for a skill hidden from the `/` menu — the work itself. Put that word
near the start, where it does its invocation work.

- **Real words**: terms that show up in your prompts, docs, and code, not labels that
  merely sound like keywords.
- **One per branch**: synonyms that rename the same branch are duplication.
- **Survives translation**: a file name, a tool name, a term of art typed as-is — for
  example, `SKILL.md`, `issue`, `PR`.
