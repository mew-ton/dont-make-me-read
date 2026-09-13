# Glossary — write-nice-skills

The terms used precisely by this skill's `SKILL.md` and the files it routes to. Each entry says
what the term means; `SKILL.md`'s table routes to the file that owns the rule using it.

**Leading word** — the term that shows up when a skill is needed and also appears in its
`description`: what a person types when they ask for it, or — for a skill that fires mid-task with
no prompt — what the work itself already calls the thing.

**The work** — the artifact and activity the agent is engaged in when the skill might fire: the
diff or file in front of it, the task it is part-way through. The prompt it was given is separate,
and either can supply the word a skill fires on.

**Intent** — what the skill's author wanted enforced, in the terms they would use for it.

**Occasion** — the artifact being written or the activity underway, named in the `description` as
what brings the skill in.

**Bound** — the condition under which a skill must *not* fire.

**Reach clause** — the part of a `description` that admits a second way in, by naming a need
another skill has for the rules this one holds.

**Always-on skill** — a skill whose body keeps it in force past the response that loaded it, so it
is resident for a whole activity rather than for one artifact.

**Branch** — one distinct situation the skill handles. Different branches read different parts of
the skill.

**Child skill** — a skill a parent invokes to run one phase in its own execution environment
(`context: fork`), returning what the parent needs.

**Progressive disclosure** — keeping the always-loaded core small by deciding, for each piece of
material, whether it stays inline in `SKILL.md`, sits behind a context pointer, or is left unlinked.

**Context pointer** — a line in `SKILL.md` that names a file and the condition or question that
reaches it: the file is not loaded until the reader is in that case.

**No-op** — an instruction the model already follows unprompted, or a setting that changes nothing.

