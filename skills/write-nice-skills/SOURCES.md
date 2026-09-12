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

## What each one gives this skill

### Anthropic's best practices

- The hard limits: `name` at most 64 characters, lowercase letters, numbers and hyphens,
  no XML tags, and not the reserved words `anthropic` or `claude`; `description` non-empty,
  at most 1,024 characters, no XML tags. `quick_validate.py` enforces the same numbers.
- What the description is for: "Claude uses it to choose the right Skill from potentially
  100+ available Skills", so it carries what the skill does *and* when to use it, and the
  rest of `SKILL.md` carries the implementation.
- **References one level deep**, and the mechanism behind it: a nested reference is read
  partially — "Claude might use commands like `head -100` to preview content rather than
  reading entire files".
- A table of contents for a reference file over 100 lines, for the same reason.
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
- Two rules this skill does not yet carry: a **sharp completion criterion** per step —
  sharpen a vague bound before splitting a sequence — and **pruning**, which removes the
  no-op, an instruction the model already follows by default.

### `agent-skills`

- **`## Common Rationalizations`**, verbatim as a section name, and its two columns,
  `| Rationalization | Reality |`. Its rule for filling them: capture every excuse an agent
  has actually made, each with a factual counter-argument.
- Two sections of its anatomy this skill has not taken: **Red Flags**, the observable signs
  that the skill is being violated, and **Verification**, a checklist whose every box is
  answerable with evidence.

### `skill-creator`

- The spec, executable: `scripts/quick_validate.py` refuses a name or description that
  breaks the limits above, and allows only `name`, `description`, `license`,
  `allowed-tools`, `metadata` and `compatibility` in the frontmatter of a published skill.
- The description-triggering harness: `scripts/run_loop.py` measures how often a
  description actually fires, splitting the eval set into train and held-out test.
- Its counter-drift note: Claude tends to *under*-trigger skills, so a description may be
  written "a little bit pushy".

## What is this repository's own

- The **token budgets** and the script that measures them: 2000 tokens for a skill that is
  on for a whole activity, 5000 for one reached per artifact, and the budget belonging to
  the set of skills standing together rather than to a file. Upstream counts lines.
- **`Forces the X that Y.`** as the lead for a skill nothing in the work names, against
  `Use this skill when …` for one an artifact names. The form is Dietrich Gebert's
  `ponytail`; the rule that derives which to use from whether the skill outlives its
  artifact is ours.
- **`DO NOT use this skill when …`** as the bound's fixed shape.
- The split by **delegation**, and the child skill's frontmatter and naming.
- **Staying in force**, for a skill that has to survive the turn that loaded it.
- The rule that the body carries the skill's own explanation even where the description
  says it too.

## Where this repository knowingly differs

- **Third person.** The best practices warn: "Always write in third person. The description
  is injected into the system prompt, and inconsistent point-of-view can cause discovery
  problems", and give `You can use this to process Excel files` as what to avoid. Every
  description here is imperative — `Use this skill when …`. **Unsettled**: the divergence is
  deliberate but untested, and `run_loop.py` is what would settle it.
- **Negation.** `writing-for-agents` prunes negation and prompts the positive target.
  This repository uses negation in two places on purpose: the bound, which exists to stop a
  wrong firing, and the DON'T list, where a prohibition stated as its own inverse arrives
  weaker than the prohibition.
- **Frontmatter.** Every skill here sets `user-invocable`, `disable-model-invocation`,
  `context` and `background`. Those are Claude Code plugin fields; the published-skill
  validator rejects them. This is a plugin, so that is correct here and portable nowhere.

## Not yet read

`https://agentskills.io/skill-creation/best-practices` is blocked by this environment's
network egress proxy, so nothing here is drawn from it.
