# 実例

各条件についての Bad/Good の対、コメントがまったくない best case、そして差分がないと示せない二つの抽出の
エッジケース。単位を判断していて、自分の考えを既知の良いケースに照らして確認したいときに読むこと。

## 条件1: time-closure

### Bad: 完了した移行を語っている
```typescript
export function fetchOrder(id: string): Promise<Order> {
  // Used to call the legacy v1 billing API, but we migrated to v2 last quarter.
  return billingApiV2.get(`/orders/${id}`);
}
```
（訳：コメント＝「かつてはレガシーの v1 課金APIを呼んでいたが、前四半期に v2 へ移行した。」）

過去の状態（v1 を呼んでいること）を記述しているが、コードは v2 しか示しておらず、コメントの主張に対応する
ものが何もない。読み手が検証できるものはここに何もない — コードがもはや含まない歴史を語っている。

**Finding**：`fetchOrder` のドキュメントは、すでに完了した移行を記述しており、読み手がそれを照合できる
ものが現在のコードに何もない — コメントを削除せよ。それが記述しているコード（v1 APIの呼び出し）は消えて
いる。

### Bad: それ以外は妥当なコメントの中に隠れた歴史の節
```typescript
type RoleLevelFilter = {
  // Role level, string id. Was declared `number`, but the runtime value was always a string
  // wearing a `number` type — the option ids it's matched against are strings and nothing
  // coerces them. Corrected here so the value's type matches what it actually holds.
  roleLevel: string;
};
```
（訳：コメント＝「ロールレベル、文字列ID。以前は `number` と宣言されていたが、実行時の値は常に `number`
型をまとった文字列だった — 突き合わせるオプションIDは文字列で、何もそれらを型変換しない。値の型が実際に
保持しているものと一致するよう、ここで修正した。」）

このコメントのほとんどは現在形でチェック可能である — `roleLevel` は `string` であり、コードがそれを裏づけ
る。しかし「以前は `number` と宣言されていたが、実行時の値は常に `number` 型をまとった文字列だった」は、
このコードのどこにももはや存在しない宣言を語っており、読み手がそれを照合できるものは何も残っていない —
上の移行の例と同じ失敗である。単位は、その節の大半が問題ないという理由で合格を得たりしない：すべての節が
判断され、一つ落ちれば単位全体が落ちるのに十分である。

**Finding**：`roleLevel` のドキュメントは、コードにもはや存在しない以前の `number` 宣言を語っており、
照合するものが何も残っていない — その歴史の節（「Was declared `number`...」）を削除せよ。現在形の理由づけは、
それが他の二つの条件を独立に通る場合にのみ残す。

### Good: 現在の制約を、過去形も込みで述べている
```typescript
export function fetchOrder(id: string): Promise<Order> {
  // Calls the endpoint synchronously because the legacy billing API does not
  // support batching yet.
  return billingApi.get(`/orders/${id}`);
}
```
（訳：コメント＝「レガシー課金APIがまだバッチ処理に対応していないので、このエンドポイントを同期的に
呼んでいる。」）

過去を参照しているが（「まだ対応していない」）、その主張 — 呼び出し先APIの制約に駆動された同期呼び出し —
はコードに照らしてチェック可能であり、コードがそれを裏づける：素の同期的な `.get()`。このコメントが記述
している時間は「今」である。findings なし。

## 条件2: referenceability

### Bad: 何を開けばよいか読み手に判別できないほど曖昧な参照
```typescript
export function applyDiscount(price: number, codes: string[]): number {
  /** Discount stacking rules are documented in the pricing team's Notion (issue: 1234) */
  return codes.reduce((p, c) => stackingEngine.apply(p, c), price);
}
```
（訳：コメント＝「割引の重ね掛けルールは価格チームの Notion に記載されている（issue: 1234）」）

「Notion (issue: 1234)」は、`1234` がそもそもどのシステムに属するのかを語っていない — Notion のページID？
GitHub issue？ Jira チケット？ これは到達可能性が問いになる前に落ちる：読み手は、どの成果物へのアクセスが
必要になるのかすら判別できない。

**Finding**：`applyDiscount` のドキュメントは「Notion (issue: 1234)」を参照しているが、それがどのシステム／
成果物なのかを述べていない — コメントを削除せよ。

### Good: 何をどこで読めばよいかを名指しする TODO
```typescript
export function applyDiscount(price: number, codes: string[]): number {
  // TODO(#456): stacking rules for combined promo codes are not yet defined.
  return codes.reduce((p, c) => stackingEngine.apply(p, c), price);
}
```
（訳：コメント＝「TODO(#456): 複合プロモコードの重ね掛けルールは未定義。」）

短い `TODO(#456)` は、何をどこで読めばよいかを正確に名指ししている — この条件が許す唯一の例外。
findings なし。

## 条件3: reference-scope closure

### Bad: ファイル冒頭へ読み手を送る
```typescript
/** Discount codes are 5-8 uppercase alphanumeric characters, optional campaign-tag prefix. */

export function validateDiscountCode(code: string): boolean {
  // Validation here follows the format rules described at the top of this file.
  return DISCOUNT_CODE_PATTERN.test(code);
}
```
（訳：ファイル冒頭＝「割引コードは5〜8文字の大文字英数字、任意でキャンペーンタグの接頭辞。」／関数内＝
「ここでのバリデーションはこのファイル冒頭に記述されたフォーマット規則に従う。」）

ファイルレベルの docstring は実在し到達可能である — 同じファイルの中にある — ので、referenceability は通る。
それでも reference-scope closure で落ちる：`validateDiscountCode` を確認している読み手は、パターンが何を
受け付けるはずなのかを知るために、ファイルのヘッダコメントを開きに行かねばならない。到達可能性はもともと
問題ではなかった。そこへ送られたことが問題だった。

**二つの事実**、分けて保つ（擁護できる修正と未解決の隙間は異なる種類の主張である）：

(a) `validateDiscountCode` のドキュメントは、ルールをここで述べる代わりに読み手をファイル冒頭の docstring へ
送っている — コメントを削除せよ。

(b) 割引コードのフォーマット（5〜8文字の大文字英数字、任意のキャンペーン接頭辞）が使用地点で表現されて
いない — `validateDiscountCode` だけを読む者には、`DISCOUNT_CODE_PATTERN` が実際に何を受け付けるのか判別
できない。ここで修正は名指ししない。必要であることだけを述べる：正規表現の隣でフォーマットを述べ直すか、
正規表現をルールが自明になる名前付きの部品に置き換えるか（例えばパターンの構成要素ごとに文書化された
定数）。

### Good: 使用地点でルールを述べる
```typescript
export function validateDiscountCode(code: string): boolean {
  // Discount codes: 5-8 uppercase alphanumeric characters, optional campaign-tag prefix.
  return DISCOUNT_CODE_PATTERN.test(code);
}
```

ルールは今や使われている場所に座っている。読み手はもう、パターンが何を受け付けるはずなのかを知るために
この関数を離れる必要がない。findings なし。

## Best: コメントがない。必要ないから

```typescript
export function isEven(n: number): boolean {
  return n % 2 === 0;
}
```

ここでは単位すら抽出されない — 手順2はコメントを始める行だけを引き出し、そのような行は存在しない。その不在は
埋めるべき隙間ではない。それはこのスキルが目指す最良の結果である。`return n % 2 === 0` がすでに述べている
ことを言い直すインラインコメント（`// return true if n is even`）は三つの条件すべてを通り、それでもないより
悪い：読み手はそれを読むコストを払い、コードですでに見えていた以上のことを何も学ばない。**既存の**コメントが
自己完結しているかを判断するのはこのスキルの仕事だが、そのようなインラインコメントがそもそも存在すべきかは
別の問いであり、このスキルはそれに答えない。エクスポートされた関数の宣言レベルのドキュメントコメントは
さらに別の問いである — 呼び出し元はソースを開く代わりにホバーでそれを読むので、そこではある程度の言い直しが
正当化されうる。どちらにせよ findings なし。

## 抽出のエッジケース1: 変更された行が、変更されていない行を誤誘導する

上の三つの条件は素のコードとして示せるが、こちらは本質的に差分についてのもの — 何が変わったか、そして
そのせいで変更されていない隣接行が今や何を意味するのか。

**Diff (`src/analytics/types.ts`)**

```diff
 /**
- * The resolved path. **Query string is not included** (`resolvePath` drops it).
+ * The resolved path and its query string. **Hash is not included.**
+ *
+ * The query is passed through `resolvePath` unchanged; only key order is stabilized.
  * See the comment in this file for why.
  */
 path: string;
```
（訳：削除行＝「解決済みのパス。**クエリ文字列は含まれない**（`resolvePath` が落とす）。」／追加行＝
「解決済みのパスとそのクエリ文字列。**ハッシュは含まれない。**」「クエリは `resolvePath` を無変更で
通過する。キー順序のみが安定化される。」／変更なしの行＝「理由についてはこのファイル内のコメントを見よ。」）

**抽出される単位**：4行すべてを一つの段落として。「See the comment in this file for why.」は `+`/`-` の印を
持たないので、差分だけを見るパスは飛ばしてしまう — しかしそれは、変更された行が開く段落の文法的な結びの文で
あり、それが指し示すものも一緒に変わっている。

条件1と2は通る — 段落は現在のフィールドを記述しており、「このファイル内のコメント」は到達可能に聞こえる。
条件3は落ちる。しかも通常より悪い：このドキュメントが直接述べられる事実のために読み手を他所へ送ることが
すでにスコープ違反であるうえに、ここではそのポインタ自体が誤っている — 実際の理由づけは
`src/analytics/resolvePath.ts` という別のファイルにある。書かれたとおり字義どおりにポインタをたどった読み手は、
そこで何も見つけられない。

**二つの事実**（条件3のいつもの形。場所の誤りは (a) の問題の一部であって、別個の事実ではない）：

(a) `types.ts` の `path` に対するドキュメントは、理由づけが「このファイル内」にあると述べているが、実際には
`resolvePath.ts` にある — ポインタをたどった読み手は何も見つけられない。正しいファイルを名指しするよう
ポインタを直すか、削除して理由（クエリは保持、ハッシュは削除）をここで直接述べよ。

(b) `path` が何を含むかの契約が、その使用地点で表現されていない。修正は名指ししない。このフィールドの
ドキュメントは、別のファイルをまったく開くことなく単体で読めるべきである — それが開いたままの隙間である。

## 抽出のエッジケース2: docstring が、それが座っているのとは別の宣言を記述している

これは条件3の違反ではない — 下のテキストのどこにも、読み手をどこかへ送るものはない。docstring は正確で、
完全で、まさにそれがある場所で到達可能である。誤りはもっと早く、手順2で起きている：書いた者は
`validateDiscountCode` を記述するつもりだったが、それが物理的に座っている行は別の宣言である。

```typescript
/** Discount codes are 5-8 uppercase alphanumeric characters, optional campaign-tag prefix. */
const VALIDATE_CODE_REGEX = /^[A-Z0-9]{5,8}$/;

export function validateDiscountCode(code: string): boolean {
  return VALIDATE_CODE_REGEX.test(code);
}
```

**抽出される単位**：手順2の既定ルール（物理的に座っている宣言）により、docstring ＋ `VALIDATE_CODE_REGEX`。
その単位だけで判断すると、ここには三つの条件のいずれの違反もない — テキストは `VALIDATE_CODE_REGEX` の
フォーマットについて真であり、それがある場所でローカルかつ到達可能である。findings は三つの条件からではなく、
手順2の内容チェックから来る：この契約を必要とするのは `validateDiscountCode` の呼び出し元であり
（エクスポートされているのはこちらの関数で、正規表現はその実装にすぎない）、その関数は固有のドキュメントを
持たない — 関数の読み手は、上にある別名の宣言に気づいて、そちらを読まねばならなくなる。

**Finding**：`validateDiscountCode` は固有のドキュメントを持たない。その契約はその上の宣言
`VALIDATE_CODE_REGEX` にしか現れていない — docstring を `validateDiscountCode` へ移せ。
