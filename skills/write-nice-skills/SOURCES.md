# Where this skill's rules come from

Nothing loads this file: it is not referenced from `SKILL.md`, so it costs the agent no
context. It exists so a maintainer can tell an inherited rule from an invented one, and so
each upstream can be re-checked when it moves.

It moves. `writing-for-agents` was `writing-great-skills` until its v1.1, renamed with no
alias, and this skill cited the old name for months without anything breaking — the arrow
into a file we do not own, which `find-document-dependencies` describes and nothing
mechanical catches. Re-read the sources below before trusting a rule's attribution.

## The sources

| Source | Where |
|---|---|
| **Skill authoring best practices** (Anthropic) | <https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices> |
| **`writing-for-agents`** (Matt Pocock) | `skills/productivity/writing-for-agents/` in <https://github.com/mattpocock/skills>, with its disclosed `SKILL-MECHANICS.md` |
| **`agent-skills`** (Addy Osmani) | `docs/skill-anatomy.md` in <https://github.com/addyosmani/agent-skills> |
| **`skill-creator`** (Anthropic) | ships with Claude; `scripts/quick_validate.py` is the machine-readable form of the spec |
| **Skill creation best practices** (agentskills.io) | <https://agentskills.io/skill-creation/best-practices>, over the specification it links |

## What each one gives this skill

### Anthropic's best practices

- **Third person, always**: "The description is injected into the system prompt, and
  inconsistent point-of-view can cause discovery problems." Every description here was
  imperative until that was read; `Applies when …` and `Does not apply when …` are what the
  pair became.
- The hard limits on the `description`: non-empty, at most 1,024 characters, no XML tags.
  `quick_validate.py` enforces the same numbers, and the ones on `name` this skill leaves
  to the platform.
- What the description is for: "Claude uses it to choose the right Skill from potentially
  100+ available Skills", so it carries what the skill does *and* when to use it, and the
  rest of `SKILL.md` carries the implementation.
- **Bundled files one level deep**, and the mechanism behind it: a nested file is read
  partially — "Claude might use commands like `head -100` to preview content rather than
  reading entire files".
- `SKILL.md` under 500 lines.
- What is free and what is not: only name and description are pre-loaded for every skill;
  a bundled file costs nothing until it is read.
- Evaluation-driven development — write the evaluations before the documentation, at least
  three, and test on every model the skill will run on.
- Anti-patterns this skill restates in its own terms: offering many options where one
  default plus an escape hatch will do; inconsistent terminology; time-sensitive wording.

### `writing-for-agents`

- The vocabulary: **leading word**, **context pointer**, **progressive disclosure**, and
  the **two loads** — context load, paid every turn, against cognitive load, paid by the
  person who has to remember the skill exists.
- The split by **sequence**: hide the post-completion steps so they do not distract the
  work in hand. Its `## When to Split` is the direct source of our `## When to split`.
- The split by **trigger word**, from the disclosed `SKILL-MECHANICS.md`
  (`## Splitting by invocation`), which also gives the model-invoked versus user-invoked
  choice and the **router skill** pattern.
- A **sharp completion criterion** per step, and the order it implies: sharpen a vague
  bound before splitting a sequence.
- **Pruning** the no-op — an instruction the model already follows unprompted.

### `agent-skills`

- **`## Common Rationalizations`**, verbatim as a section name, and its two columns,
  `| Rationalization | Reality |`. Its rule for filling them: capture every excuse an agent
  has actually made, each with a factual counter-argument.
- Two sections of its anatomy this skill has not taken: **Red Flags**, the observable signs
  that the skill is being violated, and **Verification**, a checklist whose every box is
  answerable with evidence.

### agentskills.io

- **Coherent units.** A skill covers a unit of work the way a function does: scoped too
  narrowly, several skills load for one task and their instructions have to be reconciled;
  scoped too broadly, nothing activates it precisely. This is the rule that answers *when
  not to split*, which the other sources leave implicit.
- **Moderate detail.** "When you find yourself covering every edge case, consider whether
  most are better handled by the agent's own judgment."
- The **5,000-token** half of the body budget, from the specification it links, alongside
  the 500 lines the other sources give.
- A context pointer states **when** to load the file — "Read `references/api-errors.md` if
  the API returns a non-200 status code" — not what it is about.
- **Procedures over declarations**: teach how to approach a class of problems rather than
  what to produce for one instance.
- **Gotchas**, kept inline: environment-specific facts that defy a reasonable assumption,
  because an agent that does not know one cannot recognise the condition that would load
  the file holding it. Add to them every time you have to correct the agent.
- Patterns this skill does not carry: output templates, progress checklists, validation
  loops, plan-validate-execute, and bundling a script once the agent is seen reinventing
  the same logic across runs.

### `skill-creator`

- The spec, executable: `scripts/quick_validate.py` refuses a name or description that
  breaks the limits above, and allows only `name`, `description`, `license`,
  `allowed-tools`, `metadata` and `compatibility` in the frontmatter of a published skill.
- The description-triggering harness: `scripts/run_loop.py` measures how often a
  description actually fires, splitting the eval set into train and held-out test.
- Its counter-drift note: Claude tends to *under*-trigger skills, so a description may be
  written "a little bit pushy".

## What is this repository's own

- The **2000-token budget** for a skill that is on for a whole activity, the budget
  belonging to the set of skills standing together rather than to a file, and
  `scripts/count-tokens.sh`, which measures rather than estimates. The 5000-token figure
  is the agentskills.io specification's; the other sources count lines.
- **`Forces the X that Y.`** as the lead for a skill nothing in the work names, against
  `Writes and revises …`, plus `Applies when …`, for one an artifact names. The form is Dietrich Gebert's
  `ponytail`; the rule that derives which to use from whether the skill outlives its
  artifact is ours.
- **`Does not apply when …`** as the bound's fixed shape: the occasion negated.
- The split by **delegation**, and the sub-skill's frontmatter and naming.
- **Staying in force**, for a skill that has to survive the turn that loaded it.
- The rule that the body carries the skill's own explanation even where the description
  says it too.

## Where this repository knowingly differs

- **Negation.** `writing-for-agents` prunes negation and prompts the positive target.
  This repository uses negation in two places on purpose: the bound, which exists to stop a
  wrong firing, and the DON'T list, where a prohibition stated as its own inverse arrives
  weaker than the prohibition.
- **Frontmatter.** Every skill here sets `user-invocable`, `disable-model-invocation`,
  `context` and `background`. Those are Claude Code plugin fields; the published-skill
  validator rejects them. This is a plugin, so that is correct here and portable nowhere.

## A note on reaching these

`agentskills.io` is blocked by this environment's network egress proxy; its best practices
reached this repository as text pasted into the session rather than as a page anyone here
can fetch. Everything else above was read from its source.
