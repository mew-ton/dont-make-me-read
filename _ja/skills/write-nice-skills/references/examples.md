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
A module that branches on which caller invoked it is holding its callers'
knowledge. Reading it means holding every caller, and it is edited again each
time one is added. Take the knowledge out instead: the caller passes what
differs. Use on any coding task.
```

その規則への主張がここに全部ある — そういうモジュールを読むのに何がかかるか、代わりに何をすべきか — これは
本文のものである。それを手にしたエージェントは要約から動く。本文はすでに信じていることを追認するだけで、
そもそもロードされるかも怪しい。機会は最後に、締めの一文で到来する。

**Good**

```text
Forces the caller-agnostic callee that takes what differs as data, named in the
domain's own vocabulary, over one that branches on who called it — a shared fetch
taking `from: 'pageA' | 'pageB'`, a helper with an `isDetailPage` flag, a
component with a `variant` named after the screen it appears on. Applies to any
coding task: writing, refactoring, extracting, reviewing, or designing a
function, a module, a component, or the interface between them. Does not apply
when the subject is prose, or a comment that sends its reader elsewhere to be
understood, or when the branch is on genuine domain data.
```

`Forces …` が冒頭に立つ。diff の中のどの語もこの規則そのものを名指ししないからである。diff が担っている語は
その冒頭の中に残り、それが発火させるものである。機会は `Applies to …` として続く。それが読み手に何を
払わせるのかは本文のものである。

## Another skill's name in the bound, and the second person（境界の中の他スキル名と、二人称）

**Bad**

```text
Forces the fact restated at the point of use over the pointer that sends the
reader away to get it. Applies when writing a code comment, a docstring, a PR
description, or any text that points elsewhere to be understood. DO NOT use when
the target cannot be reached at all, when the same content is repeated twice in
one document (that is dont-make-me-read), or when a module branches on which
caller invoked it (that is avoid-caller-knowledge).
```

維持すべき名前が二つ、待ち構える改名が二つ。しかもその境界は、他のどの境界も `Does not apply` で始めるところ
を、二人称の `DO NOT use` で始めている。名前は「これは自分のものか」に答えてしまうので、エージェントは
問うのをやめる。そしてそれこそ、description が問わせるために存在する問いである。

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

境界のどの節も、機会が実際に届く場合である：他所を指して理解されるテキストという機会は、指す先の無い
ポインタも、自分を繰り返すドキュメントも、呼び出し元を読むモジュールも覆う。条件は場合そのものであって、
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
