---
name: write-nice-design-md
description: >
  A design doc — DESIGN.md, an ADR, an architecture note — carries the criteria a contributor
  decides by: what settles which shape a new thing takes, what it may assume, and what it owes the
  parts already there. Apply when writing or revising one, and when a decision you just made by
  reading the code is one the next contributor will have to make again. DO NOT use for a GitHub
  issue body (that is write-nice-issue-description), for a SKILL.md (that is write-nice-skills),
  or for a changelog, a tour of the code, or a record of who decided what when.
user-invocable: false
disable-model-invocation: false
context: fork
background: false
allowed-tools: []
---

## Scope

A design doc is read by someone about to add or change something in the codebase it describes. It
earns its place by letting them decide correctly **without reading the existing implementation
first**. That is the whole job.

The code already shows what is there, and git already shows when it changed. What neither shows is
what would settle the next decision — which is why a design doc that narrates the current shape
has no reader: everything in it is available faster somewhere else.

An issue is a problem plus a completion condition (`write-nice-issue-description`). A `SKILL.md` is
an instruction to an agent (`write-nice-skills`). A design doc is neither: it is the standing
answer to "how do I decide this here", read long after whoever wrote it has stopped being
available.

## The test

`dont-make-me-read`'s test, at this artifact's granularity:

> **Could a reader settle their decision from this, with the implementation closed?**

Applied to a section, that asks whether a contributor reaches a conclusion or only learns what
happened. Applied to the whole file, it asks whether the decisions a contributor actually faces are
all in here.

## The four conditions

Name them when reviewing, so a finding says which one failed.

### 1. Every section settles a decision somebody faces

Start from the decisions, not from the parts. "Which layer does this belong in", "does this fork",
"where does this entry point live" are decisions. "What the four layers are" is a description, and
becomes a section only when a decision needs it.

A section that only describes the current arrangement is the tell. The fix is to find the decision
it was written for and lead with what settles it — or, when there is no such decision, to drop the
section and let the code carry the description.

### 2. State the criterion; let the prohibition be where the criterion runs out

A criterion places anything, including the thing nobody has thought of yet. A prohibition closes
one path and leaves the rest of the space unmapped, so the reader still cannot decide — they only
know one answer is wrong.

- Criterion: **what decides it**, phrased so a reader can apply it to a case this doc never saw.
  "A skill forks when it produces an artifact from a brief; it stays on the main thread when it
  acts on work already in front of the model."
- Prohibition: what is closed off. It belongs in the doc **only where a reader following the
  criterion would otherwise walk into it**, stated as the wall — which is `dont-make-me-read`'s
  rule for constraints, applied here.

The heading is where this shows first. A heading like "X is not Y" or "no X does Z" announces a
section of Don'ts; the same section titled by its decision ("where an entry point lives") forces
the criterion into the body.

Counting is the cheap check: if most of a doc's headings are negations, it is a list of Don'ts
whatever the prose underneath says.

### 3. A classification covers everything it claims to classify

When the doc partitions what exists — layers, kinds, categories — every existing thing lands in
exactly one bucket, and a reader can place a new thing by the same partition.

A table that names three of eight teaches the reader that the partition is unreliable, and they
stop using it to decide. Either widen it until it is total, or narrow what it claims: a table of
*three examples* is honest and useful; a table presented as *the layers* is not, unless it holds
them all.

### 4. Restate what the decision needs; never re-derive a definition another file owns

Exit codes belong to the script that returns them. Frontmatter fields belong to the platform that
parses them. The list of what exists belongs to the directory that holds it.

The distinction is not "may I repeat this" — `avoid-reference-detours` already answers that: bring
the part **this reader needs in order to act**, in the shortest form that does the job. The
distinction is whether you have brought a *decision input* or a *second definition*:

| | Bring |
|---|---|
| The reader must decide something now | the part that settles it — "non-zero means do not commit it yet" |
| The other file defines the thing | a pointer, not the enumeration — the script's own header lists which code means what |

The test: **if the other file changes, does this doc become wrong?** If yes, you copied a
definition. If no, you restated an input.

## Organising the file

Index by decision, not by component. A contributor arrives with one question; the file's headings
are what they scan to find it, so a heading that names a decision is reachable and a heading that
names a part is not.

A design doc sits on the mandatory path for anyone changing the repository, so what is capped is
**the distance to the decision they came for** — not the file's total length. A long file whose
headings are decisions is cheaper than a short one they must read end to end.

## Language

Write it in the language its contributors already use — the repository's. The conditions above are
about what the doc settles, not which language settles it. The examples here are in English only
because this skill is.

## Common Rationalizations

| Rationalization | Reality |
|---|---|
| "Explaining what we currently do *is* the design." | The code shows what you currently do, faster and without drifting. What it cannot show is what would settle the next decision — that is the only thing this file adds. |
| "The prohibition is the real content; the criterion is obvious." | It is obvious to you, because you already hold the criterion you derived it from. The reader gets one closed path and an unmapped space, and has to guess the rest. |
| "The table only lists the interesting cases." | Then say so in the table's own words. Presented as the classification, a partial table teaches the reader it cannot be trusted to place anything — including the thing they came to place. |
| "Recording why we chose this over the alternative is useful history." | The rationale stays; the deliberation goes (`avoid-unverifiable-context`). Write the constraint that rules the alternative out, as a wall the reader would hit — not the account of the two of you weighing it. |
| "Copying the field list here saves the reader a trip." | It saves one trip and creates a second definition that ages on its own. Bring what the decision needs; point at what defines it. |
| "It reads fine to me." | You are supplying the criteria you already hold. Judge it as someone who has the file open and the implementation closed — that is the whole failure mode. |

## Related skills

- `dont-make-me-read` — the test this one sharpens, and the rule that a constraint is stated as the
  wall the reader would walk into.
- `avoid-unverifiable-context` — what keeps deliberation out while the rationale stays.
- `avoid-reference-detours` — what to restate at the point of use, which condition 4 narrows for
  the definitions another file owns.
- `write-nice-skills` — a `SKILL.md` is an instruction to an agent, not a design doc; this skill
  stops where that one starts.
