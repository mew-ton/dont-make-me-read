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
