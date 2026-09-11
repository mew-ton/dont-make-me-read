# Writing the description

The `description` is the only text loaded when the agent decides whether to fire the
skill. It must be judge-able on its own, and must not leak the procedure.

## 1. What every description must do

### 1.1 Imperative by default; third person where a subject is needed

`Use this skill when …` — not `I check your issue for …`, not `you are an expert at
…`. The imperative is what the agent can act on; the subject appears only where
leaving it out would make the sentence read as a description of the work.

### 1.2 Show the intent the skill was created for

What its author wanted enforced, in one clause and in their terms. For example,
`keeps a callee from branching on which caller invoked it`.

### 1.3 Say when it applies

Name the occasion: the artifact being written, or the activity underway.

### 1.4 Write it in English

English terms are the ones that survive into a prompt whatever language it is typed
in, and a published skill cannot know which its users type. This settles the
description alone — the body's language and the skill's output are decided elsewhere.

### 1.5 Keep it short

**1024 characters, hard.** If the intent, the occasion and the triggers will not fit,
the skill is doing too much: split it rather than padding or truncating.

## 2. What a description must never carry

### 2.1 A summary of the skill's implementation

Detailed rules and the steps of the work: put them in the description and the agent
reads them as the skill, skipping the body it took them from. That covers the
procedure, the criteria it applies — for example, "a determinable problem, checkable
acceptance criteria, and an out-of-scope boundary" — and the argument, the cost and
the remedy the body gives for each.

Recognisable terms stay, because those are what fires: a `variant` named after a
screen is what the work looks like.

### 2.2 An explanation of concepts that are not this skill's

What a callee is, what a pull request is, why coupling costs anything. Noise: the
agent knows, and the characters come out of the intent.

## 3. Wording that works

### 3.1 Decide which of intent and occasion leads

**Does the work name the artifact?** — the same question, from the other side, as
whether the skill is finished when that artifact is.

**It does → lead with the occasion.** The work says the word and the word fires the
skill. For example, an issue, a README, an `ARCHITECTURE.md`, a `SKILL.md`:

```text
Use this skill when writing or revising a README, and when adding a section to
one that already exists. DO NOT use this skill when the artifact is an
architecture doc, reference documentation, a tutorial, or a changelog.
```

**It does not → lead with the stance, `Forces the X that Y.`** A rule that holds while
someone writes code or a comment has no word to share, and an occasion nobody names
is one the agent forgets mid-diff:

```text
Forces the fact restated at the point of use over the pointer that sends the
reader away to get it … Use this skill when writing a code comment, a docstring,
a PR description, or any text that points elsewhere to be understood. DO NOT use
this skill when the target does not exist …
```

The occasion still follows, named as an activity — for example, "writing, revising,
reviewing, or designing code". Keeping the skill in force for the rest of that
activity is the body's job.

### 3.2 State when it must not fire

`DO NOT use this skill when …` — the description's own occasion, negated, so the pair
reads as one condition of use. In any other shape it reads as trivia.

It also closes off what the skill will not **produce**, where that is what it gets
reached for by mistake. For example: `DO NOT use this skill when what is wanted is a
verdict on whether a dependency is worth keeping`.

### 3.3 Front-load the leading word

The skill fires on a word shared between the description and whatever the agent is
working from: a prompt, or — for a skill hidden from the `/` menu — the work itself.
Put that word near the start, where it does its invocation work.

- **Form**: inside a natural sentence. Not a tag list, for example
  `Skill / SKILL.md / description —`, and not a request sentence dressed up as a
  keyword.
- **Real words**: terms that show up in your prompts, docs, and code, not labels that
  merely sound like keywords.
- **One per branch**: synonyms that rename the same branch are duplication.
- **Survives translation**: a file name, a tool name, a term of art typed as-is — for
  example, `SKILL.md`, `issue`, `PR`. A single-team skill may additionally quote the
  phrases that team really types; a published one must not, since a second-language
  keyword list only bloats the description and drifts out of sync.

### 3.4 Go easy on proper nouns and named references

Avoid another skill's name where you can. A concrete name reads as a routing table
and stops the agent asking whether *this* artifact is the skill's, which is the
question the bound exists for — for example, `DO NOT use for an architecture doc
(that is write-nice-architecture-docs)`. It costs characters too, and costs them
again the day that skill is renamed. The repository's invariant says the same: a
skill is reached by its own description or not at all.

Not a ban. A file name or a path is sometimes the occasion itself, and then it is the
trigger. But placing the skill at the root of the subfolder or subpackage it governs
often removes the need to name anything.

A reach clause is the one naming that earns its place — for example, "also applies
when another skill needs …" — where another skill genuinely depends on this one. It
names nobody.

## No comments in the frontmatter

Frontmatter is parsed rather than read, and all of it loads on every fire. A trailing
`#` on `user-invocable: false` explains the field to nobody who was going to be
confused by it, and every reader pays for it forever. A field that genuinely needs
explaining needs prose an author can argue with: the body, or the architecture doc.
