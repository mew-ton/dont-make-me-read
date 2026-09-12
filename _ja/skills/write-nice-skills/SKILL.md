---
name: write-nice-skills
description: >
  スキル、`SKILL.md`、あるいはその description と frontmatter を書き、編集し、レビューする — スキルの
  description と本文を、確実に発火し、かつ軽量であり続けるように書く方法。別のスキルが description の
  書き方や本文のサイズ決めの規則を必要とするときにも適用される。対象がスキル以外のドキュメントであるとき
  は適用しない。
user-invocable: false
disable-model-invocation: false
context: fork
background: false
allowed-tools: []
---

## Overview（概要）

ここで決着するのは、スキルをどう書くかである。`description` は、作業がそれを必要としたときに発火する
ように。本文は、発火のあとも規則が生き残るように。一度も発火しないスキルには効果がなく、発火したうえで
読み飛ばされるスキルにも効果はない — そのどちらも、すでにスキルを読み終えている著者には感じ取れない
テキストによって決まる。

## How to work（どう進めるか）

- **`description` は作業に照らして判断する。** 作業が供給する語で判断すること：スキルに何が書いてあるかを
  知っているのはあなたで、そこへ到達しなければならないエージェントは知らない。
- **このスキルの `scripts/count-tokens.sh` でトークンを数える。** 行数は文字体系によってずれるので、
  本文の予算はトークンで定められている。
- **各規則は、それを所有する reference で決着させる** — 下の表のとおりに。

## Where each decision is settled（どの判断がどこで決着するか）

| 問い | 読むもの |
|---|---|
| `description` が何をしなければならないか、何を決してしてはならないか、どう先頭を決めるか | [`references/writing-descriptions.md`](references/writing-descriptions.md) |
| 直った description はどう見えるか — Bad → Good、各対が何を修復しているか付き | [`references/examples.md`](references/examples.md) |
| 本文がいくらまで許されるか、どの章を持つか、何を reference に置くか、いつ分割するか、スキルをどう効かせ続けるか、ファイルを何と呼ぶか、frontmatter に何を置いてよいか | [`references/structuring-skills.md`](references/structuring-skills.md) |
| ある段階を子スキルとして走らせるべきか、その書き方、その frontmatter に何を置くか | [`references/child-skills.md`](references/child-skills.md) |
| ここでの用語が何を意味するか | [`GLOSSARY.md`](GLOSSARY.md) |

## Common Rationalizations（よくある自己正当化）

エージェントはこのスキルを飛ばす理由を探す：

| 自己正当化 | 実際のところ |
|---|---|
| 「description は短いほうが確実に発火する。」 | 発火は作業と共有された leading word によって起きる。それが無ければ、長さがどうであろうと、そのスキルを作業に結びつけるものは何もない。 |
| 「自己説明的になるよう、手順を description に入れておく。」 | するとエージェントは description から行動し、本文を決してロードしない — あなたが書いた手順は飛ばされる。 |
| 「なぜその規則が重要かを description が説明しないと、誰も本気で受け取らない。」 | 論拠と代償と処方こそがそのスキルである。description に置けば、エージェントは本文がロードされる前に論の全体を手にしてしまい、本文を決してロードしない。 |
| 「使わない場合を述べるのは否定的で、予算の無駄だ。」 | 適用される場合しか名指ししない description は、隣接する成果物にも発火し、誤った発火は毎回、本文まるごとを支払わせる。 |
| 「隣接する成果物を所有するスキルを名指しすれば、振り分けを助けられる。」 | それは、目の前の成果物はこのスキルのものかという、境界がそもそも存在する理由である問いを問わせなくする。そして名指ししたスキルが改名された日にもう一度支払いが来る。 |
| 「1ファイルのほうが分割より単純だ。」 | 肥大した `SKILL.md` は、そのスキルが発火する*たびに*ロードされ、文脈全体を引きずる。 |
| 「今フルのガイドを書いて、後で削る。」 | 削らない。長すぎるスキルは長すぎるまま出荷される。 |
| 「これは自分には良く読める。」 | あなたは読みながら、テキストに欠けている意図を自分で補っている。作業が供給する語と、スクリプトが報告する数字に照らして確認せよ。 |

## Red Flags（危険信号）

- `SKILL.md` だけで著者の問いが片づいてしまい、reference を開く必要がない。
- description が手順、適用する判定基準、あるいは他のスキルの名前を担っている。
- reference が別の reference から到達されている。
- 本文の最初の一文が、そのスキルが何をするかを述べていない。

## Verification（検証）

- [ ] `count-tokens.sh` が、このスキルと、これが並び立つ集合について、`references/structuring-skills.md` の予算を満たしている。
- [ ] description が、適用されるときと適用されないときを、三人称で、1024文字以内で名指ししている。
- [ ] どの reference も `SKILL.md` から直接、明示された条件のもとで到達される。
