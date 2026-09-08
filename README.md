# write-nice-skills

A [Claude Code](https://claude.com/claude-code) plugin: skills for writing documents that leave a
reader with less to reconstruct — a GitHub issue, a PR review finding, a persistent doc, or a
`SKILL.md` itself.

## Skills

| Skill | Role |
|---|---|
| [`write-nice-skills`](skills/write-nice-skills/SKILL.md) | Write and review a `SKILL.md`'s description and body so it fires reliably and stays lean. |
| [`write-nice-instructions`](skills/write-nice-instructions/SKILL.md) | Shape a PR review finding: one fixed template (title / summary / details), and how firmly to state the remedy. |
| [`write-nice-issue-description`](skills/write-nice-issue-description/SKILL.md) | Write a GitHub issue body an implementer can act on alone: a determinable problem, checkable acceptance criteria, an out-of-scope boundary. |
| [`write-self-contained-docs`](skills/write-self-contained-docs/SKILL.md) | Write any persisting text — issues, PR descriptions, code comments, design docs — assuming the reader shares none of your context. |
| [`review-self-contained-docs`](skills/review-self-contained-docs/SKILL.md) | Audit a PR's description and comments for self-containment (time-closure, referenceability, reference-scope closure). Also usable directly to self-check text you just wrote. |
| [`review-nice-issues`](skills/review-nice-issues/SKILL.md) | Audit an issue body against the same conditions `write-nice-issue-description` writes to. Also usable directly to self-check an issue draft. |

`write-nice-instructions`, `write-nice-issue-description`, and `write-self-contained-docs` are
direct entry points — invoke them to write something. `review-self-contained-docs` and
`review-nice-issues` are primarily invoked by a caller as one axis of a larger review, but can also
be invoked directly by name to self-check a draft before it ships.

## Language

The skills are written in English, and so are their triggers and worked examples — a published
skill cannot know which language its users prompt in. What they tell you to *write* is a separate
question: each writing skill says to produce the issue, the finding, or the doc in the language its
readers already use, and to write it in one language only. The rules fix the text's shape and the
context it carries, not the language it carries them in.

## License

MIT — see [LICENSE](LICENSE).
