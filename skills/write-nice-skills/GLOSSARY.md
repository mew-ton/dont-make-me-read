# Glossary — write-nice-skills

The terms `SKILL.md` and the files it routes to use precisely. Each entry says what the term
means; the rule that uses it lives in the file that owns the rule.

**Leading word** — the term that shows up when a skill is needed and also appears in its
`description`: what a person types when they ask for it, or — for a skill that fires mid-task with
no prompt — what the work itself already calls the thing.

**Trigger** — a condition that should invoke the skill.

**Bound** — the condition under which a skill must *not* fire, written as its occasion negated:
"Does not apply when …".

**Reach clause** — the part of a `description` that admits a second way in: another skill needing
the rules this one holds, named as a need rather than as a skill.

**Occasion** — the artifact being written or the activity underway, named in the `description` as
what brings the skill in.

**Branch** — one distinct situation the skill handles. Different branches read different parts of
the skill; that difference is what licenses splitting a reference off.

**Child skill** — a skill a parent invokes to run one phase in its own execution environment
(`context: fork`), returning what the parent needs rather than the material it was derived from.

**Progressive disclosure** — keeping the always-loaded core small by moving material out of
`SKILL.md` and behind a context pointer.

**Context pointer** — a line in `SKILL.md` that names a condition and a file: the reference is not
loaded until that condition is met.

**No-op** — an instruction the model already follows unprompted, which costs a reader as much as a
rule that changes something.

**Common Rationalizations** — a table of the excuses an agent uses to skip a skill, each paired
with the reality that refutes it.
