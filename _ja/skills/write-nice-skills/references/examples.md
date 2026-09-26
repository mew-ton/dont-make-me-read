# Bad → Good な description

description を直す必要があり、それに照らして測る実例が欲しいときに読むこと。各対は自分が何を直しているかを
名指ししており、どの Good も実際に出荷されている description である。

## A tag list, a leaked step, and no occasion（タグ列、漏れた手順、機会の不在）

**Bad**

```text
Skill authoring / SKILL.md / quality — first read the whole file, then rewrite
each section, then check the frontmatter, for great skills and better writing.
```

スラッシュ区切りの頭はタグ列に読め、タグ列は誰が書くものにも一致しない — 中の語は問題なく、あいだの約物が
問題である。「first read … then rewrite … then check」は手順なので、エージェントはそれに従って動き、本文を
決してロードしない。「great skills and better writing」は機会を何も名指ししていない。

**Good**

```text
Writes and edits a skill for a coding agent — its `SKILL.md`, its description,
its frontmatter — to the notation and rules that make it fire reliably when the
model judges whether to use it, and that keep the agent from skipping steps once
it has. Also applies when another skill needs the rules for writing a
description or for sizing a body.
```

冒頭が両方を担っている：`Writes and edits` が意図であり、それが何を書くか — スキル自身のファイル、作業が
供給する語 `SKILL.md` 付き — が機会である。ダッシュが足すのは、それを何に沿って書くかである。そのあとが
到達節で、必要を名指しし、スキルは名指ししない。境界は無い。機会が取り戻すべき隣人に届いていないからである。

## The argument in front of the occasion（機会の前に主張）

**Bad**

```text
A reader pays for everything they have to hold before they can act, and the
writer cannot feel it, because they supply what the draft leaves out as they
read it. Cut what does not change what the reader does next, and add what the
decision needs. Use when writing anything.
```

その規則への主張がここに全部ある — 読み手に何がかかるか、書き手がなぜそれを見落とすか、代わりに何をすべきか — これは
本文のものである。それを手にしたエージェントは要約から動く。本文はすでに信じていることを追認するだけで、
そもそもロードされるかも怪しい。機会は最後に、締めの一文で到来する。

**Good**

```text
Forces the narrowest range a reader has to hold before they can act — the range
its writer cannot feel. Applies while writing or revising anything another
person or an agent reads in order to act: drafting, documenting, commenting,
specifying, explaining, reviewing, or writing, refactoring and designing the code
itself. Does not apply in place of the rules that own the artifact in hand — it
carries no template, no budget, and no section list — nor when nobody acts on the
text later: chat replies, scratchpads, working notes.
```

`Forces …` が冒頭に立つ。下書きの中のどの語もこの規則そのものを名指ししないからである。機会は
`Applies while …` として続き、その動詞 — 下書き、コメント、レビュー、リファクタリング — が作業の実際に担う語で
あり、それが発火させるものである。それが読み手に何を払わせるのかは本文のものである。

## Another skill's name in the bound, and the second person（境界の中の他スキル名と、二人称）

**Bad**

```text
Drafts and revises an instruction written as a comment: text one person reads,
acts on, and can answer back to. DO NOT use for a standing rule the reader will
meet again (that is write-nice-instructions-as-rule), or for the body of a
GitHub issue (that is write-nice-issue-description).
```

維持すべき名前が二つ、待ち構える改名が二つ。しかもその境界は、他のどの境界も `Does not apply` で始めるところ
を、二人称の `DO NOT use` で始めている。名前は「これは自分のものか」に答えてしまうので、エージェントは
問うのをやめる。そしてそれこそ、description が問わせるために存在する問いである。

**Good**

```text
Drafts and revises an instruction written as a comment — a PR review finding, a
reply proposing a change, a remark asking someone to fix something — text one
person reads, acts on, and can answer back to. Does not apply when the
instruction is a standing rule the reader will meet again rather than a remark
they can answer, or when it is the body of a GitHub issue.
```

境界のどの節も、機会が実際に届く場合である：一人が読んで行動する指示という機会は、読み手がまた出会う場所に
投稿された常設のルールも、issue の本文として手渡される問題も覆う。条件は場合そのものであって、
それが誰のものかではない。どのスキルがどの成果物を所有するかは、そのスキルが自分の description で決着させる。

## A bound that takes nothing back（何も取り戻さない境界）

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

その境界の中のどれも、そもそも射程に入っていなかった：スキル自身のファイルを名指しする機会は、アーキテクチャ
ドキュメントも README も巻き込まない。だからこの節は、費やした文字を一つも取り戻さない。スキル名を抜いた
ルーティング表であり、description がそもそも問わせるために存在するたった一つの問いに答える前に、抱えて
排除すべき成果物をエージェントに手渡している。

**Good**

```text
Writes and edits a skill for a coding agent — its `SKILL.md`, its description,
its frontmatter — to the notation and rules that make it fire reliably when the
model judges whether to use it, and that keep the agent from skipping steps once
it has. Also applies when another skill needs the rules for writing a
description or for sizing a body.
```

その節を削っただけで、他は何も変えていない。境界が文字数に見合うのは、機会が隣人に届くほど広いときである —
「any coding task」「text that will be read later」— そしてそのとき境界は、実際に届く隣人を名指しする。
一つ上の対がそうしているように。

## The criteria, handed over（判定基準の手渡し）

**Bad**

```text
Determinacy-and-duplication pass over a GitHub issue body: checks whether an
implementer could act on it without asking for anything more — a determinable
problem, checkable acceptance criteria, a clear out-of-scope boundary, no
implementation method smuggled in, and no content duplicated across sections.
```

判定基準が description に入ってしまっている。それを手にしたエージェントには、その基準を限定づける本文を
ロードする理由が無い。

**Good**

```text
Runs a determinacy-and-duplication pass over the text of a GitHub issue body
that is already written — someone else's, or the author's own draft. Does not
apply as a general-purpose "review this issue" entry point, when the issue is
still being written or revised, or when what is wanted is a judgement of
repo-groundedness, dependency closure, or scope.
```

何に対するパスかであって、そのパスが何を通すかではない。境界が取り戻しているのは、別のスキルの入口である
使われ方、書きかけで捕まった成果物、そして機会は届くがこのスキルは下さない判断である。
