# Writing the description

Read this when you are writing or reviewing a skill's `description` or frontmatter.
The `description` is the only text loaded when the agent decides whether to fire the
skill, so it must be judge-able on its own and must not leak the procedure.

Three sections: what every description must do, what none may carry, and the wording
that makes the difference. Then a size limit, and one rule for the fields around it.

## 1. What every description must do

Some skills are shaped so that no wording satisfies section 3 cleanly. These four
hold anyway:

- **Third person.**
- **Say what the skill does.**
- **Say when it applies.**
- **Write it in English.**

Together the first three let the agent decide from the description alone, which is
all it has. The rest of this section is how to get them into one paragraph.

### 1.1 The first line carries whichever the agent cannot infer

The first line is the one the agent weighs first, so it goes to whichever of *what*
and *when* it cannot get for itself. One question decides which: **does the work name
the artifact?** — the same question, from the other side, as whether the skill is
finished when that artifact is or has to hold after the turn that loaded it.

**It does → lead with the when.** An issue, a README, an `ARCHITECTURE.md`, a
`SKILL.md`, a pull request: the work says the word, the word fires the skill, and
what the skill then does is the body's to explain. Name the occasion and stop.

```text
Use this skill when writing or revising a README, and when adding a section to
one that already exists. DO NOT use this skill when the artifact is an
architecture doc, reference documentation, a tutorial, or a changelog.
```

**It does not → lead with what the skill forces.** A rule that has to hold while
someone writes code, or writes a comment, is needed most exactly when the work never
names it — and an occasion nobody names is an occasion the agent forgets mid-diff.
Naming it is not enough there; the description has to state the stance the skill
imposes, so that what survives into the next turn is the rule and not a label. That
wording is section 3.1's.

If you cannot tell which of the two you are writing, settle that before the first
line: it decides the body as well.

### 1.2 Name the occasion as the skill's own

Say `Use this skill when …`, not a bare `Apply when …`. The bare form leaves the
subject to be inferred, and the one thing a description cannot afford to leave open
is whether the sentence describes the work or instructs the reader about the skill.
Three words buy that.

### 1.3 English, and the two other languages it does not settle

Write the description in English, even when you prompt in another language. English
terms are the ones that survive into a prompt regardless — file names, tool names,
library names — and a published skill cannot know which language its users type in.

Three languages get decided separately, and only the first is settled here: the
**description** (English, always), the **body** (English too for a skill that ships
beyond one team, since the agent reads it), and the **output the skill produces** —
an issue, a finding, a doc — which belongs in the language *its* readers already
use. Each writing skill states that last rule for itself; do not carry this file's
English down into what a skill tells the agent to write.

## 2. What a description must never carry

Again whatever the skill's shape forces elsewhere, never these:

- **Procedure.** The agent then decides it can act from the description alone, and
  never loads the body.
- **The criteria the skill applies.** Same failure, one level up.
- **A name from elsewhere** — another skill, another file, whoever calls this one.

### 2.1 Procedure, and the criteria that are procedure

Never put step-by-step instructions in the description. If the steps are there, the
agent believes it can act straight from the description and never loads the body —
so the instructions the skill exists to deliver are skipped. State *what* and
*when*; keep *how* in the body.

**The criteria the skill applies are procedure too.** A description that lists what
the skill checks for — "a determinable problem, checkable acceptance criteria, and an
out-of-scope boundary" — hands the agent the standard, and an agent holding the
standard has no reason to load the body that qualifies it. Say what the skill is a
pass over; keep what it passes on in the body.

A `Forces` line (section 3.1) fails this the moment it starts listing criteria. It
carries the stance, never the criteria the stance is applied by.

### 2.2 A name from elsewhere

Two costs, and the first is the one that surprises people. **A concrete name narrows
what the agent will infer.** `DO NOT use for an architecture doc (that is
write-nice-architecture-docs)` reads as a routing table, and an agent that has been
handed one stops asking the question the bound was for — whether *this* artifact is
the skill's. Name the artifact, which is the condition; not the skill that owns it,
which is a fact about the shelf.

**The second is size.** Every name spends characters from the 1024, and spends them
again on the day it is renamed, in every description that carried it.

The repository's own invariant is the same: a skill is reached by its own
description or not at all. Which skill hands off to which is procedure by section 2.1
as well — "run it as one axis of a larger review, or from the `/x` command" reads
like context and is not; it tells the agent how this skill gets used, which is
exactly the kind of line that makes the body look optional. Name callers and
hand-offs in the body, where the steps that depend on them live.

The one thing that stays is a reach clause — "also applies when another skill needs
…" — and only when another skill genuinely depends on this one. It says *when* this
skill applies and names nobody.

### 2.3 The identity the body already carries

Anything the body explains does not belong here: not the argument for the rule, not
the cost of breaking it, not the remedy. Those read as helpful and are the same
failure as a leaked step — an agent that has the argument and the remedy has been
given the skill, and loads the body to confirm what it already believes, if at all.

The recognisable terms stay, because those are triggers: a `variant` named after a
screen is what the work looks like. Why that costs the reader anything is the body's
to say; only the first fires.

## 3. Wording that works

### 3.1 Give the line force

Where section 1.1 puts the stance first, the form is `Forces the X that Y.` — one
clause, pitched so that it says what the skill makes you do and still leaves the
reader unable to do it.

### 3.2 State when it must not fire

An unbounded when fires on everything near it, so close the description with
`DO NOT use this skill when …` and the condition that rules it out: the artifacts
this skill is mistaken for, the cases that look like its own and are not.

It is one sentence with the `when` of section 1.1, negated — the same grammar, so
read them together and the pair is the whole condition of use. A `DO NOT` that drifts
into a different shape (`DO NOT use for …`, a bare list) stops reading as the other
half of the trigger and starts reading as trivia.

A `DO NOT` also closes off what the skill will not **produce**, where that is what it
gets reached for by mistake — `DO NOT use this skill when what is wanted is a verdict
on whether a dependency is worth keeping`. That is still a condition of use, not a
description of the output.

### 3.3 Front-load the leading word

The skill fires when a word in the description matches a word in whatever the agent
is working from. Sometimes that is a prompt. Often it is not: a skill hidden from the
`/` menu (`user-invocable: false`) fires mid-task, and the only words available are
the ones in the work itself — the file being edited, the artifact being written, the
term the code already uses. So seed the description with the **leading word** — the
term that shows up when this skill is needed, whatever produces it — and put it near
the start, where it does its invocation work.

Where section 1.1 leads with the when, that is the same position and one clause
carries both: the words the work supplies are the words that say on what occasion the
skill applies. Where it leads with `Forces` instead, there was no such word to share
— which is what put the stance first — and the leading word waits for the when a
sentence later.

- **Form**: a leading word inside a natural sentence. Not a slash-separated tag list
  (`Skill / SKILL.md / description —`), and not a full request sentence dressed up
  as a keyword.
- **Real words, not plausible ones**: use terms that actually show up in your
  prompts, docs, and code — not invented labels that merely *sound* like keywords.
- **One trigger per branch**: name each distinct situation once; synonyms that
  rename the same branch are duplication.
- **Language of the trigger**: the description is English (section 1.3), so the
  shared word has to be one that survives into whatever the agent is reading,
  whichever language that is in — a file name, a tool name, a proper noun, a term of
  art you type as-is (`SKILL.md`, `issue`, `PR`, `description`). A skill that never
  leaves a single-language team may *additionally* embed the phrases that team really
  types, as quoted examples inside the English sentence. A skill you publish must
  not: it cannot know which language its users prompt in, and a second-language
  keyword list only bloats the description and drifts out of sync. That is why none
  of the descriptions in this plugin carry one.

#### When the skill has to be on for a whole activity

Some skills are not reached by a word at all. A rule that has to hold while someone
writes code, or writes anything another person acts on, is needed most exactly when
the work never names it — there is no leading word to share, because the work is a
diff and a file, not a request. Name the **activity** as the `when` instead, in the
verbs the work is done in ("writing, revising, reviewing, or designing code"). This
is the case that leads with `Forces`, and the bound of section 3.2 is doing the most
work here: an activity named as the `when` reaches everything inside that activity
until the `DO NOT` stops it.

That gets the skill in once. Keeping it in for the rest of the activity is the
body's job, and the body cannot do it unless it says so — see
[`structuring-skills.md`](structuring-skills.md#staying-in-force).

### 3.4 Bad → Good

**Bad** — tag list up front, invented keywords, and a step leaking in:

```text
Skill authoring / SKILL.md / quality — first read the whole file, then rewrite
each section, then check the frontmatter, for great skills and better writing.
```

**Good** — when first, carrying the leading word; what in one clause; bounded; no
steps; nobody else named:

```text
Use this skill when writing, editing, or reviewing a skill, a SKILL.md, or its
description and frontmatter — how to write a skill's description and body so it
fires reliably and stays lean. DO NOT use this skill when the documentation is
not a skill's.
```

## Size

The `description` has a hard budget of **1024 characters**. If what + when +
triggers will not fit, the skill is usually doing too much — split it (see
[`structuring-skills.md`](structuring-skills.md)) rather than padding or truncating
the description.

## No comments in the frontmatter

Frontmatter is the one part of a `SKILL.md` that is parsed rather than read, and all
of it is loaded on every fire. A trailing `#` on `user-invocable: false` explains the
field to nobody who was going to be confused by it, and every reader pays for it
forever — the same size argument that pushes branch detail one level down, one
level up. A field that genuinely needs explaining needs it in prose an author can
argue with: the body, or the repository's own architecture doc.
