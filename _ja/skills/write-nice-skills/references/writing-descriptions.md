# description を書く

スキルの `description` を書く、あるいは書き直すとき、または既存のものが発火するかを判断するときに読むこと。

エージェントがそのスキルを発火させるかどうかを決めるとき、手元にあるのはスキルの `name` と `description`
だけである：本文はまだ文脈に無い。だから `description` はそれ単体で判断可能でなければならず、本文が持つ
手順を担ってはならない。

## Contents（目次）

- DO
- DON'T
- The leading word（leading word）
- Choosing the lead（どちらを先頭にするか）
- The description and the body serve different readers（description と本文は読み手が違う）
- Measuring whether it fires（そもそも発火するかを測る）

## DO

- **三人称で書くこと。** `Writes and revises a README` のように。description はシステムプロンプトに注入
  されるので、スキルごとに視点が揺れると、その中から選ぶ精度を落とす。
- **スキルが作られた意図を示すこと** — その著者が何を強制したかったのかを、一節で、著者の言葉で。
  たとえば `keeps a callee from branching on which caller invoked it`。
- **機会を名指しすること**：書かれつつある成果物か、進行中の活動か。
- **発火してはならない条件を、その機会を否定した形で、同じ人称で書くこと**：`Does not apply when …`。
  そうすれば対で一つの使用条件として読まれる。
- **`description` は英語で書くこと。** 本文とスキルの出力が何語であろうと。英語の用語こそが、どの言語で
  打たれようとプロンプトに生き残るものであり、他人がインストールするスキルは、利用者がどの言語を打つか
  知り得ない。一つのチームから決して出ないスキルなら、そのチームが実際に打つフレーズを足してよい。
- **1024文字以内に収めること、厳守。** 意図と機会と境界が収まらないなら、そのスキルは仕事を抱えすぎている：
  水増しや切り詰めではなく分割せよ。

## DON'T

- **スキルの実装を要約すること** — 手順、適用する判定基準、そして本文がそれぞれに与える論拠・代償・処方。
  ここに書くと、エージェントはそれをスキルそのものとして読み、元になった本文を読み飛ばす。作業そのものが
  使う語は残る。発火させるのはそれだからである。
- **このスキルのものではない概念を説明すること** — callee とは何か、プルリクエストとは何か、なぜ結合が代償を
  伴うのか。ノイズである：エージェントは知っているし、その文字数は意図から差し引かれる。
- **他のスキルを名指しすること。** 名指ししたくなるのは、たいていそのスキルがオーケストレーションを含んで
  いるからであり、何をオーケストレーションするのかを述べるのは本文の仕事である — だからその名指しは、本文を description の外へ運び出す。さらにそれはルーティング表としても読まれ、
  *この*成果物は自分のものかという問いをエージェントに問わせなくする：たとえば
  `DO NOT use for an architecture doc (that is write-nice-architecture-docs)`。到達節はその例外である。
  誰も名指ししないからである：「also applies when another skill needs …」。
- **タグ列や、キーワードを詰めた依頼文を書くこと。** `Skill / SKILL.md / description —` は誰が打つものにも
  一致しない。
- **山括弧を入れること。** `<` と `>` はそのまま拒否されるので、タグや `<placeholder>` を担った description は
  そもそもロードされない。

## The leading word（leading word）

スキルは、description と、エージェントが手がかりにしているものとの間で共有された語によって発火する：
プロンプトか、プロンプト無しで作業の途中に発火するスキルなら作業そのものである。その語を、起動の仕事をする先頭付近に
置くこと。

- **実在の語**：自分のプロンプト、ドキュメント、コードに現れる用語。
- **枝ごとに一つ**：同じ枝を言い換えただけの同義語は重複である。
- **翻訳を生き延びる語**：ファイル名、ツール名、そのまま打ち込む専門用語 — たとえば `SKILL.md`、`issue`、
  `PR`。

## Choosing the lead（どちらを先頭にするか）

**作業はその成果物を名指しするか。**

**名指しする → 機会を先頭に。** 作業がその語を口にし、その語がスキルを発火させる。たとえば issue、README、
`ARCHITECTURE.md`、`SKILL.md`：

```text
Writes and revises a README, including adding a section to one that already
exists. Does not apply when the artifact is an architecture doc, a SKILL.md,
an issue body, reference documentation, a tutorial, or a changelog.
```

**名指ししない → 何を強制するかを先頭に、`Forces …` で始める。** そのスキルが押し通すもの、そして押し
のける相手があるならそれを。誰かがコードやコメントを書いているあいだ
効いていなければならない規則には共有すべき語が無く、誰も名指ししない機会は、エージェントが diff の途中で
忘れる機会である：

```text
Forces the fact restated at the point of use over the pointer that sends the
reader away to get it — "the format rules at the top of this file", "same as
the config", a section that defers to another section — leaving the original
where it is and authoritative. Applies when writing a code comment, a
docstring, a PR description, or any text that points elsewhere to be
understood. Does not apply when the target does not exist or cannot be reached
at all, when the same content is repeated twice inside one document, or when a
module branches on which caller invoked it.
```

機会はそのあとに続き、活動として名指しされる — たとえば "writing, revising, reviewing, or designing code"。
その活動の残りのあいだ効かせ続けるのは本文の仕事である。

## The description and the body serve different readers（description と本文は読み手が違う）

`description` は、たった一つの判断 — 発火させるか — のための材料である。本文は、発火したあとに動かなければ
ならない相手にそのスキルを説明する。目的が異なるのだから、両者が同じことを言っている箇所の重なりは意図された
ものである：もう一方が担っていることを理由にどちらかを削れば、二人の読み手の一方が足りなくなる。

重なってよいのは、そのスキルが何のためのものかと、何がそれを呼び込むかである — 発火の判断が走るのはその
二つであり、本文が書き出すのもその二つである。手順と判定基準と論拠は本文だけに留まる。それらを手渡された
エージェントは、行動するのに必要なものを持ってしまい、そこで止まるからである。

## Measuring whether it fires（そもそも発火するかを測る）

スキルに到達されるかどうかは、それがいくら課すかとは別の、それ自体の計測である。そこへ到達すべきケースを
書き — 利用者が実際に送るであろうプロンプトをいくつか — そのスキルが走ることになるモデルに対して、
インストールした状態としない状態で走らせること。ケースが到達しないスキルは `description` の問題であり、
本文を書き直してもそこには触れない。
