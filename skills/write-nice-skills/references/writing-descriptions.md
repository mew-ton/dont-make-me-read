# Writing the description

Read this when you are writing or reviewing a skill's `description` or frontmatter.
The `description` is the only text loaded when the agent decides whether to fire the
skill, so it must be judge-able on its own and must not leak the procedure. Four
rules, a size limit, then one rule for the fields around it.

## 1. Third person, what + when

Write in the third person and cover both **what the skill does** and **when to
apply it**, so the agent can decide from the description alone. Add a reach clause
("also applies when another skill needs …") only when another skill genuinely
depends on this one.

## 2. No procedure in the description

Never put step-by-step instructions in the description. If the steps are there, the
agent believes it can act straight from the description and never loads the body —
so the instructions the skill exists to deliver are skipped. State *what* and
*when*; keep *how* in the body.

**Which skill hands off to which is procedure.** "Run it as one axis of a larger
review, or from the `/x` command" reads like context and is not: it tells the agent
how this skill gets used, which is exactly the kind of line that makes the body look
optional. Name the callers and the hand-offs in the body, where the steps that
depend on them live. The reach clause in rule 1 is the one thing that stays — it
says *when* this skill applies, never who runs it or in what order.

## 3. Front-load the leading word

The skill fires when a word in the description matches a word in whatever the agent
is working from. Sometimes that is a prompt. Often it is not: a skill hidden from the
`/` menu (`user-invocable: false`) fires mid-task, and the only words available are
the ones in the work itself — the file being edited, the artifact being written, the
term the code already uses. So seed the description with the **leading word** — the
term that shows up when this skill is needed, whatever produces it — and put it near
the start, where it does its invocation work.

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
- **Cut body identity**: keep the description to triggers plus a reach clause;
  anything the body already explains does not belong here.

### Bad → Good

**Bad** — tag list up front, invented keywords, and a step leaking in:

```text
Skill authoring / SKILL.md / quality — first read the whole file, then rewrite
each section, then check the frontmatter, for great skills and better writing.
```

**Good** — leading word first, what + when, no steps:

```text
SKILL.md authoring — write a skill's description and body so it fires reliably
and stays lean. Use when writing, editing, or reviewing a skill, a SKILL.md, or
its description.
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
forever — the same size argument that pushes branch detail into `references/`, one
level up. A field that genuinely needs explaining needs it in prose an author can
argue with: the body, or the repository's own design doc.
