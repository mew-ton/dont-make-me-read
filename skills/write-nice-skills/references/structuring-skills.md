# Structuring and splitting a skill

Read this when the body is growing, when you are deciding what goes in `SKILL.md`
versus a reference, or when you are wondering whether to split one skill into two.

## The body budget

The budget belongs to the **set of skills that stand together**, not to one file.
Skills do not arrive one at a time: a rule that is on for a whole activity is
resident while another skill fires for the artifact in hand, and the reader pays for
both. A file inside its own limit can still put the activity over.

| The skill | Budget | Because |
|---|---|---|
| On for a whole activity — it is resident whatever the reader is doing | **2000 tokens** | every turn of every activity pays for it |
| Reached for one artifact or one branch | **5000 tokens / 500 lines** | only the reader who needs it pays |

The set to check is every skill that will be standing at once: the ones on for this
activity, plus whichever is reached for the artifact in hand. Its ceiling is the sum
of theirs. Measure the set, not the file you happen to be editing.

- What the body points at sits **one level deep**. Do not nest a reference inside a
  reference: the second hop is one the reader did not agree to.
- A supporting file is found by being referenced from `SKILL.md`, so its name and
  whether it sits in a directory at all are yours to pick. `references/`, `rules/`,
  `scripts/` and `assets/` are conventions borrowed from example layouts, not
  requirements — match whichever neighbour fits and spend no further thought on it.

### Measuring the token half of that budget

Line count is a weak proxy: 5000 tokens buys around 250 lines of English prose but
only around 150 in a non-Latin script such as Japanese or Chinese, so a body can sit
inside 500 lines and still cost several times the budget. Measure instead of
estimating:

```bash
bash <this skill's directory>/scripts/count-tokens.sh path/to/SKILL.md
TARGET=2000 bash <this skill's directory>/scripts/count-tokens.sh <every always-on SKILL.md>
```

The second line is the always-on budget; sum the reported figures to check the set.

"This skill's directory" is wherever this file was loaded from — a plugin's
install path, `~/.claude/skills/write-nice-skills/`, or a repository's
`.claude/skills/write-nice-skills/`. There is no one absolute path to hard-code,
so resolve it from where you read this file rather than assuming a location.

It diffs the input-side token count of two runs against whichever model is
currently default, so no API key is needed and nothing is pinned to a model
generation. Each file costs one round trip, and it exits non-zero over budget.

For a free pre-check use `wc -c`, not `wc -m` — bytes per token barely move between
scripts, where characters per token nearly double between a Latin script and a
non-Latin one. **Under about 15 KB stands in for 5000 tokens today, and 6 KB for
2000.** The
script's closing line re-derives that figure from your own run; recompute it there
rather than trusting this number once the default model has moved on — a stale
figure that is too low sends you splitting files that were never over budget.

## Staying in force

A skill that has to be on for a whole activity is loaded once and then competes with
everything that arrives after it. A body that never says it is still in force reads
as advice already given, and the work drifts back to what it was doing.

Say it, in the body, in three parts: it is in force every response and not only the
one that loaded it; it stays in force while you are unsure whether the case in front
of you counts; it is released only on an explicit condition — the work turning to
something the skill does not cover, or being told to stop.

The default is asymmetric on purpose. This is a judgment retaken every response
rather than a property of the system, so the cheap failure has to be the one that
leaves the rule on.

## Progressive disclosure: what to inline, what to disclose

- **Inline** in `SKILL.md` what **every path needs**: scope, the core principles in
  brief, and the Common Rationalizations guard.
- **Disclose** behind a context pointer what **only some branches reach**: deep
  detail, long examples, per-branch procedure.

A context pointer names the condition and the file: "For writing a description, see
`references/writing-descriptions.md`." The reference loads only when that branch is
actually taken.

## When to split

Split only when the cut earns its cost. Three cuts justify it — the first two from
mattpocock's `writing-great-skills`:

1. **By trigger word** — a distinct situation has its *own* leading word you
   actually type. That word can invoke a separate model-invoked skill (or, within
   one skill, gate a separate reference).
2. **By sequence** — a run of steps whose *post-completion* steps should be hidden.
   Isolating that run in its own context clears what follows, so it does not
   distract the work that comes after.
3. **By delegation** — a phase that should run in a *different execution
   environment*: its own model, its own tool set, its own context. The cut is not
   about what the reader types, nor about what comes after; it is about who should
   do the work. Detail: [By delegation](#by-delegation), below.

If no cut applies, keep it inline. Splitting for its own sake multiplies either
context load (more skills the agent must weigh on every turn) or cognitive load
(more files an author must hold) and buys nothing.

## By delegation

`By sequence` decides **whether one skill becomes two**. `By delegation` decides
**whether a phase leaves this execution environment**. A delegated phase is still
this skill's work — it just runs somewhere cheaper and narrower, and hands back a
conclusion instead of the material it was derived from.

### What may be delegated, and what may not

**Delegate mechanical, read-only gathering, enumeration, and parsing** — anything
whose output collapses into a conclusion. Fetching a PR's comments, listing changed
files, walking a package registry, grounding a design in the repository: the parent
needs the answer, not the transcript that produced it.

**Never delegate work whose grounds would not come back with it** — a review that
returns verdicts, a call that returns only its answer. Put a review's substance in a
subagent and the grounds for each finding never reach the main thread, so nobody can
review the review. When context is the problem there, split the **session**, not the
judgment.

The test is not judgment versus gathering. It is whether the caller receives
everything needed to check the work. A skill that *writes an artifact* passes it: the
artifact comes back whole and the reader judges the thing itself, so nothing is
distilled away behind the fork.

### Naming

`<parent-skill-name>-<role>`: the parent's name, **one** hyphen, the role the child
plays — `-change-inventory`, `-repo-grounding`, `-version-lookup`.

That shape is what the publishing naming rule allows: lowercase alphanumerics and
hyphens only, 1–64 characters, no leading or trailing hyphen, **no consecutive
hyphens**, and the frontmatter `name` must equal the parent directory name. So do
not reach for `--` to mark the boundary; a single hyphen is the only separator
available.

The name is not what hides the child. Keeping it out of the user's `/` menu is
`user-invocable`'s job, below.

### The child's frontmatter

```yaml
user-invocable: false
disable-model-invocation: false
context: fork
agent: Explore
model: haiku
background: false
```

`user-invocable: false` hides the child from the user's `/` menu. `background: false` is
required when the conclusion is used in the same turn; it defaults to `true`. `agent` and
`model` are optional: `agent` picks the tool set (`Explore` and `Plan` are read-only), and
`model` trades cost against capability — gathering only is `haiku`, gathering plus light
normalization is `sonnet`.

`agent` and `model` are the two to leave out unless you can say why. They narrow a
child to what a gathering run needs, and narrowing is wrong for a fork that produces
the artifact itself: a read-only tool set cannot write, and the cheapest model that
can enumerate files is not the one you want drafting the thing a person will act on.
Omit both and the fork inherits, which is the right default for the `Cleanliness`
motive below.

`disable-model-invocation: true` is the field that looks right and is wrong. The
caller here **is** a model, so `true` severs the only path into the child. Hiding it
from the human is `user-invocable: false`, and that is the whole requirement.

`context: fork` is what makes the child an execution environment rather than a
stretch of the parent's turn. Without it, `model` applies to the remainder of the
current turn — the main conversation — and not to anything the skill delegates.

### Passing input

Pass the whole input as **`$ARGUMENTS`**. Indexed and named arguments go through
shell-like quote parsing, so a multi-line free-form brief cannot survive as a single
argument.

### Two motives, and how each picks `model`

| Motive | What the fork buys | `model` | `background` |
|---|---|---|---|
| **Context** — keep bulk gathering off the main thread | the raw material never lands in the parent's context | the cheapest model that can do it: `haiku` for pure gathering and counting, `sonnet` once light normalization is involved | `false`, since the parent uses the conclusion in the same turn |
| **Independence** — two workers must not see each other's output | `context: fork` carries in no conversation history, so the isolation is structural rather than requested | `sonnet`: the work is design-quality, so narrow it with `effort` rather than by dropping the model | leave unset when the workers should run in parallel |
| **Cleanliness** — the conversation that produced the brief must not reach the artifact | the exploring, the half-formed asks and the fetched material never enter the context the artifact is written in | leave unset; the work is the artifact's own | `false`, since the caller shows the result in the same turn |

The last two rows replace prose. "Do not show either subagent the other's output" is
a prohibition the reader can violate; `context: fork` not carrying conversation
history is a property they cannot. The same move applies one axis over: "do not write
what only this conversation's participants could reconstruct" is
`avoid-unverifiable-context`'s rule and a writer can break it, but a skill that never
saw the conversation cannot.

So a skill that writes an artifact forks and is handed one brief, while a skill that
routes or constrains stays on the main thread: both need the property, and only the
first can have it without losing the work it acts on.

## This skill as the worked example

`write-nice-skills` teaches "don't write everything; push branch detail one level
down," so it splits along its own branches:

- the always-needed core stays in `SKILL.md`;
- the two branches an author is actually on — *writing a description* and
  *structuring a skill* — each get one reference;
- shared vocabulary goes in `GLOSSARY.md`.

A single-file version would contradict the rule it teaches. That is the test: a
skill about structure should be structured the way it prescribes.
