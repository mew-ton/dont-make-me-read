# description を書く

スキルの `description` を書く、あるいは書き直すとき、または既存のものが発火するかを判断するときに読むこと。

エージェントがそのスキルを発火させるかどうかを決めるとき、手元にあるのはスキルの `name` と `description`
だけである：本文はまだ文脈に無い。だから `description` はそれ単体で判断可能でなければならない。

## Principles（原則）

**DO**

- **三人称で書くこと。** `Writes and revises a README` のように。description はシステムプロンプトに注入
  されるので、スキルごとに視点が揺れると、その中から選ぶ精度を落とす。
- **英語で書くこと。** 本文とスキルの出力が何語であろうと。英語の用語こそが、どの言語で打たれようとプロンプト
  に生き残るものであり、他人がインストールするスキルは、利用者がどの言語を打つか知り得ない。一つのチームから
  決して出ないスキルなら、そのチームが実際に打つフレーズを足してよい。
- **1024文字以内に収めること** — フィールド自身の上限であり、助言ではなく強制される。下の部品が収まらない
  なら、そのスキルのスコープが広すぎる。

**DON'T**

- **スキルの実装を要約すること** — 手順、適用する判定基準、そして本文がそれぞれに与える論 — なぜその規則が
  正しいのか、無視すると何を払うのか、代替案は何だったのか。ここに書くと、エージェントはそれをスキルそのもの
  として読み、元になった本文を読み飛ばす。
- **このスキルのものではない概念を説明すること** — callee とは何か、プルリクエストとは何か、なぜ結合が代償を
  伴うのか。ノイズである：エージェントは知っているし、その文字数は意図から差し引かれる。
- **他のスキルを名指しすること。** その名前は他人のファイルへの依存である：相手が改名した日に壊れ、しかも
  それを検査するものは何もない。さらに「*この*成果物は自分のものか」をエージェントに代わって答えてしまう。
  description がそもそも問わせるために存在する問いである。たとえば
  `Does not apply when the artifact is an architecture doc (that is write-nice-architecture-docs)`。
- **タグ列や、キーワードを詰めた依頼文を書くこと。** `Skill / SKILL.md / description —` は誰が打つものにも
  一致しない。
- **description の本文に山括弧を入れること。** そこでは `<` と `>` はそのまま拒否されるので、タグや
  `<placeholder>` を担った description はそもそもロードされない。YAML の折りたたみブロックを開く `>` は
  frontmatter の一部であって本文ではないので、問題ない。
- **そのスキルが効力を持ち続けると述べること。** 効力を持ち続けさせるのは本文の `## Persistence` であり、
  この読み手はそもそも本文をロードするかを決めている最中である。この節は、description が読まれるたった一つの
  判断より後に起きることに文字を費やしている。

## The description's shape（description の形）

```text
<機会そのもの、あるいは Forces …>
<意図>
Applies to|when <機会>                      — 冒頭が `Forces …` のとき
Also applies when another skill needs …     — 別のスキルがこの規則を必要とするとき
Does not apply …                            — 機会が巻き込むものがあるとき
```

**作業はその成果物を名指しするか。**

**名指しする → 機会を冒頭に。** 作業がその語を口にし、その語がスキルを発火させる。たとえば issue、README、
`ARCHITECTURE.md`、`SKILL.md`。ここでは冒頭がそのまま機会であり、境界がそれを閉じる：

```text
Runs a determinacy-and-duplication pass over the text of a GitHub issue body
that is already written — someone else's, or the author's own draft. Does not
apply as a general-purpose "review this issue" entry point, when the issue is
still being written or revised, or when what is wanted is a judgement of
repo-groundedness, dependency closure, or scope.
```

**名指ししない → 何を強制するかを冒頭に、`Forces …` として置く。** そのスキルが押し通すもの、そして押し
のける相手があるならそれを。この種の規則そのものを名指しする語は作業の中に無い：プロンプトは機能を求め、
diff は関数を見せ、どちらもどの規則が当てはまるかを言わない — だから機会が冒頭に立てず、誰も名指ししない
機会は、エージェントが diff の途中で忘れる機会である。作業が供給するのは、その規則が捕まえる**形**であり、
作業がその形に使っている語が、冒頭の中の実例に入る：

```text
Forces the text a stranger can go and check: the rationale a reader who was
never in the room can still trace, never the conversation that produced it, the
review feedback, the discarded alternatives, or a past state the current code
no longer shows. Applies when writing an issue, a PR description, a code
comment, an API or design doc, or any text or code that will be read later.
Does not apply when the material is reachable and what it costs is the trip to
it, when the question is an issue body's sections and criteria, or when the text
is an ephemeral chat reply or a working note.
```

## The leading word（発火させる語）

description が、エージェントが手がかりにしているものと共有する語 — プロンプトか、プロンプト無しで作業の
途中に発火するスキルなら作業そのものである。これがスキルを発火させる。プロンプトか作業の中の何かがその成果物
を名指しするなら先頭に置き、何も名指ししないなら、冒頭の中の実例に置くこと。

- **実在する語**：自分のプロンプト、ドキュメント、コードに実際に現れる用語。
- **description が冷えた状態で発火しなければならない枝ごとに、語は一つ**：どの枝がそもそもこのスキルのもの
  かは description を書く前に決着している。そのうちの一つに対する二つ目の近義語は重複であり、スキルが
  ロードされたあとにしか到達しない枝は、ここで名指しせず内側でゲートする。
- **翻訳を生き残る**：ファイル名、ツール名、そのまま打たれる術語 — たとえば `SKILL.md`、`issue`、`PR`。

## Intent（意図）

その著者が何を強制したかったのかを、一節で、著者の言葉で — たとえば `keeps a callee from branching on
which caller invoked it`。すでに動詞がそれを担っているなら、独立した節は要らない：`Writes and revises a
README` がその意図である。

## Occasion（機会）

書かれつつある成果物か、進行中の活動か。作業がそれを名指しするなら description の冒頭に立ち、名指ししない
なら `Forces …` の節に続けて置く。固定なのは `Applies` の語であり、前置詞は機会そのものが取るものに従う —
`Applies when writing an issue`、`Applies to any coding task`。

## Bound（境界）

`Does not apply …`。同じ人称で、毎回同じ語で始める。書くのは、機会が巻き込むべきでないものを巻き込むとき
である。取り戻す対象は、機会が実際に届いてしまう隣接成果物、他の誰かの入口である使い方、機会の内側にあり
ながら他の誰かに属するケース、あるいはそもそも規則が効きようのないケースである。

何も巻き込まないほど狭い機会に境界は要らない：届いたことのない成果物を並べたものは散文のルーティング表で
あり、読み手はその一つ一つに代金を払う。

## Reach clause（到達節）

`Also applies when another skill needs …`。スキル名ではなく、その必要を名指しする。二つ目の入口を開ける
ものであり、この規則を必要とし、さもなければこのスキルを名指しせざるを得ないスキルのためにある。

## The description and the body serve different readers（description と本文は読み手が違う）

`description` は、たった一つの判断 — 発火させるか — のための材料である。本文は、発火したあとに動かなければ
ならない相手にそのスキルを説明する。目的が異なるのだから、両者が同じことを言っている箇所の重なりは意図された
ものである：もう一方が担っていることを理由にどちらかを削れば、二人の読み手の一方が足りなくなる。

重なってよいのは、そのスキルが何のためのものかと、何がそれを呼び込むかである — 発火の判断が走るのはその
二つである。本文の冒頭は一つ目をつねに言い直し、機会は、description だけからは対象の内にいるかが自明でない
ときに、自分の短い節を持つ。手順と判定基準と論拠は本文だけに留まる。それらを手渡されたエージェントは、行動
するのに必要なものを持ってしまい、そこで止まるからである。

## Measuring whether it fires（そもそも発火するかを測る）

スキルが到達されるかどうかは、それ自体が測定の対象である。到達すべきケースを書き — 利用者が実際に送る
プロンプトをいくつか — そのスキルが走ることになるモデルに対して走らせること。まずインストールした状態で、
次にしていない状態で。そうすれば、`description` が到達させたケースと、モデルが元から処理できたケースを
区別できる。プロンプトの中の何もそれを名指ししないスキルなら、ケースは作業そのもの — diff、下書き、
ファイル — であり、比較の仕方は同じである。ケースが到達しないスキルは `description` の問題を抱えており、
本文を書き直してもそこには触れない。
