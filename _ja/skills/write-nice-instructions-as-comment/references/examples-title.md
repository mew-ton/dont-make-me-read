# Title の実例 — Bad → Good

Title を実例の対に照らして測る必要があるときに読むこと。各対は自分が何を修復しているかを名指ししている：
一つの事例に融合した Title、依頼を否定しただけの Title、そして二つの対処を一度に担う先頭行である。実例が
英語なのはこのファイルが英語だからであり、教えているのはその形である。

## The rule and its one instance, fused into Title（ルールと、その一つの事例が Title に融合している）

**Bad**

```markdown
**minor** — the comment attached to `FooDetail.vue:4-16` is too long

- It carries the related issue and incident history, all for a change that only adjusts a width.
- The same tendency shows up in various other places.
- Please review the comments.
```
（訳：Title＝「`FooDetail.vue:4-16` に付いたコメントが長すぎる」／①幅を調整するだけの変更のために、
関連 issue とインシデントの経緯を担っている ②同じ傾向が他の様々な箇所にも現れている ③コメントを
見直してください）

ファイルを差し替えると文が壊れる — このバグについての話ではなくなり、別のバグについての話になってしまう。
つまりファイルは、Title が述べるべき事実ではなく証拠である。そして Summary 自身がすでにそう言っている
（「同じ傾向が他の様々な箇所にも現れている」）ので、1ファイルだけを名指しした Title は、気づいていないの
ではなく**抽象化の取りこぼし**である。修正もまた曖昧である（「コメントを見直してください」）。下の Good 版
はチェック可能なルールを述べている。

**Good**

```markdown
**minor** — comments are too long

- An LLM tends to write verbose, flat comments that run to three lines or more.
- Even a supplementary comment becomes text the reader has to stop and work through once that
  tendency is strong enough.
- Delete or compress to one line any comment that, after the fix, runs past three lines excluding
  blank lines.
```
（訳：Title＝「コメントが長すぎる」／①LLMは冗長でフラットな、3行以上に及ぶコメントを書きがちである
②その傾向が強くなると、補足的なコメントであっても、読み手が手を止めて読み解かねばならないテキストになる
③修正後に空行を除いて3行を超えるコメントは、削除するか1行に圧縮する）

Title は、この形で膨らんだあらゆるコメントに対して、それが再発するどこにおいても真として読める。Summary は
それを、今回たまたまそれを引き起こした1つのパスではなく、メカニズム（LLMのコメントの癖）とチェック可能な
修正に接地させている — この例は最後まで一般化しており、それを繋ぎ止めるファイルを必要としない。そして
たまたま二重に勝ってもいる：Title が事例ではなくルールに座っていること。それとは別に、その修正が、見に行く
べきファイルの一覧ではなく数えられるチェックとして述べられていること。

## Title only negates the request（Title が依頼を否定しているだけ）

**Bad**

```markdown
**minor** — `FooDetail.vue:140` embeds a compound condition directly in `v-if` (not extracted into
a named computed)
```
（訳：「`FooDetail.vue:140` は複合条件を `v-if` に直接埋め込んでいる（名前付きの computed に抽出されて
いない）」）

Title は依頼（「名前付きの computed に抽出せよ」）の極性を反転させたものであって、観測ではない —
「〜に抽出されていない」は修正が何をするかを逆向きに述べ直しているだけで、依頼そのもの以上の情報を担って
いない。さらに、それを引き起こしたたまたまの1ファイルを融合させてもいる — 独立した二つ目の問題であり、
片方を直してももう片方は免除されない。

**Good**

```markdown
**minor** — compound and complex conditional expressions are written directly in the template
```
（訳：「複合的で複雑な条件式がテンプレートに直接書かれている」）

事実は依頼の上流にある：テンプレートが実際に今日やっていること（インラインで書かれた条件）であって、
書き手が代わりに望むもの（computed への抽出）の鏡像ではない。これが、タイトル自体が依頼の反転になることなく
修正を正当化するものである。

## One lead line, two remedies（一つの先頭行、二つの対処）

**Bad**

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
要求する。一方はテストを編集すれば直り、他方にはここで言い切れる修正がそもそも存在しない。発火した兆候は、
Title が二つの事実を接続していること、部分が異なる強さの行に座っていること、そして Details が指示ごとに
小見出しを生やしたことである。

**Good: 主題ではなく、対処で分割する**

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

一緒に起票すると、名指しできる修正がない問題が、修正のあるほうの下に隠れてしまう：改名を適用した読み手はこ
の指摘が解決したとみなし、一度も対処されなかったカバレッジの穴も一緒に消える。
