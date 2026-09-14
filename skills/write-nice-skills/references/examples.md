# Bad → Good descriptions

Read this when a description needs fixing and you want a worked pair to measure it against. Each
pair names what it is fixing, and each Good is a description that ships.

## A tag list, a leaked step, and no occasion

**Bad**

```text
Skill authoring / SKILL.md / quality — first read the whole file, then rewrite
each section, then check the frontmatter, for great skills and better writing.
```

The slash-separated head reads as a tag list, and a tag list matches nothing anyone writes — the
words in it are fine, the punctuation between them is not. "first read … then rewrite … then check"
is the procedure, so the agent acts on it and never loads the body. "great skills and better
writing" names no occasion.

**Good**

```text
Writes and edits a skill for a coding agent — its `SKILL.md`, its description,
its frontmatter — to the notation and rules that make it fire reliably when the
model judges whether to use it, and that keep the agent from skipping steps once
it has. Also applies when another skill needs the rules for writing a
description or for sizing a body.
```

The opening carries both: `Writes and edits` is the intent, and what it writes — a skill's own
files, with `SKILL.md`, the word the work supplies — is the occasion. The dash adds what they are
written to. Then the reach clause, naming the need and no skill. No bound, because the occasion
reaches no neighbour to take back.

## The argument in front of the occasion

**Bad**

```text
A module that branches on which caller invoked it is holding its callers'
knowledge. Reading it means holding every caller, and it is edited again each
time one is added. Take the knowledge out instead: the caller passes what
differs. Use on any coding task.
```

The argument for the rule is all here — what it costs to read such a module, and what to do instead
— which is the body's. An agent with them acts on the summary; the body confirms what it already
believes, if it loads at all. The occasion arrives last, in a closing sentence.

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

`Forces …` opens it, because no word in a diff names the rule itself; the words a diff does carry
stay inside that opening — `from:`, `isDetailPage` — and those are what fires. The occasion follows
as `Applies to …`. Why it costs the reader anything is the body's.

## Another skill's name in the bound, and the second person

**Bad**

```text
Forces the fact restated at the point of use over the pointer that sends the
reader away to get it. Applies when writing a code comment, a docstring, a PR
description, or any text that points elsewhere to be understood. DO NOT use when
the target cannot be reached at all, when the same content is repeated twice in
one document (that is dont-make-me-read), or when a module branches on which
caller invoked it (that is avoid-caller-knowledge).
```

Two names to maintain and two renames waiting, in a bound that also opens `DO NOT use`, in the
second person, where every other bound opens `Does not apply`. The names answer "is this one mine?"
so the agent stops asking, and that is the question the description exists to make it ask.

**Good**

```text
Forces the fact restated at the point of use over the pointer that sends the
reader away to get it — "the format rules at the top of this file", "same as the
config", a section that defers to another section — leaving the original where it
is and authoritative. Applies when writing a code comment, a docstring, a PR
description, or any text that points elsewhere to be understood. Does not apply
when the target does not exist or cannot be reached at all, when the same content
is repeated twice inside one document, or when a module branches on which caller
invoked it.
```

Each clause of the bound is a case the occasion really reaches: text that points elsewhere covers a
pointer with no target, a document that repeats itself, and a module that reads its caller. The
condition is the case, not who owns it — which skill owns which is settled by that skill, in its own
description.

## A bound that takes nothing back

**Bad**

```text
Writes and edits a skill for a coding agent — its `SKILL.md`, its description,
its frontmatter — to the notation and rules that make it fire reliably when the
model judges whether to use it, and that keep the agent from skipping steps once
it has. Also applies when another skill needs the rules for writing a
description or for sizing a body. Does not apply when the artifact is an
architecture doc, an issue body, a README, or API or library reference
documentation.
```

Nothing in that bound was ever in reach: an occasion naming a skill's own files does not sweep in an
architecture doc or a README, so the clause returns none of the characters it spends. It is a
routing table with the skill names taken out, and it hands the agent artifacts to hold and rule out
before it can answer the one question the description exists to make it ask.

**Good**

```text
Writes and edits a skill for a coding agent — its `SKILL.md`, its description,
its frontmatter — to the notation and rules that make it fire reliably when the
model judges whether to use it, and that keep the agent from skipping steps once
it has. Also applies when another skill needs the rules for writing a
description or for sizing a body.
```

The clause is deleted, nothing else. A bound earns its characters where the occasion is wide enough
to reach a neighbour — "any coding task", "text that will be read later" — and there it names the
neighbour it actually reaches, as the pair above does.

## The criteria, handed over

**Bad**

```text
Determinacy-and-duplication pass over a GitHub issue body: checks whether an
implementer could act on it without asking for anything more — a determinable
problem, checkable acceptance criteria, a clear out-of-scope boundary, no
implementation method smuggled in, and no content duplicated across sections.
```

The standard is now in the description, and an agent holding the standard has no reason to load the
body that qualifies it.

**Good**

```text
Runs a determinacy-and-duplication pass over the text of a GitHub issue body
that is already written — someone else's, or the author's own draft. Does not
apply as a general-purpose "review this issue" entry point, when the issue is
still being written or revised, or when what is wanted is a judgement of
repo-groundedness, dependency closure, or scope.
```

What it is a pass over, not what it passes on. The bound takes back a mode of use that is another
skill's entry point, the artifact caught mid-write, and judgements the occasion reaches but this
skill does not make.
