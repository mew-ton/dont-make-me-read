# Bad → Good な description

description を直す必要があり、それを照らし合わせる実例が欲しいときに読むこと。それぞれの対が、何を
直しているのかを述べる。

## タグ列、漏れた手順、機会の不在

**Bad**

```text
Skill authoring / SKILL.md / quality — first read the whole file, then rewrite
each section, then check the frontmatter, for great skills and better writing.
```

スラッシュ区切りの冒頭はタグ列として読まれ、タグ列は誰が書くものとも合致しない — 冒頭に並んでいる語自体は
問題なく、その間の記号が問題である。"first read … then rewrite … then check" は
手順なので、エージェントはそれに基づいて行動し、本文を決してロードしない。"great skills and better writing"
はどの機会も名指ししていない。

**Good**

```text
Writes and edits a skill for a coding agent — its `SKILL.md`, its description,
its frontmatter. Applies the notation and rules that make the skill fire
reliably when the model judges whether to use it, and that keep the agent from
skipping steps once it has. Also applies when another skill needs the rules for
writing a description or for sizing a body.
```

機会が冒頭に立ち、作業が供給する語である `SKILL.md` を担っている。意図は一節で、到達節は誰も名指ししていない。
境界は無い。機会 — スキル自身のファイル — が、取り戻すべき隣接成果物にそもそも届いていないからである。

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

## 境界がルーティング表になっている、そして二人称である

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

## 何も取り戻さない境界

**Bad**

```text
Writes and edits a skill for a coding agent — its `SKILL.md`, its description,
its frontmatter. Does not apply when the artifact is an architecture doc, an
issue body, a README, or API or library reference documentation.
```

この境界にあるものは、どれも初めから手の届く範囲に無い：スキル自身のファイルを名指しした機会は、
アーキテクチャドキュメントや README を巻き込まない。だからこの節は、費やした文字を一つも取り戻していない。
これはスキル名を抜いたルーティング表であり、description がそもそも問わせるために存在する一つの問いに
答える前に、四つの成果物を抱えて排除する作業をエージェントに渡している。

**Good**

```text
Writes and edits a skill for a coding agent — its `SKILL.md`, its description,
its frontmatter.
```

取り戻すものが無いので、境界も無い。境界が文字数に見合うのは、機会が隣人に届くほど広いときであり —
「any coding task」「text that will be read later」 — そのとき境界は、実際に届いている隣人を名指しする。

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

何に対するパスであるかであって、何を通すかではない。そして Bad には無かった境界が、入口としての使い方と、
他のスキルのものである判定とを取り戻している。
