# Worked examples（実例）

目の前のケース — コードコメント、issue 本文、実装より長く残った deprecation の注記 — の対比が欲しい
ときに読む。ルールは `SKILL.md` が持ち、ここは Bad/Good の対を持つ。

下の例が英語なのは、このスキルが英語だからである。成果物はその読み手がすでに使っている言語で書くこと。

### Bad: 変更の背後にあるプロセスを引きずり込んだコードコメント
```typescript
// Validation used to be inline, but reviewers asked to extract it.
// The retry option is being discussed in another issue (#456) and is not implemented yet.
export function fetchUser(id: string): Promise<User> {
  validateUserId(id);
  return api.get(`/users/${id}`);
}
```
（訳：バリデーションはかつてインラインだったが、レビュアーに抽出を求められた。／リトライ
オプションは別 issue (#456) で議論中で、まだ実装されていない。）

### Good: プロセスを落とす
```typescript
export function fetchUser(id: string): Promise<User> {
  validateUserId(id);
  return api.get(`/users/${id}`);
}
```

### Bad: issue 本文に混ざり込んだプロセス
```markdown
## What to do

Originally we were going to add a `bulk` flag to `POST /items`, but review feedback said
we should split it. So we're adding `POST /items/bulk` instead. The old `bulk` flag will
not be added.
```
（訳：もともと `POST /items` に `bulk` フラグを足すつもりだったが、レビューで分けるべきだと
言われた。なので代わりに `POST /items/bulk` を追加する。旧 `bulk` フラグは追加しない。）

### Good: 最終的な形と、その背後にある根拠
```markdown
## What to do

Add a new `POST /items/bulk` endpoint. The request body accepts `{ items: Item[] }` and persists items in array order.

## Background

Single creation (`POST /items`) and bulk creation have different responsibilities (different transaction boundaries, different partial-failure semantics, and different rate-limit units), so the endpoints are kept separate.
```
（訳：新しい `POST /items/bulk` エンドポイントを追加する。リクエストボディは `{ items: Item[] }` を
受け付け、配列順に永続化する。／単体作成 (`POST /items`) と一括作成は責務が異なる（トランザクション
境界が異なり、部分失敗のセマンティクスが異なり、レート制限の単位も異なる）ので、エンドポイントは
分けたままにする。）

Background セクションが根拠を担っている — 責務のドメインレベルでの違いであり、元のレビューにいなかった
読み手でも検証できる。

### Bad: 実装にもう存在しない非推奨を記述している
```markdown
## `createOrder(input)`

Creates an order. Previously this took a `currency` argument, but it has been deprecated.
The currency from account settings is used instead.
```
（訳：注文を作成する。以前は `currency` 引数を取っていたが、非推奨になった。代わりにアカウント設定の
通貨が使われる。）

`currency` 引数はすでに実装から消えており、現在のシグネチャでは観測できない。このドキュメントは、
読み手が出会いようのない引数を記述している。

### Good（削除後）: 現在の仕様と、その根拠
```markdown
## `createOrder(input)`

Creates an order. The currency comes from the account settings (each account is locked to a single transaction currency by service design).
```
（訳：注文を作成する。通貨はアカウント設定から来る（サービス設計上、各アカウントは単一の取引通貨に
固定されている）。）

### Good（移行期間中）: 実装がまだ受け付けているあいだは注記が残る
```typescript
interface CreateOrderInput {
  items: Item[];
  /** @deprecated The currency from account settings is used. This argument is ignored. */
  currency?: string;
}
```

```markdown
## `createOrder(input)`

Creates an order. The currency comes from the account settings (each account is locked to a single transaction currency by service design).

`input.currency` is deprecated (still accepted for backward compatibility, but ignored).
```

引数はまだ型定義にあるので、読み手はIDEや型チェッカーからそれを観測できる。注記は現在の仕様を記述して
いるのであって、それを生み出したプロセスではない。
