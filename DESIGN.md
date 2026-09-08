# Design

Why the parts of this plugin are wired the way they are, and the contract that follows
from it. What the skills are *for* is in [`README.md`](README.md).

## Three layers

| Layer | Where | The context it runs in |
|---|---|---|
| Instruction | `commands/` | the messy one — fetching, asking, working out what is even wanted |
| Principle and routing | `skills/dont-make-me-read` | the main thread |
| An artifact's own rules | `skills/write-nice-*` | a fork, carrying none of the above |

Every boundary below exists to keep something out of the layer beneath it.

## No skill is in the `/` menu

The rules have to reach a code comment written halfway through some other task. Nobody
stops there to name a writing skill, so a skill that fires only when named would never
run at the moment it is most needed. Every skill is therefore model-invoked
(`disable-model-invocation: false`) and hidden from the menu (`user-invocable: false`).

That leaves the explicit route to `commands/`, which is what a person types when they
have decided for themselves that they want something written or checked.

## A command is not an alias for a skill

The same request arrives in several shapes. For an issue: the content is already
written; or an issue exists and needs fetching and improving; or nothing is settled and
what the issue should even be is still a conversation.

Sorting that out is real work, and all of it is conversation — half-formed asks,
fetched material, questions and answers, options raised and dropped. A command does it,
then hands over one consolidated brief.

If the skill were the entry point, that whole conversation would sit in the context the
artifact is written in, and it would surface in the artifact. That is the residue
`avoid-unverifiable-context` exists to keep out.

## The writing skills fork; nothing else does

"Do not write what only this conversation's participants could reconstruct" is a rule a
writer can break. `context: fork` carries in no conversation history, so a skill that
never saw the conversation cannot write from it. The prohibition becomes a property —
the same move `structuring-skills.md` already makes to keep two subagents from seeing
each other's output.

The other skills stay on the main thread because a fork would cut them off from what
they act on:

- `dont-make-me-read` routes. Routing is a decision about the work in front of you.
- `avoid-unverifiable-context` and `avoid-reference-detours` constrain writing as it
  happens, wherever it happens.
- The two `review-*` skills return findings, and a finding is only worth anything with
  its grounds attached. Putting a review behind a fork is the case
  `structuring-skills.md` names outright: nobody can then review the review.

## `review-nice-issues` has no tools at all

Its whole value is judging an issue body the way an implementer holding only that text
would. `allowed-tools: []` is that stated as a property rather than as a discipline it
has to remember: it cannot resolve a reference, cannot check the repository, cannot
confirm a claim the real reader could not confirm either.

Fetching is therefore the caller's job — `/review-issue` reads the issue and hands over
the body, and nothing else it learned goes with it.

## Adding a skill

Which layer it belongs to decides its frontmatter. Two questions settle that: does it
produce an artifact from a brief, or does it act on work already in front of the model —
and if it reports findings, do the grounds come back with them.

Frontmatter carries no comments. It is the one part of a `SKILL.md` that is parsed
rather than read, every line of it is loaded on every fire, and what each field is for
belongs here instead — where it can be argued rather than restated in eight files.

Every skill here, without exception:

```yaml
user-invocable: false
disable-model-invocation: false
allowed-tools: []
```

The first two are the menu decision above: no skill is in the `/` menu, and the model
decides when one applies. `allowed-tools` is declared on all eight and empty on seven.
`review-nice-issues`' emptiness is a property its judgment depends on, which is why it
has a section of its own above; `review-self-contained-docs` is the one skill that lists
tools.

A skill that produces an artifact from a brief adds:

```yaml
context: fork
background: false
```

`context: fork` is what carries in none of the caller's conversation; `background: false`
is what lets the caller show the result in the same turn.

Leave `agent` and `model` unset. Both narrow a fork to what a gathering run needs: a
read-only tool set cannot write, and the cheapest model that can enumerate files is not
the one to draft something a person will act on.

A user-facing entry is a file in `commands/`, never a skill.

Before committing a `SKILL.md`:

```bash
bash skills/write-nice-skills/scripts/count-tokens.sh skills/*/SKILL.md
```

Only exit 1 is about a budget: a body came back over 5000 tokens, or a file you named
was not there. Exit 2 means the machine cannot run the check at all (no `claude` or no
`jq` on PATH), and exit 3 that a measurement failed and no count came back — neither is
a pass, so fix the setup or rerun rather than reading the silence as one. For a body
that is genuinely over, push branch-only detail into that skill's `references/` until it
passes; references have a depth rule and no size rule.
