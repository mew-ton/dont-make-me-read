# description を書く

スキルの `description` を書く、あるいは書き直すとき、または既存のものが発火するかを判断するときに読むこと。

エージェントがそのスキルを発火させるかどうかを決めるとき、手元にあるのはスキルの `name` と `description`
だけである：本文はまだ文脈に無い。だから `description` はそれ単体で判断可能でなければならず、本文が持つ
手順を担ってはならない。

## Contents（目次）

- DO
- DON'T
- The word that fires it（発火させる語）
- Choosing the lead（どちらを先頭にするか）
- The description and the body serve different readers（description と本文は読み手が違う）
- Measuring whether it fires（そもそも発火するかを測る）

## DO

- **三人称で書くこと。** `Writes and revises a README` のように。description はシステムプロンプトに注入
  されるので、スキルごとに視点が揺れると、その中から選ぶ精度を落とす。
- **スキルが作られた意図を示すこと** — その著者が何を強制したかったのかを、一節で、著者の言葉で。
  たとえば `keeps a callee from branching on which caller invoked it`。すでに動詞がそれを担っているなら、
  独立した節は要らない：`Writes and revises a README` がその意図である。
- **機会を名指しすること**：書かれつつある成果物か、進行中の活動か。
- **発火してはならない条件** — **bound（境界）** — **を、同じ人称で、毎回同じ形で書くこと**：
  `Does not apply when …`。これは、機会が巻き込んでしまうが巻き込むべきでないものを取り戻す — 隣接する
  成果物か、機会の内側にありながら他の誰かに属するケースである。
- **`description` は英語で書くこと。** 本文とスキルの出力が何語であろうと。英語の用語こそが、どの言語で
  打たれようとプロンプトに生き残るものであり、他人がインストールするスキルは、利用者がどの言語を打つか
  知り得ない。一つのチームから決して出ないスキルなら、そのチームが実際に打つフレーズを足してよい。
- **別のスキルがこのスキルの規則を必要とするなら、到達節を足すこと**：「also applies when another skill
  needs …」。スキル名ではなく、その必要を名指しする。
- **1024文字以内に収めること、厳守。** 意図と機会と境界が収まらないなら、そのスキルは仕事を抱えすぎている：
  水増しや切り詰めではなく分割せよ。

## DON'T

- **スキルの実装を要約すること** — 手順、適用する判定基準、そして本文がそれぞれに与える論 — なぜその
  規則が正しいのか、無視すると何を払うのか、代替案は何だったのか。ここに書くと、エージェントはそれをスキル
  そのものとして読み、元になった本文を読み飛ばす。そのスキルが**強制するもの**は残る。それが意図だからで
  ある。作業そのものが使う語も残る。発火させるのはそれだからである。
- **このスキルのものではない概念を説明すること** — callee とは何か、プルリクエストとは何か、なぜ結合が代償を
  伴うのか。ノイズである：エージェントは知っているし、その文字数は意図から差し引かれる。
- **他のスキルを名指しすること。** その名前は他人のファイルへの依存である：相手が改名した日に壊れ、しかも
  それを検査するものは何もない。さらに「*この*成果物は自分のものか」をエージェントに代わって答えてしまう。
  description がそもそも問わせるために存在する問いである。たとえば
  `DO NOT use for an architecture doc (that is write-nice-architecture-docs)`。到達節はその例外である。
  誰も名指ししないからである：「also applies when another skill needs …」。
- **タグ列や、キーワードを詰めた依頼文を書くこと。** `Skill / SKILL.md / description —` は誰が打つものにも
  一致しない。
- **description の本文に山括弧を入れること。** そこでは `<` と `>` はそのまま拒否されるので、タグや
  `<placeholder>` を担った description はそもそもロードされない。YAML の折りたたみブロックを開く `>` は
  frontmatter の一部であって本文ではないので、問題ない。

## The word that fires it（発火させる語）

スキルは、description と、エージェントが手がかりにしているものとの間で共有された語によって発火する：
プロンプトか、プロンプト無しで作業の途中に発火するスキルなら作業そのものである。エージェントがそれに出会う
場所に置くこと：プロンプトが供給するなら先頭に、作業が供給するなら、作業がどう見えるかを示す節の中に。

- **実在の語**：自分のプロンプト、ドキュメント、コードに現れる用語。
- **枝ごとに一つ**：同じ枝を言い換えただけの同義語は重複である。
- **翻訳を生き延びる語**：ファイル名、ツール名、そのまま打ち込む専門用語 — たとえば `SKILL.md`、`issue`、
  `PR`。

## Choosing the lead（どちらを先頭にするか）

**作業はその成果物を名指しするか。**

**名指しする → 機会を先頭に。** 作業がその語を口にし、その語がスキルを発火させる。たとえば issue、README、
`ARCHITECTURE.md`、`SKILL.md`。ここでは先頭がそのまま機会であり、境界がそれを閉じる：

```text
Writes and revises a README, including adding a section to one that already
exists. Does not apply when the artifact is an architecture doc, a SKILL.md,
an issue body, reference documentation, a tutorial, or a changelog.
```

ここでは動詞が意図を担っている：著者が強制したかったのは、まさに README が書かれ、改訂されることである。
だから意図のための独立した節は要らない。

**名指ししない → 何を強制するかを先頭に、`Forces …` で始める。** そのスキルが押し通すもの、そして押し
のける相手があるならそれを。この種の規則そのものを名指しする語は作業の中に無い：プロンプトは機能を求め、
diff は関数を見せ、どちらもどの規則が当てはまるかを言わない — だから先頭に置ける機会が無く、誰も名指し
しない機会は、エージェントが diff の途中で忘れる機会である。作業が供給するのは、その規則が捕まえる**形**であり、その語は
先頭の中の実例に入る。ここでは先頭が来て、次に機会、最後に境界が来る：

```text
Forces the text a stranger can go and check: the rationale a reader who was
never in the room can still trace, never the conversation that produced it, the
review feedback, the discarded alternatives, or a past state the current code
no longer shows. Applies when writing an issue, a PR description, a code
comment, an API or design doc, or any text or code that will be read later.
Does not apply when the reader genuinely can reach the reference but should not
have been sent to it, or when the text is an ephemeral chat reply.
```

先頭の両半分がそろっている — 押し通すテキストと、それが押しのける四種 — そして次に機会が、活動として
名指しされる："writing an issue, a PR description, a code comment …"。境界はそのあと、機会が巻き込む二つの
ケースを取り戻す：読み手が実際に到達できる参照 — これは別の問題である — と、二度と読まれないテキスト。
description はその活動を名指しする。残りのあいだスキルを効かせ続けるのは本文の仕事である。

## The description and the body serve different readers（description と本文は読み手が違う）

`description` は、たった一つの判断 — 発火させるか — のための材料である。本文は、発火したあとに動かなければ
ならない相手にそのスキルを説明する。目的が異なるのだから、両者が同じことを言っている箇所の重なりは意図された
ものである：もう一方が担っていることを理由にどちらかを削れば、二人の読み手の一方が足りなくなる。

重なってよいのは、そのスキルが何のためのものかと、何がそれを呼び込むかである — 発火の判断が走るのはその
二つであり、本文が書き出すのもその二つである。手順と判定基準と論拠は本文だけに留まる。それらを手渡された
エージェントは、行動するのに必要なものを持ってしまい、そこで止まるからである。

## Measuring whether it fires（そもそも発火するかを測る）

スキルに到達されるかどうかは、それ自体の計測である。そこへ到達すべきケースを書き — 利用者が実際に送る
であろうプロンプトをいくつか — そのスキルが走ることになるモデルに対して、まずインストールした状態で、次に
しない状態で走らせること。そうすれば、`description` が到達させたケースと、モデルがもともと処理していた
ケースとを見分けられる。プロンプトの中に何もそれを名指ししないスキルなら、ケースは作業そのもの — diff、下書き、ファイル — であり、
比べ方は同じである。ケースが到達しないスキルは `description` の問題であり、本文を書き直してもそこには
触れない。
