# Worked examples（実例）

目の前のケース — ファイル先頭の記述に委ねている doc コメント、散文で書かれた issue 横断の注記 — の
対比が欲しいときに読む。ルールは `SKILL.md` が持ち、ここは Bad/Good の対を持つ。

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
