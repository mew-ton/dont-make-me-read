# Writing the description

Read this when you are writing or reviewing a skill's `description` or frontmatter.
The `description` is the only text loaded when the agent decides whether to fire the
skill, so it must be judge-able on its own and must not leak the procedure. Four
rules, a size limit, then one rule for the fields around it.

## 1. The first line says when it applies

Write in the third person and cover both **what the skill does** and **when to
apply it**, so the agent can decide from the description alone. The **first line
carries the when**: it is the line the agent weighs first, and for most skills it is
the only one that decides the question.

Spell the condition out there whenever applicability is not obvious — whenever
either of these is true:

- **The occasion is not self-evident.** A rule that has to hold while someone writes
  code is needed most exactly when the work never names it, so nothing in the work
  asks for it. Name the activity instead, in the verbs the work is done in.
- **The occasion does not follow from what the skill is for.** `avoid-caller-knowledge`
  sounds like a refactoring rule and also governs reviewing and designing; the reader
  cannot get that from the purpose, so the first line says it.

Where the name and the purpose already settle it — a skill for READMEs, applied when
writing a README — the when is a short clause and nothing more is owed.

**Say whose occasion it is: `Use this skill when …`.** A bare `Apply when …` leaves
the subject to be inferred, and the one thing a description cannot afford to leave
open is whether the sentence describes the work or instructs the reader about the
skill. Three words buy that, and the leading word still lands inside the first
clause.

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
the start, where it does its invocation work. That is the same place rule 1 puts the
`when`, and not a coincidence: the words the work supplies are the words that say on
what occasion the skill applies, so the first line carries both.

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
- **Cut body identity**: keep the description to the when, the bound, and a reach
  clause. Anything the body already explains does not belong here — not the argument
  for the rule, not the cost of breaking it, not the remedy. Those read as helpful
  and are the same failure as a leaked step: an agent that has the argument and the
  remedy has been given the skill, and loads the body to confirm what it already
  believes, if at all. The recognisable terms stay, because those are triggers: a
  `variant` named after a screen is what the work looks like, while "reading it means
  holding every caller" is why that matters, and only the first fires anything.

### When the skill has to be on for a whole activity

Some skills are not reached by a word at all. A rule that has to hold while someone
writes code, or writes anything another person acts on, is needed most exactly when
the work never names it — there is no leading word to share, because the work is a
diff and a file, not a request. Name the **activity** as the `when` instead, in the
verbs the work is done in ("writing, revising, reviewing, or designing code"). This
is the first of rule 1's two cases, and the bound it asks for is doing the most work
here: an activity named as the `when` reaches everything inside that activity until
the `DO NOT` stops it.

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
