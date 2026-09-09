---
name: write-nice-skills
description: >
  SKILL.md オーサリング — スキルの description と本文を、確実に発火し、かつ軽く保たれるように
  書く方法。スキル、SKILL.md、その description や frontmatter を書く／編集する／レビューするときに
  使う。別のスキルが description の書き方やスキルの長さのルールを必要とするときにも該当する。
  DO NOT スキル以外のドキュメントには使わない。汎用のリポジトリレビューのパスを走らせるのにも使わない。
user-invocable: false
disable-model-invocation: false
context: fork
background: false
allowed-tools: []
---

## Scope（範囲）

このスキルは **`SKILL.md` をオーサリングすること**についてのものである — スキルの `description` と本文を、
(a) 発火すべきときに発火し、(b) ロードする価値があるほど軽く保たれるように書き、レビューすること。新しい
スキルを作るときにも、既存のものを編集するときにも適用される。

これは汎用のリポジトリレビューのパス**ではない** — PRに対してチェックリストを走らせるのは別の仕事である。
公開／frontmatter のポリシー文書**でもない**。そしてスキル以外のドキュメントのためのものでもない。この
スキルは、それらの上に座る常時オンのオーサリング判断である。

詳細は一段下にある（[References](#references) を参照）。このファイルは、どの枝にいようとすべての著者が
必要とするものを担う。

## Why the description carries the weight（なぜ description が重みを担うのか）

エージェントがスキルをロードするかどうかを決めるとき、それが読むテキストは `description` **だけ**である。
本文はまだ文脈になく、スキルが発火した**後で**ロードされる。したがって description は、二つの負荷のかかる
仕事を同時にこなす：

1. エージェントが *このスキルが該当するかどうか* を description だけから判断できなければならない。
2. 手順を漏らしては**ならない**。手順が description にあると、エージェントは本文をロードせずに行動できると
   信じ込み、そのスキルが届けるために存在するまさにその指示を飛ばす。

「Writing the description」以下のすべては、この一つの事実から導かれる。

## Principles（原則）

**Description**（詳細＋Bad/Good の実例：
[`references/writing-descriptions.md`](references/writing-descriptions.md)）：

1. **三人称、what + when。** そのスキルが何をするか、いつ適用するかを述べ、description だけから判断できる
   ようにする。
2. **手順を書かない。** 手順を追った指示を description に決して置かない。手順は本文に住む。
3. **leading word を前に出す。** このスキルが必要とされるときに現れる語を先頭付近に置く — description と、
   エージェントが取り組んでいるものとの間で共有される語こそが、両者を結びつけてスキルを発火させる。人が
   頼むときはそれがプロンプトであり、`/` メニューから隠されたスキルにとっては**作業そのもの**である。
   スラッシュ区切りのタグ列でもなく、飾り立てた依頼文でもなく、自然な文の中にある leading word。枝ごとに
   トリガーを一つ（同義語の水増しはしない）。本文がすでに担っている素性は削る。
4. **英語。** どの言語でプロンプトを打とうと description は英語で書き、第二言語のキーワード列で水増ししない。
   スキルが**エージェントに何を書けと指示するか**は別の問いであり、各 writing スキルが自分で答える。

**Body**（詳細＋基準：
[`references/structuring-skills.md`](references/structuring-skills.md)）：

5. **全部書かない。** 本文をサイズ予算の中に保ち、枝に固有の詳細は本文が指すファイルへ一段押し下げる。
   すべての経路が必要とするものをインラインにし、一部の枝しか到達しないものはポインタの後ろに置く。
6. **Common Rationalizations を足す。** エージェントが手を抜きそうなスキルには、その言い訳を先回りして
   封じる（下の表を参照）。

上で使った用語（leading word、trigger、branch、progressive disclosure、context pointer）は
[`GLOSSARY.md`](GLOSSARY.md) で定義されている。

## Common Rationalizations（よくある自己正当化）

エージェントはこのスキルを飛ばす理由を探す。それらを封じよ：

| 自己正当化 | 実際のところ |
|---|---|
| 「description は短いほうが確実に発火する。」 | 発火するのは*共有された語*によってであって、簡潔さによってではない。プロンプトが共有する leading word がなければ、決して結びつかない — 長さはレバーではない。 |
| 「自己説明的になるよう、手順を description に入れておく。」 | するとエージェントは description から行動し、本文を決してロードしない — あなたが書いた手順は飛ばされる。手順は本文に留めよ。 |
| 「1ファイルのほうが分割より単純だ。」 | 肥大した `SKILL.md` は、そのスキルが発火する*たびに*全部ロードされ、文脈全体を引きずる。枝でしか使わない詳細はポインタの後ろへ押し出せ。 |
| 「今フルのガイドを書いて、後で削る。」 | 削らない。長すぎるスキルは長すぎるまま出荷される。書きながら予算まで削れ。 |
| 「この description は自分には良く読める。」 | あなたはトリガーではない。自分の要約に照らすのではなく、*ユーザー*が打つ語に照らして確認せよ。 |

## References（参照）

- **description / frontmatter** を書く／直す →
  [`references/writing-descriptions.md`](references/writing-descriptions.md)
- **本文のサイズ、references、いつ分割するか**を決める →
  [`references/structuring-skills.md`](references/structuring-skills.md)
- ファイルの実際の**トークンコスト**と、目指すべきバイト閾値を測る →
  [`references/structuring-skills.md`](references/structuring-skills.md#measuring-the-token-half-of-that-budget)
  （[`scripts/count-tokens.sh`](scripts/count-tokens.sh.md) を実行する）
- 用語（leading word / trigger / branch / progressive disclosure / context pointer）
  → [`GLOSSARY.md`](GLOSSARY.md)
