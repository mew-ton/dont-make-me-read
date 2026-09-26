# What a stranger can check（見知らぬ読み手が確かめられること）

書いているものが後で読まれ — コードコメント、コミットメッセージ、PR や issue の説明、API や設計
ドキュメント、Notion や docx のページ — それが作られた経緯から来たものを何か運ぼうとしているときに読む。
テストは `SKILL.md` が持ち、ここはそのケースの規則と Bad/Good の対を持つ。

プロセスはその場にいた人々にしか再生されない：「レビューで指摘されたとおり」「もともとXでいくつもりだった」は、
読み手には再構成できない時系列の上に乗っており、到達できない参照も同じ失敗である — 対象が最初から存在
しなかったのか、ここからは取りに行けないだけなのか、読み手にとっては等しく行き止まりである。

## The test（テスト）

テキストについての一つの問い：**読み手はそれが言っていることを確認しに行けるか？**

- 行ける：ビジネス要件、規制、ドメイン制約、プロダクト上の決定、そして現在のコード・型・スキーマに
  今も存在するもの。書け。
- 行けない：会話、レビュースレッド、試行錯誤、以前の方針、削除された議論。落とせ。

対象が到達**できる**のに、それでも読み手を送るべきでなかった場合は、何も削除されない — その事実は使用地点で
言い直される。それは別の所見である。

## The rules（規則）

- **根拠は残し、プロセスは落とせ。** 仕様や設計がなぜ存在するのかは読み手にとっての判断材料である。
  「レビューのフィードバックにより」「方針が変わった」「もともとXにしていた」は、参加者にしか追えない
  タイムラインに依存する
- **現在の形を、それ自体の言葉で記述せよ。** 「AではなくB」「Aは非推奨」「Aは削除された」はいずれも
  読み手がAを知っていることを前提にし、知らない読み手には、その文が何を排除しているのか分からない
- **issue 横断の参照は短い `TODO(#123): ...` の形に限定せよ。** それが何をどこで読めばよいかを正確に
  名指しし、この形を唯一到達可能なものにしている。「別 issue で対応」はそうではない
- **非推奨の注記は、実装がまだ存在するあいだだけ残せ** — 存在するあいだは、その注記は読み手が観測できる
  形の一部を記述している。実装が消えたら、その注記は何も指さなくなるので一緒に消す
- **どうしても残さねばならないプロセスは、プロセスの居場所に置け** — PR説明文の Background セクション、
  または ADR であり、ソースコード、ユーザー向けドキュメント、APIリファレンスでは決してない。そこでは
  以後のすべての読み手が、誰も確かめられない素材を読む代金を払う
- **読み手の言語で書け** — コードコメントやPR説明文ならリポジトリの言語、issue ならトラッカーの言語 —
  そしてその一つの言語だけで：同じ内容の二つ目のコピーは独立に古びていき、どちらのコピーが最新なのか
  誰にも判別できなくなる

## Common Rationalizations（よくある自己正当化）

| 自己正当化 | 実際のところ |
|---|---|
| 「会話の履歴を入れておけば読み手に有益な文脈になる。」 | 読み手はその会話にいなかったので、ログは彼らにとってノイズである。**なぜ**は残し、**どうしてそうなったか**は落とせ。 |
| 「レビューでこの変更を求められたので、それを記録しておく。」 | レビューのフィードバックはプロセスである。結果としての決定を述べよ。レビューが要求したことではなく。 |
| 「却下した代替案を列挙しておけば透明性が高い。」 | 捨てられた選択肢は書き手だけの文脈である。読み手が本当になぜダメだったかを知る必要がある場合を除き、省け。 |
| 「このPR説明文は、読み手がスレッドを見ている前提でよい。」 | 残り続けるドキュメントはスレッドより長生きする。何ヶ月も後に初めて開く人間のために書け。 |

## Red Flags（危険信号）

- 裸の `issue: 1234`、あるいはこの読み手が持っていないかもしれないワークスペースへのリンク。

## Verification（検証）

- [ ] どの主張も、現在のコード・型・スキーマ、あるいは明示された外部の規則から確かめられる。
- [ ] 文脈をまったく持たない読み手が、紹介なしに現れる固有名詞や前提に出会わない。

## Worked examples（実例）

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
