---
name: write-nice-skills
description: >
  スキル、`SKILL.md`、あるいはその description と frontmatter を書き、編集し、レビューする — スキルの
  description と本文を、確実に発火し、かつ軽量であり続けるように書く方法。別のスキルが description の
  書き方や本文のサイズ決めの規則を必要とするときにも適用される。対象がスキルでないときは適用しない。
user-invocable: false
disable-model-invocation: false
context: fork
background: false
allowed-tools: []
---

## Overview（概要）

ここで決着するのは、スキルをどう書くかである。`description` は、エージェントがそもそもそのスキルに手を
伸ばすかどうかを決める。本文は、手を伸ばされたあとを生き延びなければならない。何にも到達されないスキルには
効果がなく、到達されたうえで読み流されるスキルにも効果はない。

## How to work（どう進めるか）

- **`description` は作業に照らして判断する。** 作業が供給する語で判断すること：スキルに何が書いてあるかを
  知っているのはあなたで、そこへ到達しなければならないエージェントは知らない。
- **このスキルの `scripts/count-tokens.sh` でトークンを数える。** 行数は文字体系によってずれるので、
  本文の予算はトークンで定められている。
- **各規則は、それを所有する reference で決着させる** — 下の表のとおりに。

## Where each decision is settled（どの判断がどこで決着するか）

| 問い | 読むもの |
|---|---|
| `description` が何をしなければならないか、何を決してしてはならないか、どう先頭を決めるか、本文とどう分担するか、発火するかをどう試すか | [`references/writing-descriptions.md`](references/writing-descriptions.md) |
| 直った description はどう見えるか — Bad → Good、各対が何を修復しているか付き | [`references/examples.md`](references/examples.md) |
| 本文がいくらまで許されるか、どの章を持つか、何を書かないか、何を reference に置くか、いつ分割するか、スキルをどう効かせ続けるか、ファイルを何と呼ぶか、frontmatter にコメントを入れてよいか | [`references/structuring-skills.md`](references/structuring-skills.md) |
| ある段階を子スキルとして走らせるべきか、それを何と呼ぶか、その書き方、その frontmatter に何を置くか | [`references/child-skills.md`](references/child-skills.md) |
| ここでの用語が何を意味するか | [`GLOSSARY.md`](GLOSSARY.md) |

## Common Rationalizations（よくある自己正当化）

エージェントはこのスキルを飛ばす理由を探す：

| 自己正当化 | 実際のところ |
|---|---|
| 「description は短いほうが確実に発火する。」 | 発火は作業と共有された語によって起きる — プロンプトが供給する語か、作業そのものがすでに使っている語である。それが無ければ、長さがどうであろうと、そのスキルを作業に結びつけるものは何もない。 |
| 「自己説明的になるよう、手順を description に入れておく。」 | するとエージェントは description から行動し、本文を決してロードしない — あなたが書いた手順は飛ばされる。 |
| 「なぜその規則が重要かを description が説明しないと、誰も本気で受け取らない。」 | そのスキルが**何を**強制するかは description に属する。それを強制するのが*なぜ*正しいのか — 論拠、代償、代替案 — は本文のものである。両方を手渡されたエージェントは description から行動し、本文を決してロードしない。 |
| 「使わない場合を述べるのは否定的で、予算の無駄だ。」 | 適用される場合しか名指ししない description は、隣接する成果物にも発火し、誤った発火は毎回、本文まるごとを支払わせる。 |
| 「隣接する成果物を所有するスキルを名指しすれば、振り分けを助けられる。」 | それは「この成果物は自分のものか」に答えてしまい、エージェントはもう問わなくなる — そしてそれは、description がそもそも問わせるために存在する唯一の問いである。さらに他のスキルの名前を自分の description に書き込むことになり、相手が改名された日に、こちらが黙って誤りになる。 |
| 「1ファイルのほうが分割より単純だ。」 | 肥大した `SKILL.md` は、そのスキルが発火する*たびに*ロードされ、文脈全体を引きずる。 |
| 「今フルのガイドを書いて、後で削る。」 | 削らない。長すぎるスキルは長すぎるまま出荷される。 |
| 「これは自分には良く読める。」 | あなたは読みながら、テキストに欠けている意図を自分で補っている。作業が供給する語と、スクリプトが報告する数字に照らして確認せよ。 |

## Red Flags（危険信号）

- reference を一つも開かずに、著者がスキルを仕上げられてしまう `SKILL.md`。
- description が手順、適用する判定基準、あるいは他のスキルの名前を担っている。
- reference が別の reference から到達されている。
- 本文の最初の一文が、そのスキルが何をするかを述べていない。

## Verification（検証）

- [ ] いま書いているスキルと、それが並び立つ集合について、トークン数が `references/structuring-skills.md` の予算の内側にある。
- [ ] description が `references/writing-descriptions.md` の DO の各項目を満たし、DON'T のどれにも当たらない。
- [ ] どの reference も `SKILL.md` から直接、明示された条件または問いのもとで到達される。
