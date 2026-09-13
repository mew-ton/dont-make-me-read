# Bad → Good な description

description を直す必要があり、それを照らし合わせる実例が欲しいときに読むこと。それぞれの対が、何を
直しているのかを述べる。

## Contents（目次）

- タグ列、漏れた手順、機会の不在
- 機会の前に論拠が来ている
- 境界がルーティング表になっている
- 判定基準を手渡してしまっている

## タグ列、漏れた手順、機会の不在

**Bad**

```text
Skill authoring / SKILL.md / quality — first read the whole file, then rewrite
each section, then check the frontmatter, for great skills and better writing.
```

スラッシュ区切りの冒頭はタグ列として読まれ、タグ列は誰が書くものとも合致しない — 並んでいる語自体は
問題なく、その間の記号が問題である。"first read … then rewrite … then check" は
手順なので、エージェントはそれに基づいて行動し、本文を決してロードしない。"great skills and better writing"
はどの機会も名指ししていない。

**Good**

```text
Writes, edits and reviews a skill, a SKILL.md, or its description and
frontmatter — how to write a skill's description and body so it fires reliably
and stays lean. Also applies when another skill needs the rules for writing a
description or for sizing a body. Does not apply when the artifact is an
architecture doc, an issue body, a README, or API or library reference
documentation.
```

機会が冒頭に立ち、作業が供給する語である `SKILL.md` を担っている。意図は一節。境界は、機会が放っておけば
巻き込んでしまう隣接成果物を取り戻しており、到達節は誰も名指ししていない。

## 機会の前に論拠が来ている

**Bad**

```text
A module that branches on which caller invoked it is holding its callers'
knowledge. Reading it means holding every caller, and it is edited again each
time one is added. Take the knowledge out instead: the caller passes what
differs. Use on any coding task.
```

その規則を支える論がすべてここにある — そのようなモジュールを読むのに何がかかるのか、代わりに何をすべきか — それは本文のものである。それらを持ったエージェントは要約に基づいて
行動し、本文はロードするとしても、すでに信じていることを追認するために読む。機会は最後に、締めの一文で来る。

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

diff の中にこの**規則そのもの**を名指しする語が無いので、冒頭がそのスキルの強制するものを述べる。diff が
実際に担っている語は残る — `from:`、`isDetailPage` — それが作業の見え方であり、発火させるものだからである。それが読み手に何を払わせるかは本文のもの。

## 境界がルーティング表になっている

**Bad**

```text
DO NOT use for an issue body (that is write-nice-issue-description), a
SKILL.md (that is write-nice-skills), a changelog, a tour of the code, or a
record of who decided what when.
```

維持すべき名前が二つ、待ち構える改名が二つ。そしてエージェントは、この成果物は自分のものかと問う代わりに表を
読む。さらに境界が、他のどの境界も `Does not apply` で始めるところを、二人称の `DO NOT use` で始めている。

**Good**

```text
Does not apply when the artifact is a GitHub issue body, a SKILL.md, a
changelog, a tour of the code, or a record of who decided what when.
```

条件は成果物である。どのスキルがどの成果物を所有するかは、それぞれのスキルが自分の description の中で決着させる。

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
that is already written — someone else's, or the author's own draft. Does not
apply as a general-purpose "review this issue" entry point, when the issue is
still being written or revised, or when what is wanted is a judgement of
repo-groundedness, dependency closure, or scope.
```

何に対するパスであるかであって、何を通すかではない。
