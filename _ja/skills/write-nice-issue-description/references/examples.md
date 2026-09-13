# 実例

実際の issue 本文を起草／改稿しようとしているときに読むこと。各例は `SKILL.md` の Gate 1 または Gate 2 の
一部分を示している。

## Gate 1 — decision vs. choice

### Bad: 実装方法が書き込まれている

```markdown
## Affected areas

- `path/to/types.ts` (extend the discriminated union with a `previewOnly` variant,
  and update `createFooResolver.ts` to branch on it)
```
（訳：括弧書き＝「discriminated union に `previewOnly` バリアントを足し、`createFooResolver.ts` を
それで分岐するよう更新する」）

union を拡張するか、別の boolean フィールドで分岐するかは、受け入れ基準が実際に要求することをどちらでも
満たす — それは**選択**であり、この括弧書きは実装者の仕事を代わりにやってしまっている。

### Good: 同じ領域を、実装方法なしで

```markdown
## Affected areas

- `path/to/types.ts` (an existing discriminated-union example is `FooResolution` in
  `_internals/foo/fooResolution.ts`)
```
（訳：括弧書き＝「既存の discriminated union の例は `_internals/foo/fooResolution.ts` の
`FooResolution`」）

括弧書きはその場所に**すでに存在するもの** — 手がかり — を名指しし、新しい状態をどうモデリングするかは、
現在のファイルの形に対して実装する者に委ねている。

## Gate 1 — 固定された形は選択ではなく制約である

### Bad: 決着済みのインタフェースが、まだ選択であるかのように省かれている

```markdown
## Affected areas

- `path/to/FooViewModel.ts` (the foo card's response shape)
```
（訳：括弧書き＝「foo カードのレスポンスの形」）

別リポジトリのレンダリングコンポーネントは、特定の `FooViewModel` の形に合わせてすでに構築されている —
先行する設計工程がそれを固定し、消費側がすでに依存している。それを Acceptance criteria から外して単なる
手がかりとして扱うのは、決着済みの事実を、これを実装する者にとってまだ開かれているかのように扱うこと
である。

### Good: 形を、独自ブロックを持つ基準として述べる

```markdown
## Acceptance criteria

- [ ] The response conforms to the `FooViewModel` shape below.

  ```ts
  type FooViewModel =
    | { status: "open"; title: string; company: string }
    | { status: "closed" | "not_found" | "fetch_error" };
  ```
```
（訳：チェックボックス＝「レスポンスは下記の `FooViewModel` の形に準拠する」）

その形は実装方法ではない — それは**実装が生み出さねばならないもの**であり、この issue の外側の消費側が
すでにそれに依存している。独自ブロックを持つ基準として述べることで、`Design / Approach` セクションに
手を伸ばすことなく、1つのチェックボックス行の外に出しておける。

## Gate 1 — 制約と、その理由を正しい場所に

### Bad: 理由が制約の隣に座っている

```markdown
## Acceptance criteria

- [ ] The 410 path reuses the existing `GoneError` (introducing a second error type for the same
      HTTP status would leave two shapes for API consumers to handle, and the OpenAPI schema
      already documents `GoneError`'s shape for this status)
```
（訳：「410 の経路は既存の `GoneError` を再利用する（同じHTTPステータスに二つ目のエラー型を導入すると
API消費側が扱う形が二つになるし、OpenAPIスキーマはこのステータスに対する `GoneError` の形をすでに
記述している）」）

この括弧書きはチェックボックスを段落に戻してしまい、その段落は Design / Approach セクションの種になる。
一つの理由がインラインに入ると、次の制約の理由もそうなる。

### Good: 制約は単体で立ち、その理由は Background の問題として

```markdown
## Background / Why

Two exhausted-listing paths already return `GoneError` (`GET /v1/foo/{id}`,
`GET /v1/bar/{id}`), each with the same OpenAPI shape. A third ad-hoc 410 shape would leave
API consumers handling three different bodies for the same status.

## Acceptance criteria

- [ ] The 410 path reuses the existing `GoneError`.
```
（訳：Background＝「掲載終了の経路はすでに二つ `GoneError` を返しており（`GET /v1/foo/{id}`、
`GET /v1/bar/{id}`）、どちらも同じ OpenAPI の形である。三つ目のその場しのぎの 410 の形を作ると、API
消費側は同じステータスに対して三つの異なるボディを扱うことになる。」）

チェックボックスは何が成立せねばならないかを述べ、それを正当化する段落は、読み手が正当化を期待する場所 —
問題の残りの部分の隣 — にある。チェックリスト項目に畳み込まれているのではなく。

## Gate 1 — references

### Bad: 解決して初めて意味が通る参照

```markdown
Refs #1784

## Background / Why

#1784 makes the article body's foo link return a 4-state view model.
```
（訳：「#1784 が記事本文の foo リンクを4状態のビューモデルにする。」）

#1784 を開けない読み手は、この文を読み終えられない — 事実そのものが別文書に先送りされていて、ここで述べ
られていない。

### Good: 同じ依存を、開かなくても読み手が止まれる形で述べる

```markdown
## Background / Why

A foo card shown in an article can be in one of these states: closed, the foo no longer exists, or
fetch failed.

## Dependencies

depends on #1784
```
（訳：「記事内に表示される foo カードは、クローズ／foo がもう存在しない／取得失敗、のいずれかの状態を
取りうる。」）

「depends on #1784」は、今この issue を読み続けるかどうかを決めるのに必要なすべてを、それを開かせることなく
読み手に伝えている。issue が実際に扱っている事実は、ここに、一度だけ、それ自体として述べられている。

## Background — 実体が文書やコードであるときは主語がパスになる

### Bad: 実体の代わりに散文の説明が立っている

```markdown
## Background / Why

The backend's layer boundary rule document says circular dependencies between layers are
disallowed.
```
（訳：「バックエンドのレイヤー境界ルール文書は、レイヤー間の循環依存を禁止していると述べている。」）

読み手はこの文が意味を持つ前に「バックエンドのレイヤー境界ルール文書」を探しに行かねばならない — この説明
は、書き手がすでにやって捨ててしまった余分な解決ステップである。

### Good: パスが主語

```markdown
## Background / Why

The rules under `.claude/rules/backend/` say circular dependencies between layers are disallowed.
```
（訳：「`.claude/rules/backend/` 配下のルールは、レイヤー間の循環依存を禁止していると述べている。」）

パスがすでに、この事実がどこにあるかを読み手に伝えている。解決すべきものは何も残っていない。

## Background — 複数の問題を章立てする

### Bad: 二つの問題がフラットのまま

```markdown
## Background / Why

- `architecture.md` says each layer's code is nested one level per service, with no top-level
  directory per layer.
- `domain-layer.md`, `application-layer.md`, and five other layer docs show directory trees and
  paths rooted flatly, not per service.
- `proposal-multi-service-structure.md` presents the cross-service import restriction as an
  unimplemented future proposal.
- `backend/CLAUDE.md` already states that restriction as current policy.
```
（訳：①`architecture.md` は各レイヤーのコードがサービスごとに一段ネストされ、レイヤーごとの
トップレベルディレクトリは無いと述べている。②`domain-layer.md`、`application-layer.md` ほか5つの
レイヤー文書は、サービスごとではなくフラットに根を持つディレクトリツリーとパスを示している。
③`proposal-multi-service-structure.md` はサービス横断インポート制限を、未実装の将来提案として提示して
いる。④`backend/CLAUDE.md` はその制限をすでに現行方針として述べている。）

読み手はどの箇条書きが対になるのかを自分で再構成しなければならない。最初の二つが一つの問題（どちらの
格納レイアウトが本物か）、最後の二つがもう一つの問題（方針が実施された後に誰も更新しなかった提案文書）
であることを、どこにも示すものがない。

### Good: 一つの理由、それから問題ごとに一つの見出し

```markdown
## Background / Why

The rules under `.claude/rules/backend/` carry two inconsistencies whose fixes are entangled: which
doc to trust decides which one gets rewritten to match the other.

### Storage layout contradiction

- `architecture.md` says each layer's code is nested one level per service, with no top-level
  directory per layer.
- `domain-layer.md`, `application-layer.md`, and five other layer docs show directory trees and
  paths rooted flatly, not per service.
- Both sets load together when editing under `backend/`, so the reader cannot tell which layout to
  follow.

### Proposal doc gone stale

- `proposal-multi-service-structure.md` presents the cross-service import restriction as an
  unimplemented future proposal.
- `backend/CLAUDE.md` already states that restriction as current policy.
```
（訳：冒頭文＝「`.claude/rules/backend/` 配下のルールは、修正が絡み合った二つの不整合を抱えている。
どちらの文書を信じるかが、どちらをもう一方に合わせて書き直すかを決めてしまう。」／見出し＝「格納
レイアウトの矛盾」「陳腐化した提案文書」／第1章の3つ目＝「`backend/` 配下を編集するときは両方の集合が
一緒にロードされるので、読み手はどちらのレイアウトに従えばよいか判別できない。」）

単一の箇条書きがそれ自体で問題として読めるかどうかが分割を決めたのではない — 「両方の集合が一緒に
ロードされる」も単体では成立しないが、それでも第一の章の中に留まっている。それが同じ問題を構成する
いくつかの事実のうちの一つだからである。分割を決めたのは、箇条書きが**二つの別個の問題に仕分けられた**
ことであって、単一の箇条書きが自足していたかどうかではない。

## Background — 同じ形の要件は、繰り返しの散文ではなく表に

要件が一つだけなら、表はそれを述べている文以上のものを何も買わない：

```markdown
## Background / Why

`config/timeouts.yaml` sets the request timeout to 10s, but `docs/sla.md` requires 30s.
```
（訳：「`config/timeouts.yaml` はリクエストタイムアウトを10sに設定しているが、`docs/sla.md` は30sを
要求している。」）

### Bad: 同じ文を、要件ごとに繰り返している

```markdown
## Background / Why

`config/timeouts.yaml` sets the request timeout to 10s, but `docs/sla.md` requires 30s. It also
sets the retry count to 1, but `docs/sla.md` requires 3. It also disables backoff, but `docs/sla.md`
requires exponential backoff.
```
（訳：「…リトライ回数も1に設定しているが `docs/sla.md` は3を要求している。バックオフも無効にしているが
`docs/sla.md` は指数バックオフを要求している。」）

各文は「____ を ____ に設定しているが、____ を要求している」の穴埋め値だけを変えている — これは Gate 2 の
段落圧縮の重複が、一文の中で捕まる代わりに三つの文にまたがって広がったものである。

### Good: 一つの表

```markdown
## Background / Why

`config/timeouts.yaml` diverges from `docs/sla.md` on more than one setting.

| | Actual | Requirement |
|---|---|---|
| Request timeout | 10s | 30s |
| Retry count | 1 | 3 |
| Backoff | none | exponential |
```
（訳：冒頭文＝「`config/timeouts.yaml` は複数の設定で `docs/sla.md` から乖離している。」）

繰り返されていた雛形は消え、要件ごとに異なるものだけが行として残っている。

問題が複数**種類**あるときは、この上にさらに章立てが適用される — その場合、見出しごとに固有の表を持つ：

```markdown
## Background / Why

Both the request-timeout config and the retry config diverge from `docs/sla.md`.

### `config/timeouts.yaml`

| | Actual | Requirement |
|---|---|---|
| Request timeout | 10s | 30s |

### `config/retry.yaml`

| | Actual | Requirement |
|---|---|---|
| Retry count | 1 | 3 |
| Backoff | none | exponential |
```
（訳：冒頭文＝「リクエストタイムアウトの設定とリトライの設定の両方が `docs/sla.md` から乖離している。」）

章立てと表組みは別の問いに答えている — この issue が何**種類**の問題を抱えているか、対して**一つの**種類の
問題がいくつの要件を抱えているか — なので、両方が同じ issue に適用されることを妨げるものは何もない。

## Goal — Acceptance criteria の全項目をカバーする

### Bad: Goal が届かない項目がある

```markdown
## Goal

404 / 410 semantics conform to RFC 9110.

## Acceptance criteria

- [ ] Returns 410 when the foo was published in the past and is now unpublished or closed.
- [ ] Returns 404 when no foo with that ID has ever existed.
- [ ] The foo list endpoint's response now includes a `lastCheckedAt` timestamp.
```
（訳：Goal＝「404 / 410 のセマンティクスは RFC 9110 に準拠する。」／基準＝①過去に公開され現在は非公開
またはクローズなら410を返す ②そのIDのfooが一度も存在しなかったなら404を返す ③foo一覧エンドポイントの
レスポンスに `lastCheckedAt` タイムスタンプが含まれる）

三つ目の項目は 404/410 のセマンティクスと何の関係もない — 同じ issue に相乗りした二つ目の無関係な問題で
あり、Goal はそれが別のどこかに属することを読み手に示す手立てを与えていない。

### Good: Goal が実際にカバーする issue へ分割する

```markdown
## Goal

404 / 410 semantics conform to RFC 9110.

## Acceptance criteria

- [ ] Returns 410 when the foo was published in the past and is now unpublished or closed.
- [ ] Returns 404 when no foo with that ID has ever existed.
```

`lastCheckedAt` の追加は、それ自身の Goal を持つ独立した issue になる。

## Acceptance criteria — 「すべての」主張にはパスで範囲づけられた主語が要る

### Bad: 裏付ける集合のない「すべての」

```markdown
## Acceptance criteria

- [ ] All backend architecture docs state the same dependency direction.
```
（訳：「すべてのバックエンドのアーキテクチャ文書が同じ依存方向を述べている。」）

これは誰にもチェックできない — 「すべてのバックエンドのアーキテクチャ文書」は1フォルダのことかもしれないし
5フォルダのことかもしれず、文そのものがどちらかを言っていない。

### Good: 主語のパスが集合である

```markdown
## Acceptance criteria

- [ ] All architecture docs under `.claude/rules/backend/` and `backend/docs/` state the same
      dependency direction.
```

パスの範囲がチェックすべき集合である。別途探しに行くべき定義は存在しない。

## Affected areas — 将来の配置に関する注記は依然として実装方法である

### Bad: 括弧書きが、何がどこへ移るかを述べている

```markdown
## Affected areas

- `.claude/skills/` (where layer-specific implementation patterns get split out to)
```
（訳：括弧書き＝「レイヤー固有の実装パターンがどこへ切り出されるか」）

「どこへ移るか」は観察ではなく計画である — それは読み手に何かを移設することを約束させるものであり、
まさに Affected areas が担ってはならない種類の決定である。

### Good: 括弧書きはすでにそこにあるものだけを述べる

```markdown
## Affected areas

- `.claude/skills/` (existing layer-specific implementation-pattern docs live here)
```
（訳：括弧書き＝「既存のレイヤー固有の実装パターン文書がここにある」）

## Gate 2 — duplication

### Bad: Out of scope がスコープ文を言い直している

```markdown
## Background / Why

`GET /v1/foo/{id}` returns the same 404 whether the foo was deleted, never published, or closed.

## Design / Approach

Add a `status` discriminant to the response and have the backend resolve it.

## Out of scope

- Updating the rendering component to show per-status copy (tracked separately).
- Adding a `status` filter to the foo list endpoint.
```
（訳：Out of scope＝①ステータス別の文言を表示するようレンダリングコンポーネントを更新すること
（別途管理）②foo一覧エンドポイントに `status` フィルタを追加すること）

Out of scope の一つ目の箇条書きは「このタスクはバックエンドを扱う。レンダリングコンポーネントは後続」と
同じ事実を、別のセクションで、散文ではなくリスト形式で言っただけである。二つ目は誰も判断を求めていない
機能であり、本当に記録が必要ならそれは後続タスクであって、この issue が引く境界ではない。

### Good: スコープ文がそれを担い、Design / Approach は存在しない

```markdown
## Background / Why

`GET /v1/foo/{id}` returns the same 404 whether the foo was deleted, never published, or closed,
and does not distinguish why.

This task covers the backend response shape. Reflecting the new states in the rendering component
is #1851's.

## Acceptance criteria

- [ ] `GET /v1/foo/{id}` returns a `status` field distinguishing deleted / unpublished / closed.
```
（訳：スコープ文＝「このタスクはバックエンドのレスポンスの形を扱う。新しい状態をレンダリング
コンポーネントに反映するのは #1851 のもの。」）

スコープの記述は一箇所、スコープ文が属する唯一の場所に一度だけ。それを重複させるものは何も生き残らない。
言い直す先の Design / Approach も Out of scope も存在しないからである。

## A full passing issue（通過する issue の全体像）

```markdown
Refs #1558

## Background / Why

`GET /v1/foo/{id}` returns the same 404 whether the foo was deleted, never published, or closed,
and does not distinguish why. A foo card shown in an article can currently only render "not
found," which reads as permanently gone even when the foo is a temporary fetch error away from
reappearing.

## Goal

404 / 410 semantics conform to RFC 9110.

## Acceptance criteria

- [ ] Returns 410 when the foo was published in the past and is now unpublished or closed.
- [ ] Returns 404 when no foo with that ID has ever existed.
- [ ] An existing endpoint's error response shape does not change for any other status.
- [ ] `<this repository's lint / type-check / test commands>` pass (`path/to/foo`).

## Affected areas

- `path/to/getFoo.ts`
- `path/to/error-handler.ts` (an existing `GoneError` → 410 mapping for
  `GET /v1/bar/{id}`)

## Dependencies

depends on #1784
```

Design / Approach なし、Out of scope なし、Verification なし — すべての文が issue のクローズ後も真であり
続け、すべてのチェックボックスがドメインの語彙で書かれ、唯一の境界（このエンドポイントの他のステータスは
影響を受けない）が、Background に付け足された但し書きではなく基準として一度だけ述べられている。

最後のチェックボックスが、この例に残された唯一のプレースホルダである。実際の issue ではそのリポジトリが
実際に走らせるコマンドを名指しする。ここの他の値（`path/to/getFoo.ts`、`#1784`、`GET /v1/foo/{id}`）は
あなたが書こうとしている issue の具体に置き換わる代役だが、検証コマンドは**リポジトリから読み出しに
行かねばならないもの**の代役であって、でっち上げるものではない。
