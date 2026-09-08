# Writing the description

Read this when you are writing or reviewing a skill's `description` or frontmatter.
The `description` is the only text loaded when the agent decides whether to fire the
skill, so it must be judge-able on its own and must not leak the procedure. Four
rules, then a size limit.

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

## 3. Front-load the leading word

The skill fires when a word in your prompt matches a word in the description. So
seed the description with the **leading word** — the term you actually type when you
want this skill — and put it near the start, where it does its invocation work.

- **Form**: a leading word inside a natural sentence. Not a slash-separated tag list
  (`Skill / SKILL.md / description —`), and not a full request sentence dressed up
  as a keyword.
- **Real words, not plausible ones**: use terms that actually show up in your
  prompts, docs, and code — not invented labels that merely *sound* like keywords.
- **One trigger per branch**: name each distinct situation once; synonyms that
  rename the same branch are duplication.
- **Japanese triggers**: you prompt in Japanese but write the description in
  English, so embed the Japanese phrases you would really type as quoted examples
  inside the English sentence (as the `ghdd-*` skills do). Do not keep a separate
  Japanese keyword list — it bloats the description and drifts out of sync.
- **Cut body identity**: keep the description to triggers plus a reach clause;
  anything the body already explains does not belong here.

### Bad → Good

**Bad** — tag list up front, invented keywords, and a step leaking in:

```text
Skill authoring / SKILL.md / quality — first read the whole file, then rewrite
each section, then check the frontmatter, for great skills and better writing.
```

**Good** — leading word first, what + when, Japanese triggers woven in, no steps:

```text
SKILL.md authoring — write a skill's description and body so it fires reliably
and stays lean. Use when writing, editing, or reviewing a skill or its
description (「スキルを書きたい」「SKILL.md をレビューして」).
```

## 4. English

Write the description in English. Japanese trigger phrases embedded as quoted
examples (rule 3) are fine — they are examples *inside* the English sentence, not a
switch to writing the description in Japanese.

## Size

The `description` has a hard budget of **1024 characters**. If what + when +
triggers will not fit, the skill is usually doing too much — split it (see
[`structuring-skills.md`](structuring-skills.md)) rather than padding or truncating
the description.
