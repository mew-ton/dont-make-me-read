# 一つの指示に一つの適用

Details を書く前、あるいは下書きが一つ以上の論点を担っていると感じられるときは常にこれを読むこと。

**下書きがすでに一つの Title の下に二つの適用を抱えているという4つの兆候**。Details が存在する前に読み取れ、
20行の溢れ（[`fitting-the-budget.md`](fitting-the-budget.md)）が同じものを捕まえるより早い：

- Title が一つを述べる代わりに二つの事実を接続している（「…かつ…も」）。
- Title が事例を数えている（「4箇所」）が、それらが同じ編集で閉じない。
- 部分が異なる強さの行に座っている（[`remedy-strength.md`](remedy-strength.md)） — 一方には修正があり、
  他方にはない。
- Details が小見出しを欲しがっている — その見出しこそが二つ目の指示の名前である。

どれか一つでも当てはまれば、Details を書く前に分割する。

**溢れは同じシグナルを、後から捕まえたもの。** 20行に収まらない Details は、たいてい一つの適用を共有して
いる二つの指示である — 例えば、キャッシュキーが乖離していること**と**、同じURL復元パターンをさらに3つの
一覧画面へ展開すること。これらは異なる担当者、異なる受け入れ基準、異なるレビュー結果を持つ。指摘は乖離の
ほうに留め、展開は別途起票せよ。3つの記述に収まらない Summary は、同じシグナルを一段早く捕まえたもので
ある：4つ目の箇条書きが別の事実なら、それは Details である。別の指示なら、それは別の適用である。

## Bad: 一つの先頭行、二つの対処

```markdown
**major** — one of the mutation checks does not actually fail, and the shipped behaviour has no
automated test

This PR's regression suite claims seven mutation checks, but one stays green even with the guard it
targets removed. Separately, nothing in the suite verifies that the five-level breadcrumb actually
renders — the page-level test still mocks the list as empty.

### Why the mutation does not fail

`useFooFilterSummary.spec.ts:100-113` sets `fooSlug` to a non-empty value, so the neighbouring
`barRequest` fetch starts immediately and was blocked on the same gate as the removed
`await extras`. Dropping `extras` from `Promise.all` leaves that fetch pending all the same, so the
assertion keeps passing.

### What no test covers

`grep -rn "toHaveLength(5)" test/` returns nothing. The e2e JSON-LD assertion is still an `it.todo`,
and the page spec mocks `breadcrumbs: ref([])`, so the render path from the filter composable
through to the page is unverified.
```
（訳：Title＝「ミューテーションチェックの一つが実際には失敗せず、かつ出荷される振る舞いに自動テストが
ない」／本文＝「このPRの回帰スイートは7つのミューテーションチェックを謳っているが、一つは対象とする
ガードを外してもグリーンのままである。別途、5階層のパンくずが実際にレンダリングされることをスイートの
何も検証していない — ページレベルのテストは依然として一覧を空としてモックしている。」／小見出し＝
「ミューテーションが失敗しない理由」「どのテストもカバーしていないもの」）

どちらの事実も真であり、どちらも重要である。だからこそこれは妥当に読めてしまう — しかし両者は異なる対処を
要求する。一方はテストを編集すれば直り、他方にはここで言い切れる修正がそもそも存在しない。

## Good: 主題ではなく、対処で分割する

```markdown
**major** — `useFooFilterSummary.spec.ts:100-113` stays green even with `extras` dropped from
`Promise.all`

- The assertions at :108/:113 are actually guarded by the neighbouring `barRequest` fetch, not by
  `extras` — removing `extras` from the awaited list does not turn this test red.
- Rename the test and its comment to match what it actually guards, and drop `extras` from the list
  of mutations this test claims to cover.
- Do not remove `extras` from `Promise.all` itself — the `Promise<unknown>[]` annotation there
  exists to catch a future narrowing of `useFetchExtras`'s return type, and removing it loses that.
```
（訳：Title＝「`useFooFilterSummary.spec.ts:100-113` は `Promise.all` から `extras` を外してもグリーン
のままである」／①:108/:113 のアサーションは実際には `extras` ではなく隣接する `barRequest` の fetch に
よって守られている — await リストから `extras` を外してもこのテストは赤くならない ②テストとその
コメントを、実際に守っているものに合わせて改名し、このテストがカバーすると謳うミューテーションの一覧から
`extras` を落とす ③`Promise.all` から `extras` そのものは外さないこと — そこの `Promise<unknown>[]`
アノテーションは `useFetchExtras` の戻り型が将来狭まるのを捕まえるために存在しており、外すとそれを失う）

```markdown
**major** — no automated test verifies the five-level breadcrumb that ships

- `grep -rn "toHaveLength(5)" test/` returns nothing, the e2e JSON-LD assertion is still an
  `it.todo`, and the page spec mocks `breadcrumbs: ref([])` — every existing test passes no matter
  where the path from the filter composable to the page render breaks.
- There is no fix to include in this PR. Filling in the `it.todo` is separate work.
- Open an issue for the `it.todo` and state in this PR that the behaviour was verified by manual
  check only.
```
（訳：Title＝「出荷される5階層のパンくずを検証する自動テストが存在しない」／①`grep -rn
"toHaveLength(5)" test/` は何も返さず、e2e の JSON-LD アサーションは依然 `it.todo` であり、ページの
spec は `breadcrumbs: ref([])` をモックしている — フィルタの composable からページのレンダリングまでの
経路がどこで壊れても、既存のテストはすべて通る ②このPRに含める修正はない。`it.todo` を埋めるのは別の
作業である ③`it.todo` について issue を立て、この振る舞いは手動確認のみで検証したとこのPRに述べる）

一緒に起票すると、行1の修正の下に行3の問題が隠れてしまう：改名を適用した読み手はこの指摘が解決したとみなし、
一度も対処されなかったカバレッジの穴も一緒に消える。
