# How firmly to state the remedy

Read this before writing 概要's fix. Pick one of three, by what you can actually defend. This is the
axis generated text gets wrong: it reaches for a flat menu of options in all three cases, which reads
as balanced and leaves the reader to do the deciding.

| What you have | How to write it | What not to do |
|---|---|---|
| **A fix you can defend** | Assert it as the one to make: "fix it with `ValidationError`, as `path/to/validate.ts:22` does". A rejected option may appear **only as the constraint that rules it out** — the wall the reader would otherwise walk into — never as an option offered to them. | Do not present the alternatives you rejected as choices, and do not hedge the one you chose ("it might be worth considering…"). Both hand your decision back to the reader. |
| **Several fixes, and any of them is genuinely fine** | List them flat, with no weighting. | Do not smuggle in a preference through ordering, length, or wording. If you have a preference, you are in row 1 — say so. |
| **No fix you can name** | Switch the goal to **registering the problem**: open an issue and link it from a comment at that code. | Do not invent a vague suggestion to fill the slot, and do not drop the finding because you cannot solve it. |

**A flat list is the last resort, not the default.** When you are about to give three options, first
check whether row 1 applies. If you can weight them at all, it is row 1 — one asserted fix — not
row 2. Row 2 is only for options that are genuinely interchangeable.

**Marking a fix as optional to adopt is not the same as hedging it.** A nit can say outright that
nothing is broken today and still assert a specific fix as the one to make if you act on it — the fix
is stated with confidence; only whether it is worth the effort right now is left to the reader. That
differs from "it might be worth considering…", which hedges the fix's correctness itself. If you can
name the fix and defend it, row 1's wording stays direct even when acting on it is optional.

**A contradiction between a comment (or spec, or AC) and the code is not automatically row 1.**
Finding that a doc comment claims A while the code does B tells you the two disagree — it does not by
itself tell you A is correct and B is the bug. Prose reading as the more complete or deliberate-sounding
side is not evidence it is current: it can just as easily be a stale plan the code has already moved
past. Absent evidence that actually favors one side — a grep showing the described behavior has no
remaining callers, an explicit statement that one side is stale, the same kind of evidence any other
row-1 fix cites — this is row 2: list both fixes flat ("bring the code up to what the comment says, or
correct the comment to say what the code actually does") and let the author's own scope call pick. A
disclosed, deliberate scope split — a follow-up ticket, a "not wired yet" note, a `TODO(#N)` — is the
clearest case of this: it tells you the mismatch is intentional, not which side is wrong. Its absence
is not itself evidence either — a comment nobody has explained yet still gets the same row-2 default
until something actually favors a side.

The issue opened for row 3 is itself a decision issue, written by `write-nice-issue-description`;
what must be decided and what would settle it lands in that issue's own body, not in this finding.

Strength is **orthogonal to severity**: `critical` / `major` / `minor` / `nit` says whether the
finding blocks the merge, strength says how firmly the remedy is stated. A `major` can have no known
fix (row 3), and a `nit` can have exactly one (row 1).

## Row 1 — a fix you can defend

### Bad: the fix is known, but written as a menu

```markdown
このPR全体としては良さそうです、お疲れさまでした！ キャッシュキーについて1点——もう少し安定した
キーにできないか検討する価値があるかもしれません。いくつか選択肢があります。組み立て済みのクエリ
をキーにする、復元されたフォームを正規化する、fetchする前に両者を比較する、あるいはこのままにして
挙動をドキュメント化する、などです。どれもおそらく機能するでしょう。また、テストももう少し
カバーできる余地があるかもしれません。
```

表題 is an assessment rather than a fact. The four options are not equally good and the writer knows
it. The hedge leaves it unclear whether anything must change. A second instruction about tests is
bundled into the same finding. And the whole thing is prose, so none of that is countable.

### Good: one fix asserted, the rejected option kept as a constraint

```markdown
**minor** — キャッシュキーが、表現している組み立て済みクエリではなく生のフィルタフォームから
導出されている

- `app/composables/foo/useFetchFoo.ts:23` は `useAsyncData` のキーを生のフィルタフォーム
  にしている: モーダルとURL復元は同じ条件を2通りの形でシリアライズする。
- そのため、1つの条件が `payload.data` に2つのエントリとして登録される。
- 代わりに組み立て済みのクエリをキーにする: `JSON.stringify(buildFooListQuery({ ... }))`。

2つの表記が異なるのは、モーダルが `"all"` を示す値も含めて全キーを送信するのに対し、URL復元は
絞り込みに使うキーのみを保存するためである。今日時点で目に見える不具合はない——どちらも同一の
`/v1/foo` リクエストを発行している。今のうちに直す価値があるのは、2つ目の一覧画面が同じ
URL復元パターンを採用しつつあり、`useFooFilterUrlState.isSameForm` が既に両フォームを等しい
ものとして扱っているため、キャッシュキーだけが両者の食い違う唯一の箇所になっているからである。

復元されたフォームを正規化する方は行わないこと。`readFromQuery` は、等価な条件のフォームを
ダイアログが送信した形のまま意図的に残している。等価なオブジェクトへの再代入であっても
`shallowRef` への書き込みには変わりなく、fetchのwatcherを再トリガーしてしまうためで、これが
このリストを3回の `/v1/foo` 呼び出しから1回に減らした理由である。

このcomposableの他の利用箇所（`pages/bar/index.vue` と `asBarView: true` のパス）は
新しいキー文字列を目にすることになるため、両方ともregressionのカバーが必要である。
```

**Listing rejected options and stating constraints are different things.** The middle paragraph is not
an alternative offered to the reader — it is the wall they would walk into on reaching for the obvious
local fix. One asserted fix, plus the constraints that make it the fix.

## Row 2 — options that are genuinely interchangeable

### Good: flat, unweighted, and short

```markdown
**nit** — `path/to/config.ts:41` がconfigキーごとに1行ログを出している

- 次のいずれでも構わない: キーごとのログを削除する、`trace` レベルに落とす、あるいはキー件数を
  持つ1行のサマリーログに置き換える。
```

If you would be mildly disappointed by one of the three, you are in row 1 and should say which. Row 2
is for the case where you genuinely would not review the choice.

### Bad: the comment reads as correct, so the code is asserted as the thing to fix

```markdown
**major** — `useBarSender.ts:8` のヘッダーコメントには送信失敗時に1回リトライしてから
破棄すると書かれているが、`sendBar()` にリトライは実装されておらず、失敗すると即座に送信内容が
破棄される

- `sendBar()` のコメントが説明しているリトライを実装する。
```

The comment reads as the more deliberate, more complete side, so it gets asserted as ground truth — but
nothing here establishes that the retry is the missing half rather than a leftover description of a
plan the code already moved past.

### Good: the disclosure is what moves it to row 2

```markdown
**major** — ヘッダーコメントとそれが説明しているコードとで、リトライ挙動の記述が食い違っている

- `useBarSender.ts:8` のヘッダーコメントには送信失敗時に1回リトライしてから破棄すると
  書かれているが、`sendBar()` にリトライは実装されておらず、失敗すると即座に送信内容が破棄される。
- PR本文自身の「Seams」セクションでは、リトライ処理はqueueベースのsenderに委ねる（フォロー
  アップのチケット行き）としており、このPRでまだリトライが求められているとはどこにも書かれて
  いない。
- リトライを実装するか、コメントを「まだリトライされない」旨に修正しフォローアップチケットへの
  リンクを添えるか、どちらかは既に作者が決めている通りにする。
```

Nothing available here says which side is the bug: the comment could be a stale plan, or this PR could
be an intentionally partial step toward it. Asserting "add the retry" would decide that scope question
instead of reporting it.

Two concrete fixes exist — implement the retry, or make the comment state the deferral — and either one
resolves the contradiction, which is why this is row 2 and not row 3. It is not row 1 either: nothing
here, no grep and no explicit statement, favors one side over the other. Once something does (the PR
body says outright "the comment is stale, ignore it"), name that fix and move to row 1.

## Row 3 — no fix you can name

The goal changes: you are no longer instructing a fix, you are **registering the problem** so it is
not lost. Two shapes, by where you are writing.

### Good: in a PR review — open an issue and link it from the code

```markdown
**major** — `pages/foo/[id].vue:24` が `useAsyncData` の `error` を握りつぶしている

- 失敗時に本文が空でレンダリングされ、読者には文章のない記事が表示される。
- このPRに含めるべき修正はない。先に2点を決める必要がある。
- 両方を含むissueを起票し、fetch箇所の `TODO(#N)` からリンクする。

`fooBlocks` は `[]` に、`isLocked` は `false` にフォールバックするため、失敗はUIにもDOMにも
現れない。ここで直せない理由は2つある。失敗時の文言はどのspecにも定義がなく、実装すると実装者
がユーザー向け文言の作者になってしまう。また、このページは記事一覧・検索結果・外部リンクなど
複数の経路からそれぞれ異なるレイアウトでマウントされており、「失敗時のUIはこのレイアウトが持つ」
と決め打ちできる根拠がない。失敗をどこでレンダリングするかは未解決の設計課題である。
```

The finding is not softened into "maybe consider handling the error", and it is not dropped for being
unsolvable. The 概要 carries the fact and the instruction; the reasons a fix cannot be named are 詳細.

### Registering the problem when the fix opens a new issue

```markdown
**major** — STG環境バッジは `#ff2a1f` 上に白文字を描画しており、コントラスト比3.75:1で、
16px boldに適用される4.5:1のAA基準を下回っている

- このPRに含めるべき修正はない。アクセシブルな配色は実装の詳細ではなくデザイン上の決定事項である。
- 測定済みの代替案と決めるべき事項を添えたissueを起票し、
  `path/to/resolveEnvironmentBadge.ts` の `stg` エントリのコメントからリンクする。
```

"Investigation is needed" on its own is not row 3 — it is row 3 with the work left out. The linked
issue is where the non-options get closed off and the decision named; that issue's own body is
written with `write-nice-issue-description`, not with this template.
