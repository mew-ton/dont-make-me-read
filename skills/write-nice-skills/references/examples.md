# Bad → Good descriptions

Read this when a description needs fixing and you want a worked pair to measure it against.
Each pair names what it is fixing.

## Contents

- A tag list, keywords nobody types, and a leaked step
- The argument in front of the occasion
- A routing table in the bound
- The criteria, handed over

## A tag list, keywords nobody types, and a leaked step

**Bad**

```text
Skill authoring / SKILL.md / quality — first read the whole file, then rewrite
each section, then check the frontmatter, for great skills and better writing.
```

The slash-separated head is not a sentence and matches nothing anyone types. "first
read … then rewrite … then check" is the procedure, so the agent acts on it and never
loads the body. "great skills and better writing" names no occasion.

**Good**

```text
Writes, edits and reviews a skill, a SKILL.md, or its description and
frontmatter — how to write a skill's description and body so it fires reliably
and stays lean. Also applies when another skill needs the rules for writing a
description or for sizing a body. Does not apply when the documentation is not
a skill's.
```

The occasion leads and carries `SKILL.md`, the word the work supplies. The intent is
one clause. The bound is the occasion negated, and the reach clause names nobody.

## The argument in front of the occasion

**Bad**

```text
A module that branches on which caller invoked it is holding its callers'
knowledge. Reading it means holding every caller, and it is edited again each
time one is added. Take the knowledge out instead: the caller passes what
differs. Use on any coding task.
```

The argument for the rule is all here — what it costs to read such a module, and what to do instead — which is the body's. An agent with
them acts on the summary; the body confirms what it already believes, if it loads at
all. The occasion arrives last, in four words.

**Good**

```text
Forces the caller-agnostic callee that takes what differs as data, named in the
domain's own vocabulary, over one that branches on who called it — a shared fetch
taking `from: 'pageA' | 'pageB'`, a helper with an `isDetailPage` flag. Applies to
any coding task: writing, refactoring, extracting, reviewing, or designing a
function, a module, a component, or the interface between them. Does not apply
when the subject is prose, or a comment that sends its reader elsewhere to be
understood, or when the branch is on genuine domain data.
```

The stance leads, because nothing in a diff names this rule. `from:`,
`isDetailPage` stay — those are what the work looks like, so those are what fires.
Why it costs the reader anything is the body's.

## A routing table in the bound

**Bad**

```text
DO NOT use for an architecture doc (that is write-nice-architecture-docs), a
SKILL.md (that is write-nice-skills), an issue body (that is
write-nice-issue-description), or for reference documentation.
```

Three names to maintain, three renames waiting, and an agent reading a table instead
of asking whether this artifact is the skill's.

**Good**

```text
Does not apply when the artifact is an architecture doc, a SKILL.md, an issue
body, or reference documentation.
```

The artifact is the condition. Which skill owns which artifact is settled by each of
those skills, in its own description.

## The criteria, handed over

**Bad**

```text
Determinacy-and-duplication pass over a GitHub issue body: checks whether an
implementer could act on it without asking for anything more — a determinable
problem, checkable acceptance criteria, a clear out-of-scope boundary, no
implementation method smuggled in, and no content duplicated across sections.
```

The standard is now in the description, and an agent holding the standard has no
reason to load the body that qualifies it.

**Good**

```text
Runs a determinacy-and-duplication pass over the text of a GitHub issue body
that is already written — someone else's, or the author's own draft. Does not
apply as a general-purpose "review this issue" entry point, when the issue is
still being written or revised, or when what is wanted is a judgement of
repo-groundedness, dependency closure, or scope.
```

What it is a pass over, not what it passes on.
