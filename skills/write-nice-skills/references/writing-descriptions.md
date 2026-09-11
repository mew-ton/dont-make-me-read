# Writing the description

Read this when you are writing or reviewing a skill's `description` or frontmatter.
The `description` is the only text loaded when the agent decides whether to fire the
skill, so it must be judge-able on its own and must not leak the procedure. Four
rules, a size limit, then one rule for the fields around it.

## 1. The first line carries whichever the agent cannot infer

Write in the third person and cover both **what the skill does** and **when to
apply it**, so the agent can decide from the description alone. The first line is
the one the agent weighs first, so it goes to whichever of the two it cannot get
for itself. Which that is depends on one thing: **does the work name the artifact?**

**It does → lead with the when.** An issue, a README, an `ARCHITECTURE.md`, a
`SKILL.md`, a pull request: the work says the word, the word fires the skill, and
what the skill then does is the body's to explain. Name the occasion and stop.

```text
Use this skill when writing or revising a README, and when adding a section to
one that already exists. DO NOT use for an architecture doc (that is
write-nice-architecture-docs) …
```

**It does not → lead with what the skill forces.** A rule that has to hold while
someone writes code, or writes a comment, is needed most exactly when the work never
names it — and an occasion nobody names is an occasion the agent forgets mid-diff.
Naming it is not enough there; the description has to state the stance the skill
imposes, so that what survives into the next turn is the rule and not a label:

```text
Forces the fact restated at the point of use over the pointer that sends the
reader away to get it … Use this skill when writing a code comment, a docstring,
a PR description, or any text that points elsewhere to be understood. DO NOT use
when the target does not exist …
```

The form is `Forces the X that Y.` — one clause, pitched so that it says what the
skill makes you do and still leaves the reader unable to do it: the stance, never the
criteria the stance is applied by. A `Forces` line that starts listing criteria has
handed the agent the standard, and an agent holding the standard has no reason to
load the body that qualifies it.

Which lead a skill takes is not a fresh judgment: it is the same question as whether
the skill has to hold after the turn that loaded it. One that does leads with
`Forces`. One reached for a single artifact, and finished when that artifact is,
leads with its when. If you cannot tell which you are writing, settle that first —
it decides the body as well as the first line.

**Either way, say whose occasion it is: `Use this skill when …`.** A bare `Apply
when …` leaves the subject to be inferred, and the one thing a description cannot
afford to leave open is whether the sentence describes the work or instructs the
reader about the skill. Three words buy that.

**The last line says when it does not apply.** An unbounded when fires on everything
near it, so close it with a `DO NOT use for …`: the artifacts this skill is mistaken
for, and where relevant the sibling that owns each one (`DO NOT use for a SKILL.md
(that is write-nice-skills)`). Naming the sibling costs an edit the day it is
renamed; firing on every neighbouring artifact costs more.

A `DO NOT` also closes off what the skill will not produce, where that is what it
gets reached for by mistake — `DO NOT expect a verdict on whether a dependency is
worth keeping`. That is still a condition of use, not a description of the output.

Add a reach clause ("also applies when another skill needs …") only when another
skill genuinely depends on this one.

## 2. No procedure in the description

Never put step-by-step instructions in the description. If the steps are there, the
agent believes it can act straight from the description and never loads the body —
so the instructions the skill exists to deliver are skipped. State *what* and
*when*; keep *how* in the body.

**Which skill hands off to which is procedure.** "Run it as one axis of a larger
review, or from the `/x` command" reads like context and is not: it tells the agent
how this skill gets used, which is exactly the kind of line that makes the body look
optional. Name the callers and the hand-offs in the body, where the steps that
depend on them live. Two things in rule 1 stay, because both are conditions of use
rather than order of use: the reach clause, and the sibling named inside a `DO NOT`.
Neither says who runs this skill — "that is the caller's job" does, so it goes to the
body.

**The criteria the skill applies are procedure too.** A description that lists what
the skill checks for — "a determinable problem, checkable acceptance criteria, and an
out-of-scope boundary" — hands the agent the standard, and an agent holding the
standard has no reason to load the body that qualifies it. Say what the skill is a
pass over; keep what it passes on in the body.

## 3. Front-load the leading word

The skill fires when a word in the description matches a word in whatever the agent
is working from. Sometimes that is a prompt. Often it is not: a skill hidden from the
`/` menu (`user-invocable: false`) fires mid-task, and the only words available are
the ones in the work itself — the file being edited, the artifact being written, the
term the code already uses. So seed the description with the **leading word** — the
term that shows up when this skill is needed, whatever produces it — and put it near
the start, where it does its invocation work. Where rule 1 leads with the when, that
is the same position and not a coincidence: the words the work supplies are the words
that say on what occasion the skill applies, so one clause carries both. Where rule 1
leads with `Forces` instead, there was no such word to share — which is what put the
stance first — and the leading word waits for the when a sentence later.

- **Form**: a leading word inside a natural sentence. Not a slash-separated tag list
  (`Skill / SKILL.md / description —`), and not a full request sentence dressed up
  as a keyword.
- **Real words, not plausible ones**: use terms that actually show up in your
  prompts, docs, and code — not invented labels that merely *sound* like keywords.
- **One trigger per branch**: name each distinct situation once; synonyms that
  rename the same branch are duplication.
- **Language of the trigger**: the description is English (rule 4), so the shared
  word has to be one that survives into whatever the agent is reading, whichever
  language that is in — a file name, a tool name, a proper noun, a term of art you type as-is
  (`SKILL.md`, `issue`, `PR`, `description`). A skill that never leaves a
  single-language team may *additionally* embed the phrases that team really types,
  as quoted examples inside the English sentence. A skill you publish must not: it
  cannot know which language its users prompt in, and a second-language keyword list
  only bloats the description and drifts out of sync. That is why none of the
  descriptions in this plugin carry one.
- **Cut body identity**: keep the description to the lead rule 1 picks, the bound,
  and a reach clause. Anything the body already explains does not belong here — not the argument
  for the rule, not the cost of breaking it, not the remedy. Those read as helpful
  and are the same failure as a leaked step: an agent that has the argument and the
  remedy has been given the skill, and loads the body to confirm what it already
  believes, if at all. The recognisable terms stay, because those are triggers: a
  `variant` named after a screen is what the work looks like. Why that costs the
  reader anything is the body's to say; only the first fires.

### When the skill has to be on for a whole activity

Some skills are not reached by a word at all. A rule that has to hold while someone
writes code, or writes anything another person acts on, is needed most exactly when
the work never names it — there is no leading word to share, because the work is a
diff and a file, not a request. Name the **activity** as the `when` instead, in the
verbs the work is done in ("writing, revising, reviewing, or designing code"). This
is the case where rule 1 leads with `Forces`, and the bound it asks for is doing the
most work here: an activity named as the `when` reaches everything inside that
activity until the `DO NOT` stops it.

That gets the skill in once. Keeping it in for the rest of the activity is the
body's job, and the body cannot do it unless it says so — see
[`structuring-skills.md`](structuring-skills.md#staying-in-force).

### Bad → Good

**Bad** — tag list up front, invented keywords, and a step leaking in:

```text
Skill authoring / SKILL.md / quality — first read the whole file, then rewrite
each section, then check the frontmatter, for great skills and better writing.
```

**Good** — when first, carrying the leading word; what in one clause; bounded; no
steps:

```text
Use this skill when writing, editing, or reviewing a skill, a SKILL.md, or its
description and frontmatter — how to write a skill's description and body so it
fires reliably and stays lean. DO NOT use for non-skill documentation.
```

## 4. English

Write the description in English, even when you prompt in another language. English
terms are the ones that survive into a prompt regardless — file names, tool names,
library names — and a published skill cannot know which language its users type in.

Three languages get decided separately, and only the first is settled here: the
**description** (English, always), the **body** (English too for a skill that ships
beyond one team, since the agent reads it), and the **output the skill produces** —
an issue, a finding, a doc — which belongs in the language *its* readers already
use. Each writing skill states that last rule for itself; do not carry this file's
English down into what a skill tells the agent to write.

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
