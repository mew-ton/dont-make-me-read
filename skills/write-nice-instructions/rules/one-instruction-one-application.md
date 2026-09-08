# One instruction, one application

Read this before writing 詳細, or whenever a draft feels like it's carrying more than one point.

**Four tells a draft is already two applications under one 表題**, readable before 詳細 exists —
earlier than a 20-line overflow ([`fitting-the-budget.md`](fitting-the-budget.md)) catches the same
thing:

- 表題 joins two facts ("...で、かつ...") instead of stating one.
- 表題 counts instances ("4 件"), not all closing with the same edit.
- Parts sit at different strength rows ([`remedy-strength.md`](remedy-strength.md)) — a fix for one,
  none for another.
- 詳細 wants a sub-heading — that heading is the second instruction's name.

Split on any of these, before writing 詳細.

**Overflow is the same signal, caught later.** A 詳細 that will not fit 20 lines is usually two
instructions sharing one application — for example a cache key that diverges *and* the rollout of the
same URL-restore pattern to three more list screens. Those have different owners, different acceptance
criteria, and different review outcomes; keep the finding on the divergence and file the rollout
separately. A 概要 that will not fit three statements is the same signal, one level earlier: if the
fourth bullet is another fact, it is 詳細; if it is another instruction, it is another application.

## Bad: one lead line, two remedies

```markdown
**major** — mutationチェックの1つが実際には失敗しておらず、かつ出荷される挙動に自動テストがない

このPRのregressionスイートは7件のmutationチェックを主張しているが、対象のガードを外しても1件は
greenのままになる。別件として、5階層のbreadcrumbが実際にレンダリングされることをスイート内の
何も検証していない — page-levelのテストは依然としてリストを空としてモックしている。

### mutationが失敗しない理由

`useCatalogFilterSummary.spec.ts:100-113` は `categorySlug` を非空に設定するため、隣接する
`brandIdsRequest` のfetchが即座に開始し、削除された `await attributes` と同じゲートでブロック
していた。`attributes` を `Promise.all` から外しても、そのfetchは変わらずpendingのままになるため、
assertionは通り続ける。

### どのテストもカバーしていないもの

`grep -rn "toHaveLength(5)" test/` は何もヒットしない。e2eのJSON-LDのassertionは `it.todo` の
ままであり、pageのspecは `breadcrumbs: ref([])` をモックしているため、filter composableから
pageまでのレンダリング経路は未検証である。
```

Both facts are true and both matter, which is exactly why this reads as reasonable — but they call
for different remedies: one is fixed by editing the test, the other has no fix to assert here at all.

## Good: split by remedy, not by subject

```markdown
**major** — `useCatalogFilterSummary.spec.ts:100-113` は `attributes` を `Promise.all` から外しても
greenのままになる

- :108/:113 のassertionは実際には隣接する `brandIdsRequest` のfetchによってガードされており、
  `attributes` によるものではない — `attributes` を待機リストから外してもこのテストはredにならない。
- テストとそのコメントの名前を、実際にガードしている内容に合わせて変更し、このテストがカバーする
  と主張していたmutationリストから `attributes` を外す。
- `Promise.all` 自体から `attributes` を外してはならない — そこにある `Promise<unknown>[]` の型
  注釈は、将来 `useFetchAttributes` の戻り値の型が狭まった際に検知する役割を持っており、外すと
  それが失われる。
```

```markdown
**major** — 出荷される5階層のbreadcrumbを検証する自動テストが存在しない

- `grep -rn "toHaveLength(5)" test/` は何もヒットせず、e2eのJSON-LDのassertionは `it.todo` の
  ままであり、pageのspecは `breadcrumbs: ref([])` をモックしている — filter composableから
  pageのレンダリングまでのどこが壊れても既存のテストは全て通ってしまう。
- このPRに含めるべき修正はない。`it.todo` を埋めるのは別の作業である。
- `it.todo` 用のissueを起票し、このPRでは手動確認でのみ挙動を検証した旨を明記する。
```

Filing them together hides the row-3 problem under the row-1 fix: a reader who applies the rename sees
the finding as resolved, and the coverage gap that was never addressed goes with it.
