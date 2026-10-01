# Restating at the point of use（使用地点での言い直し）

書いているものが、理解のために読み手をどこか別の場所へ送っていて — コメント、docstring、PR の説明、別の節に
委ねる節 — その送り先に読み手が到達できるときに読む。テストは `SKILL.md` が持ち、ここはそのケースの規則と
Bad/Good の対を持つ。

読み手が本当に開ける参照であっても、それを辿ることが任意でなかったなら、なお欠陥である：代金を取るのは
事実ではなく往復である。

## When it applies（いつ適用されるか）

どこかへ行かなければ理解できない文のすべてに。次の場合には適用されない：

- 対象がその読み手にとってそもそも存在しない — 会話、削除された宣言、Slack スレッド。言い直すものがなく、
  直し方は削除である。だから、読み手がその対象に到達できるのかを、そこへ送られるべきだったのかを問う前に
  決着させること。
- 同じ内容が一つのドキュメントの中で二度述べられている。読み手はドキュメントを順に読むので、二度目の記述
  が読み手に払わせるのは往復ではなく再読であり、このファイルが扱うのは往復だけである。

## The rules（規則）

- **その事実を使用地点で述べ、原典はその場に残せ。** ファイル先頭の docstring、スキーマ、仕様、config は
  その場に留まり、権威であり続ける。だからこれは足すのではなく引く：読み手は往復をやめ、その往復を説明
  していた2行も一緒に消える。
- **この読み手が行動するために必要な部分を、その仕事を果たす最短の形で持ってこい。** 原典まるごとが使用
  地点へ写されると、取り除いた往復の代わりに読む量が足される。
- **言い直すのは往復を取り除くところだけにせよ。** 足す行の一つずつについて問え：**これは読み手が次に取る
  行動を変えるか？** 隣にあるコードがすでに示していることを繰り返す行や、読み手がそもそも探しに行かな
  かったであろう背景の段落は、読む量を足して往復を取り除かない — 場所を名指しする必要があるなら
  `path:line` を指せ。
- **言い直す行は、その成果物の読者がすでに使っている言語で書け。** 行動する前に翻訳しなければならない行は、
  場所を変えただけの往復である。

## Common Rationalizations（よくある自己正当化）

| 自己正当化 | 実際のところ |
|---|---|
| 「言い直すと信頼できる唯一の情報源が重複する。」 | 唯一の情報源は動かない — その場に留まり、権威であり続ける。ここに来るのはこの読み手が行動するために必要な部分であって、全体の二つ目のコピーではない。 |
| 「使用地点の文脈は多いほうが常に安全だ。」 | それが往復を取り除くときだけ。隣のコードがすでに示していることを繰り返す行は、読む量を足して何も節約しない。削る行だけでなく、足すすべての行にテストを走らせよ。 |

## Red Flags（危険信号）

- 隣のコードがすでに示しているのに言い直していて、行を足して往復を減らしていない。
- この読み手が必要とする部分ではなく、原典まるごとが使用地点へ写されている。

## Verification（検証）

- [ ] 残っているポインタはどれも、読み手が辿らないと決めても行動できるものである。
- [ ] 原典はその場にあり、権威のままである。

## Worked examples（実例）

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

### Good: シグネチャに述べる
```typescript
/**
 * @param discountCode 5-8 uppercase alphanumeric characters, optional campaign-tag prefix.
 */
export function validateDiscountCode(discountCode: string): boolean {
  return DISCOUNT_CODE_PATTERN.test(discountCode);
}
```

ルールは呼び出し元にまで届き、関数を開かなくてもホバーで見える — 本体の中のコメントなら、それを読む
ためにここまで来させることになる。

### Good: 複数の関数が受け取るなら型に置く
```typescript
/** 5-8 uppercase alphanumeric characters, optional campaign-tag prefix. */
type DiscountCode = string;

export function validateDiscountCode(code: DiscountCode): boolean {
  return DISCOUNT_CODE_PATTERN.test(code);
}
```

一度述べれば、その型が使われるすべての場所に届く。どちらもファイルレベルの docstring はそのまま。

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
