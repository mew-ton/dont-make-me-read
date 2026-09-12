---
name: write-nice-skills
description: >
  スキル、`SKILL.md`、あるいはその description と frontmatter を書き、編集し、レビューする — スキルの
  description と本文を、確実に発火し、かつ軽量であり続けるように書く方法。別のスキルが description の
  書き方やスキルの長さの規則を必要とするときにも適用される。対象がスキル以外のドキュメントであるとき、
  あるいはリポジトリ全体のレビューパスであるときは適用しない。
user-invocable: false
disable-model-invocation: false
context: fork
background: false
allowed-tools: []
---

## Overview（概要）

一度も発火しないスキルには効果がなく、発火したうえで読み飛ばされるスキルにも効果はない — そのどちらも、
著者には感じ取れないテキストによって決まる。だから規則はここに無い：このファイルが振り分ける先の reference
にある。

## How to work（どう進めるか）

- **description は、自分のスキル要約ではなく作業に照らして確認する。** あなたはトリガーではない。
- **推定せず、計測する。** バイト数も行数も、モデルとともにずれる代理指標である。
  `scripts/count-tokens.sh` はずれない。
- **reference を開く。** このファイルだけで規則を決着させようとしているなら、それは上に書いた失敗が、
  あなた自身に起きている。

## Where each decision is settled（どの判断がどこで決着するか）

| 何を決めているか | 読むもの |
|---|---|
| `description` — 何をすべきか、何を決してしてはならないか、どちらを先頭にするか | [`references/writing-descriptions.md`](references/writing-descriptions.md) |
| description が本当に直ったか — Bad → Good、各対が何を修復しているか付き | [`references/examples.md`](references/examples.md) |
| 本文のサイズ、何を reference に置くか、いつ分割するか、スキルをどう効かせ続けるか | [`references/structuring-skills.md`](references/structuring-skills.md) |
| ある段階を子スキルとして走らせるべきか、そしてその書き方 | [`references/child-skills.md`](references/child-skills.md) |
| ファイルが、それをロードするモデルに実際いくら課すのか | [`references/structuring-skills.md`](references/structuring-skills.md#measuring-the-token-half-of-that-budget)（[`scripts/count-tokens.sh`](scripts/count-tokens.sh) を走らせる） |
| ここでの用語の意味 — leading word、trigger、branch、progressive disclosure、context pointer | [`GLOSSARY.md`](GLOSSARY.md) |

## Frontmatter

コメントなしで書くこと。それは `SKILL.md` の中で読まれるのではなくパースされる部分であり、そのすべてが
発火のたびにロードされる。本当に説明を要するフィールドは、著者が反論できる散文での説明を要する — 本文か、
アーキテクチャドキュメントで — 将来のすべての読み手が代金を払う末尾の `#` ではない。

これは routing ではなくここに直接書かれた唯一の規則である：frontmatter は自分の reference を持たず、
そしてこれがその全部だからである。

## Common Rationalizations（よくある自己正当化）

エージェントはこのスキルを飛ばす理由を探す。そしてこの防壁はここに無ければ、他のすべてと一緒に飛ばされる：

| 自己正当化 | 実際のところ |
|---|---|
| 「description は短いほうが確実に発火する。」 | 発火するのは*共有された語*によってであって、簡潔さによってではない。作業が供給する leading word がなければ決して結びつかない — 長さはレバーではない。 |
| 「自己説明的になるよう、手順を description に入れておく。」 | するとエージェントは description から行動し、本文を決してロードしない — あなたが書いた手順は飛ばされる。 |
| 「なぜその規則が重要かを description が説明しないと、誰も本気で受け取らない。」 | 論拠と代償と処方こそがそのスキルである。本文がロードされる前に読まれる場所に置けば、エージェントはすでにそれを手渡されている。 |
| 「使わない場合を述べるのは否定的で、予算の無駄だ。」 | 境界のない `when` は隣接する成果物すべてに発火し、誤った発火は毎回、本文まるごとを支払わせる。 |
| 「もう一方の成果物を所有する兄弟スキルを名指しすれば、振り分けを助けられる。」 | それは*この*成果物は自分のものかという、境界がそもそも存在する理由である問いを問わせなくする。そしてそのスキルが改名された日にもう一度支払いが来る。 |
| 「1ファイルのほうが分割より単純だ。」 | 肥大した `SKILL.md` は、そのスキルが発火する*たびに*ロードされ、文脈全体を引きずる。 |
| 「今フルのガイドを書いて、後で削る。」 | 削らない。長すぎるスキルは長すぎるまま出荷される。 |
| 「これは自分には良く読める。」 | あなたは判断する読み手ではない。作業が供給する語と、スクリプトが報告する数字に照らして確認せよ。 |

## Red Flags（危険信号）

- `SKILL.md` だけで決着した規則があり、その出所の reference は一度も開かれていない。
- description が手順、適用する判定基準、あるいは他のスキルの名前を担っている。
- reference が別の reference から到達されている。
- 本文が「このスキルは何でないか」から始まっている。

## Verification（検証）

- [ ] `count-tokens.sh` が、そのスキルと、それが同時に立つ集合について0で終了する。
- [ ] description が機会と境界を、三人称で、1024文字以内で名指ししている。
- [ ] どの reference も `SKILL.md` から直接、明示された条件のもとで到達される。
- [ ] そのスキルに到達すべきケースを、実際に走らせた。
