# Bad → Good な description

対になった実例。それぞれ、何を直しているのかを述べる。

## Contents（目次）

- タグ列、誰も打たないキーワード、漏れた手順
- 機会の前に主張が来ている
- 境界がルーティング表になっている
- 判定基準を手渡してしまっている

## タグ列、誰も打たないキーワード、漏れた手順

**Bad**

```text
Skill authoring / SKILL.md / quality — first read the whole file, then rewrite
each section, then check the frontmatter, for great skills and better writing.
```

スラッシュ区切りの冒頭は文ではなく、誰が打つ語とも合致しない。"first read … then rewrite … then check" は
手順なので、エージェントはそれに基づいて行動し、本文を決してロードしない。"great skills and better writing"
はどの機会も名指ししていない。

**Good**

```text
Writes, edits and reviews a skill, a SKILL.md, or its description and
frontmatter — how to write a skill's description and body so it fires reliably
and stays lean. Does not apply when the documentation is not a skill's.
```

機会が先頭に立ち、作業が供給する語である `SKILL.md` を担っている。意図は一節。境界は機会を否定したもの。

## 機会の前に主張が来ている

**Bad**

```text
A module that branches on which caller invoked it is holding its callers'
knowledge. Reading it means holding every caller, and it is edited again each
time one is added. Take the knowledge out instead: the caller passes what
differs. Use on any coding task.
```

問題、代償、処方がすべてここにある — それがスキルそのものである。それらを持ったエージェントは要約に基づいて
行動し、本文はロードするとしても、すでに信じていることを追認するために読む。機会は最後に、四語で来る。

**Good**

```text
Forces the caller-agnostic callee that takes what differs as data, named in the
domain's own vocabulary, over one that branches on who called it — a shared fetch
taking `from: 'pageA' | 'pageB'`, a helper with an `isDetailPage` flag. Applies to
any coding task: writing, refactoring, extracting, reviewing, or designing a
function, a module, a component, or the interface between them.
```

diff の中にこの規則を名指しするものが何も無いので、姿勢が先頭に立つ。`from:`、`isDetailPage` は残る —
それが作業の見え方であり、発火させるものだからである。それが読み手に何を払わせるかは本文のもの。

## 境界がルーティング表になっている

**Bad**

```text
DO NOT use for an architecture doc (that is write-nice-architecture-docs), a
SKILL.md (that is write-nice-skills), an issue body (that is
write-nice-issue-description), or for reference documentation.
```

維持すべき名前が三つ、待ち構える改名が三つ。そしてエージェントは、この成果物は自分のものかと問う代わりに表を
読む。

**Good**

```text
Does not apply when the artifact is an architecture doc, a SKILL.md, an issue
body, reference documentation, a tutorial, or a changelog.
```

条件は成果物である。どのスキルが所有するかは棚についての事実であり、それは各スキルが自分の機会の中で述べる。

## 判定基準を手渡してしまっている

**Bad**

```text
Determinacy-and-duplication pass over a GitHub issue body: checks whether an
implementer could act on it without asking for anything more — a determinable
problem, checkable acceptance criteria, a clear out-of-scope boundary, no
implementation method smuggled in, and no content duplicated across sections.
```

判定基準が description に入ってしまい、それを握ったエージェントには、それを限定する本文をロードする理由が
ない。

**Good**

```text
Runs a determinacy-and-duplication pass over the text of a GitHub issue body
that is already written — someone else's, or the author's own draft.
```

何に対するパスであるかであって、何を通すかではない。
