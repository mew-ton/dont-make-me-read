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
`keeps a callee from branching on which caller invoked it`. The test that finds such
a callee is the body's.

### 1.3 Say when it applies

Name the occasion: the artifact being written, or the activity underway.

### 1.4 Write it in English

English terms are the ones that survive into a prompt whatever language it is typed
in, and a published skill cannot know which its users type. This settles the
description alone — the body's language and the skill's output are decided elsewhere.

### 1.5 Keep it short

**1024 characters, hard.** If what + when + triggers will not fit, the skill is doing
too much: split it (see [`structuring-skills.md`](structuring-skills.md)) rather than
padding or truncating.

## 2. What a description must never carry

### 2.1 Procedure

Steps let the agent act from the description and never load the body. Which skill
hands off to which counts too — for example, "run it as one axis of a larger review".

### 2.2 The criteria the skill applies

Listing what it checks for hands over the standard, and an agent holding the standard
has no reason to load what qualifies it. For example, "a determinable problem,
checkable acceptance criteria, and an out-of-scope boundary" belongs in the body.

### 2.3 A name from elsewhere

Another skill, another file, whoever calls this one. A concrete name reads as a
routing table and stops the agent asking whether *this* artifact is the skill's — for
example, `DO NOT use for an architecture doc (that is write-nice-architecture-docs)`.
It also costs characters, and costs them again the day that skill is renamed. Name
the artifact, not its owner: a skill is reached by its own description or not at all.

A reach clause stays — for example, "also applies when another skill needs …" —
where another skill genuinely depends on this one. It names nobody.

### 2.4 The identity the body already carries

The argument, the cost, the remedy. An agent handed those has been handed the skill.
Recognisable terms stay, because those are what fires: a `variant` named after a
screen is what the work looks like.

## 3. Wording that works

### 3.1 Decide which of what and when leads

**Does the work name the artifact?** — the same question, from the other side, as
whether the skill is finished when that artifact is.

**It does → lead with the when.** The work says the word and the word fires the
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

The `when` still follows, named as an activity — for example, "writing, revising,
reviewing, or designing code". Keeping the skill in force for the rest of it is the
body's job: see [`structuring-skills.md`](structuring-skills.md#staying-in-force).

### 3.2 State when it must not fire

`DO NOT use this skill when …` — the description's own `when`, negated, so the pair
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

### 3.4 Bad → Good

**Bad** — tag list up front, invented keywords, a step leaking in:

```text
Skill authoring / SKILL.md / quality — first read the whole file, then rewrite
each section, then check the frontmatter, for great skills and better writing.
```

**Good** — when first, carrying the leading word; intent in one clause; bounded; no
steps; nobody else named:

```text
Use this skill when writing, editing, or reviewing a skill, a SKILL.md, or its
description and frontmatter — how to write a skill's description and body so it
fires reliably and stays lean. DO NOT use this skill when the documentation is
not a skill's.
```

## No comments in the frontmatter

Frontmatter is parsed rather than read, and all of it loads on every fire. A trailing
`#` on `user-invocable: false` explains the field to nobody who was going to be
confused by it, and every reader pays for it forever. A field that genuinely needs
explaining needs prose an author can argue with: the body, or the architecture doc.
