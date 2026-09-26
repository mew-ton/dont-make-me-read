# Glossary — write-nice-skills

The terms used precisely by this skill's `SKILL.md` and the files it routes to. Each entry says
what the term means. The rules that use them are settled elsewhere, and `SKILL.md`'s table says
where.

**Leading word** — the term that shows up when a skill is needed and also appears in its
`description`: what a person types when they ask for it, or — for a skill that fires mid-task with
no prompt — what the work itself already calls the thing.

**The work** — the artifact and activity the agent is engaged in when the skill might fire: the
diff or file in front of it, the task it is part-way through. The prompt it was given is separate.

**Intent** — what the skill's author wanted enforced, in the terms they would use for it.

**Occasion** — the artifact being written or the activity underway, named in the `description` as
what brings the skill in.

**Bound** — the condition under which a skill must *not* fire.

**Reach clause** — the part of a `description` that admits a second way in, by naming a need
another skill has for the rules this one holds.

**Always-on skill** — a skill whose body keeps it in force past the response that loaded it, so it
is resident for a whole activity rather than for one artifact.

**Branch** — one distinct situation the skill handles.

**Bundled file** — a file beside `SKILL.md` that the agent loads only on the branch reaching it.

**Guard** — one of the sections that catch a skill being talked out of before the work, cut during
it, or declared done after it: Common Rationalizations, Red Flags, Verification.

**Cut** — a reason a growing skill has earned a sub-skill rather than another bundled file.

**Sub-skill** — a second skill a growing one was split into: one that stands alone, or one its
parent invokes as a phase.

**No-op** — an instruction the model already follows unprompted, or a setting that changes nothing.

