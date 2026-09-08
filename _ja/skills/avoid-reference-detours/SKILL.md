---
name: avoid-reference-detours
description: >
  読み手が本当に開ける参照であっても、それをたどることが選択肢でなかったのなら、それは依然として欠陥
  である — 「このファイル冒頭のフォーマット規則」と書くドキュメントコメント、「config と同じ」と書く
  注記、同じ文書の別セクションに委ねるセクション。この読み手が必要とするものを、必要とする地点で
  言い直し、原典はその場に残すこと。彼らにコストを払わせているのは往復であって、事実ではない。
  コードコメント、docstring、PR説明文、あるいは理解されるために他所を指すあらゆるテキストを書くときに
  適用する。DO NOT 対象がそもそも存在しない／まったく到達できない場合には使わない（それは
  avoid-unverifiable-context）。また一つの文書の中で同じ内容が二度書かれている場合にも使わない
  （それは write-nice-issue-description の Gate 2）。
user-invocable: false
disable-model-invocation: false
allowed-tools: []
---

## Scope（範囲）

到達可能性はテストのすべてではない。ポインタは完全に妥当でありうる — そのファイルは本当に冒頭にその
ルールを持っているし、config は本当にそう言っている — それでも書くべきものではない。読み手は目の前の
文を理解するために、その場を離れなければならなかったからだ。

二つの問い。このスキルのものは二つ目だけ：

| 問い | Skill |
|---|---|
| 読み手はこれが指すものを確認しに行けるか？ | `avoid-unverifiable-context` |
| そもそも読み手は、それを理解するためにここを離れなければならなかったのか？ | このスキル |

一つ目は、対象がこの読み手にとって存在しないときに不合格になる — 会話、削除された宣言、Slack スレッド。
言い直す対象がないので、直し方は削除。このスキルはその問いを通過して初めて適用される。

## The rule（ルール）

**使用される場所で述べよ。原典はその場に残せ。**

原典 — ファイル先頭の docstring、スキーマ、仕様、config — はその場に留まり、権威であり続ける。使用地点に
来るのはそのコピーではなく、**この読み手が行動するために必要な部分**であり、その仕事を果たす最短の形で
ある。だからこれは足すのではなく引く。読み手は往復をやめ、その往復を説明していた2行も一緒に消える。

## This is not a licence to add（これは追加の許可証ではない）

言い直しが1行分の価値を得るのは、それが往復を取り除くときだけ。足す前に、このセットの他のすべてが走らせる
のと同じテストを走らせること：

> **これは読み手が次に取る行動を変えるか？**

隣にあるコードがすでに示していることを繰り返す行は、読む量を足して往復を取り除かない — 不合格。読み手が
そもそも探しに行かなかったであろう背景の段落も同じ。二つの方向は二つのルールではなく一つ：

| 状況 | 読み手が払うもの | 書くこと |
|---|---|---|
| 事実が他所にあり、取りに行かねばならない | 往復 | その事実を、ここに |
| 事実がすでに目の前にある（差分、次の行のコード） | 再読 | 何も。名指しが必要なら `path:line` を指す |

`write-nice-instructions` の「読み手はそれを持っている — 代わりに `path:line` を指せ」は二行目のほう。
どちらの行も、読み手が通過する量から引き算している。

## Where this ends and duplication begins（これがどこで終わり、重複がどこから始まるか）

一つの文書の中では読み手は順に読むので、同じ内容の二度目の記述は**再読**である — それは
`write-nice-issue-description` の Gate 2 であり、そこで禁じられている。文書、ファイル、セクションを
またぐ場合は読み手が移動しなければならず、その往復は言い直しよりコストが高い。このスキルが統べるのは
二つ目のケースだけ。2セクション下で繰り返される段落は Gate 2 のものであって、このスキルのものではない。

## Language（言語）

言い直す行は、その成果物の読者がすでに使っている言語で書く。このスキルは事実が**どこに**座るかについて
のものであって、どの言語がそれを述べるかについてのものではない。

## Common Rationalizations（よくある自己正当化）

| 自己正当化 | 実際のところ |
|---|---|
| 「到達できるのだから、そこを指すので十分だ。」 | 到達可能性はもともと問題ではなかった。そこへ送られたことが問題だった。読み手がこのコメントやセクションを離れないと意味が取れないなら、ここで述べよ。 |
| 「言い直すと信頼できる唯一の情報源が重複する。」 | 唯一の情報源は動かない — その場に留まり、権威であり続ける。ここに来るのはこの読み手が行動するために必要な部分であって、全体の二つ目のコピーではない。 |
| 「使用地点の文脈は多いほうが常に安全だ。」 | それが往復を取り除くときだけ。隣のコードがすでに示していることを繰り返す行は、読む量を足して何も節約しない。削る行だけでなく、足すすべての行にテストを走らせよ。 |
| 「自分には問題なく読める。」 | あなたはポインタの先に何があるかすでに知っているので、その往復はあなたには無料である。それを払うのは読み手のほうだ。 |

## Examples（実例）

### Bad: ファイル冒頭へ読み手を送る
```typescript
/** Discount codes are 5-8 uppercase alphanumeric characters, optional campaign-tag prefix. */

export function validateDiscountCode(code: string): boolean {
  // Validation here follows the format rules described at the top of this file.
  return DISCOUNT_CODE_PATTERN.test(code);
}
```

ファイルレベルの docstring は実在し、同じファイルの中にあるので、到達不能なものは何もない。それでも
不合格である。`validateDiscountCode` を確認している読み手は、パターンが何を受け付けるのかを知るために
ヘッダを開きに行かねばならない。

### Good: 使用地点で述べる
```typescript
export function validateDiscountCode(code: string): boolean {
  // Discount codes: 5-8 uppercase alphanumeric characters, optional campaign-tag prefix.
  return DISCOUNT_CODE_PATTERN.test(code);
}
```

ルールは使われている場所に座り、ポインタ付きの版より読むのが短い。ファイルレベルの docstring は
そのまま。

### Bad: 散文で書かれた issue 横断の注記
```markdown
The retry path is being handled in another issue and is not implemented yet.
```
（訳：リトライ経路は別の issue で対応中で、まだ実装されていない。）

### Good: 何を読めばよいかを名指しする注記を、それが関わるコードのところに
```typescript
// TODO(#456): retries for combined promo codes are not implemented yet.
```

`TODO(#456)` は読み手がぶつかる地点で境界を述べており、行動するのに往復を要しない — 読み手は #456 を
開こうと開くまいと、ここで止まると分かる。

## Related skills（関連スキル）

- `avoid-unverifiable-context` — 同じ分割のもう半分。対象がこの読み手にとってそもそも存在しないので、
  直し方は言い直しではなく削除。
- `write-nice-issue-description` — Gate 2 が一つの文書の**内部**の繰り返しを所有する。
- `review-self-contained-docs` — 書かれたテキストを、読み手の側から、単位ごとに両方に照らして監査する。
