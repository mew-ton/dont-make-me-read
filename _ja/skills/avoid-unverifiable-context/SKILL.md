---
name: avoid-unverifiable-context
description: >
  残り続けるテキストは、その読み手が確認しに行けないものを担ってはならない — それを生み出した会話、
  レビューでの指摘、捨てられた代替案、現在のコードにもう現れない過去の状態。根拠（ビジネス要件、規制、
  ドメイン制約、プロダクト上の決定）は残すこと。それらは、その場にいなかった読み手でもたどれる外部の
  出来事である。プロセスは落とすこと。その部屋にいた人間にしか再構成できない。issue、PR説明文、
  コードコメント、APIドキュメントや設計ドキュメント、その他あとで読まれるあらゆるテキストを書くときに
  適用する。DO NOT 読み手が本当に到達できるのに送られるべきでなかった参照には使わない（それは
  avoid-reference-detours）。issue 本文のセクションと基準にも使わない（それは
  write-nice-issue-description）。一過性のチャット返信や作業メモにも使わない。
user-invocable: false
disable-model-invocation: false
allowed-tools: []
---

## Scope（範囲）

残り続けるテキストは、それが書かれたときそこにいなかった誰かに読まれる。このスキルはそのテキストに
ついての一つの問いを統べる：**読み手はそれが言っていることを確認しに行けるか？**

- 行ける：ビジネス要件、規制、ドメイン制約、プロダクト上の決定、そして現在のコード・型・スキーマに
  今も存在するもの。書け。
- 行けない：会話、レビュースレッド、試行錯誤、以前の方針、削除された議論。落とせ。

読み手が本当に**開ける**のに送られるべきでなかった参照は別の欠陥であり、`avoid-reference-detours` が
それを所有する。こちらでは対象がこの読み手にとってそもそも存在しないので、言い直すものがなく、直し方は
常に一つ：削除。

## Why（なぜ）

- **根拠は部屋より長生きする。** ビジネス要件、規制、ドメイン制約、プロダクト上の決定は外部の出来事で
  ある。元の会話にいなかった読み手でもたどれるので、それが取る行数の価値がある
- **プロセスは参加者にしか再生されない。** 「レビューで指摘されたように」「もともとXにしていた」
  「方針が変わった」は、その議論にいた人間にしか再構成できないタイムラインに依存している。外から見ると
  **いつ**と**誰の**が未定義で、テキストは時とともにノイズに変わる
- **観測可能な事実は歴史ではない。** 現在のコード・型・スキーマに今もあるもの — 例えばまだ宣言されて
  いる非推奨API — は共有された文脈である。読み手はそれを見られるので、それを記述するのは現在の状態で
  ある
- **到達できない参照は同じ失敗。** Notion ページ、Slack スレッド、このセッションで下された決定、あるいは
  どのシステムに属するのか言わない裸の `issue: 1234`。対象がそもそも存在しなかったのか、単にここからは
  たどり着けないだけなのか、読み手にとっては同じく手詰まりである

## Guidance（指針）

1. **根拠は残す。** 仕様や設計がなぜ存在するのかを書き留める。それは読み手にとっての判断材料である
2. **プロセスは落とす。** 「レビューのフィードバックにより」「方針が変わった」「もともとXにしていた」
   — 参加者にしか追えないタイムラインに依存する言い回しを避ける
3. **対比的な言い回しに注意。** 「AではなくB」「Aは非推奨」「Aは削除された」はいずれも読み手がAを
   知っていることを前提にする。知らないなら、Bをそれ単体で記述せよ
4. **issue 横断の参照は短い `TODO(#123): ...` の形に限定する。** 「別 issue で対応」「あとで対処」は
   issue を名指しする TODO に属し、散文・docstring・API説明には決して属さない。`TODO(#123)` は何をどこで
   読めばよいかを正確に名指しし、それがこの形を唯一到達可能なものにしている
5. **非推奨の注記は実装が存在するあいだは問題ない。** パラメータ、エンドポイント、関数が読み手の観測
   できる形の一部であるうちは、非推奨と記してよい。実装が消えたら、その注記は何も指さなくなるので一緒に
   消す
6. **どうしてもプロセスを残すなら、プロセスの居場所に置く。** PR説明文の Background セクション、または
   ADR。ソースコードでも、ユーザー向けドキュメントでも、APIリファレンスでもない
7. **読み手の言語で書く。** その成果物の読者がすでに使っている言語を使う — コードコメントやPR説明文なら
   リポジトリの言語、issue ならトラッカーの言語。このスキルはテキストが**どんな文脈**を担うかについての
   ものであって、どの言語がそれを担うかではない。同じ内容を第二言語で言い直してはならない。翻訳は独立に
   古びていき、どちらのコピーが最新なのか誰にも判別できなくなる
8. **何も持たない読み手に対して自己チェックする。** 文脈ゼロの誰かにテキストを渡し、紹介なしに出てくる
   固有名詞や前提を探す。印象ではなく機械的にやるなら `review-self-contained-docs` を使う

## Common Rationalizations（よくある自己正当化）

最もよくある失敗は、その成果物が「ドキュメント」に感じられなかったせいで、これをまったく適用しないこと
である。まずそれを塞ぎ、それからプロセス漏れの言い訳へ：

| 自己正当化 | 実際のところ |
|---|---|
| 「これはコードコメント／コミットメッセージ／issue／Notion ページであって、本当の意味での『ドキュメント』ではないから該当しない。」 | 該当する。対象は**残り続けるあらゆる成果物**であり、それがどこにあろうと関係ない — コードコメント、コミットメッセージ、PRとissueの説明、APIと設計ドキュメント、Notion / docx ページ、すべて含む。これが繰り返される失敗である。「doc」とラベルが付いたときだけでなく、書く**前に**このスキルに照らして成果物を確認せよ。 |
| 「自分には問題なく読める。」 | あなたは読みながら、テキストに欠けている意図を自分で補っている。テキストだけを手にしている人間として判断せよ — それこそが失敗モードのすべてである。 |
| 「会話の履歴を入れておけば読み手に有益な文脈になる。」 | 読み手はその会話にいなかったので、ログは彼らにとってノイズである。**なぜ**は残し、**どうしてそうなったか**は落とせ。 |
| 「レビューでこの変更を求められたので、それを記録しておく。」 | レビューのフィードバックはプロセスである。結果としての決定を述べよ。レビューが要求したことではなく。 |
| 「却下した代替案を列挙しておけば透明性が高い。」 | 捨てられた選択肢は書き手だけの文脈である。読み手が本当になぜダメだったかを知る必要がある場合を除き、省け。 |
| 「このPR説明文は、読み手がスレッドを見ている前提でよい。」 | 残り続けるドキュメントはスレッドより長生きする。何ヶ月も後に初めて開く人間のために書け。 |
| 「このスキルの実例が英語なので、ドキュメントも英語にすべきだ。」 | 実例が英語なのはスキルが英語だからである。**その**成果物の読者がすでに使っている言語で書け。 |

## Examples（実例）

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

## Related skills（関連スキル）

- `avoid-reference-detours` — 同じ分割のもう半分。対象は**到達可能**なのに、読み手がそこへ送られた場合。
- `review-self-contained-docs` — 書かれたテキストを、読み手の側から、単位ごとに両方に照らして監査する。
