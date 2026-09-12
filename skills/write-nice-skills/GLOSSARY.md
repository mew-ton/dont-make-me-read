# Glossary — write-nice-skills

Shared vocabulary for talking about skill authoring. `SKILL.md` and every file it routes
to use these terms precisely.

**Leading word** — the term that shows up when a skill is needed, and which also
appears in the skill's `description`: what a person types when they ask for it, or —
for a skill that fires mid-task with no prompt — what the work itself already calls
the thing. That shared word is what links the two and makes the skill fire, so it is
front-loaded in the description. It is a word the work itself produces, inside a sentence.

**Trigger** — a condition that should invoke the skill, phrased as "applies when …".
One per branch: synonyms that rename the same branch are duplication.

**Branch** — one distinct situation the skill handles. Different branches read
different parts of the skill; that difference is what licenses splitting a
reference off.

**Child skill** — a skill a parent skill invokes to run one phase in its own
execution environment (`context: fork`), returning a conclusion rather than the
material it gathered.

**Progressive disclosure** — moving reference material *down* the hierarchy: out of
`SKILL.md` and behind a context pointer, so the always-loaded core stays small.
Inline what every path needs; disclose what only some branches reach.

**Context pointer** — a link in `SKILL.md` (e.g. "For X, see `references/x.md`")
that tells the agent when and where to load a reference. The reference is not
loaded until the pointer's condition is met.

**Common Rationalizations** — a table of the excuses an agent uses to skip a skill,
each paired with the reality that refutes it.
