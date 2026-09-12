# 対処をどれだけ強く言い切るか

Summary の修正を書く前にこれを読むこと。実際に擁護できるものによって、三つから一つを選ぶ。ここは生成された
テキストが誤る軸である：三つのケースすべてで選択肢のフラットなメニューに手を伸ばしてしまい、それはバランスが
取れているように読めて、判断を読み手に丸投げする。

| 手持ちのもの | どう書くか | やってはいけないこと |
|---|---|---|
| **擁護できる修正が一つ** | 取るべき唯一の修正として言い切る：「`path/to/validate.ts:22` がやっているように `ValidationError` で直す」。却下した選択肢は、**それを排除する制約としてのみ**現れてよい — 読み手がそうしなければぶつかっていた壁として — 決して差し出される選択肢としてではない。 | 却下した代替案を選択肢として提示しない。選んだものをヘッジしない（「〜を検討する価値があるかもしれない」）。どちらもあなたの判断を読み手に返してしまう。 |
| **複数の修正があり、どれでも本当に構わない** | 重みづけなしで、フラットに並べる。 | 順序、長さ、言葉遣いを通じて選好を忍び込ませない。選好があるなら、それは行1である — そう言え。 |
| **名指しできる修正がない** | 目標を**問題を登録すること**に切り替える：issue を立て、そのコードのコメントからリンクする。 | 枠を埋めるために曖昧な提案をでっち上げない。解けないからといって指摘を落とさない。 |

**フラットなリストは最後の手段であって、既定値ではない。** 3つの選択肢を挙げようとしているときは、まず行1が
当てはまらないか確認せよ。少しでも重みづけできるなら、それは行1 — 一つの言い切られた修正 — であって行2では
ない。行2は本当に互換な選択肢のためだけにある。

**修正を「採用するかは任意」と示すことは、それをヘッジすることとは違う。** nit は、今日何も壊れていないと
明言したうえで、もし対処するならこれが取るべき修正だと具体的に言い切ってよい — 修正は自信をもって述べられて
おり、読み手に委ねられているのは今それに手をかける価値があるかどうかだけである。それは「〜を検討する価値が
あるかもしれない」とは異なる。後者は修正の**正しさそのもの**をヘッジしている。修正を名指しして擁護できるの
なら、対処が任意であっても行1の言葉遣いは直截なままである。

**コメント（あるいは仕様、AC）とコードの矛盾は、自動的には行1にならない。** ドキュメントコメントがAと主張し
コードがBをしていると分かったとき、それは両者が食い違っていることを教えるだけであって、Aが正しくBがバグで
あることをそれ自体では教えない。散文がより完全で、より意図的に見えることは、それが現在のものである証拠では
ない — コードがすでに追い越した、古びた計画でありうる。どちらか一方を実際に支持する証拠 — 記述された振る舞い
にもはや呼び出し元がないことを示す grep、片方が古いという明示、他の行1の修正が引くのと同じ種類の証拠 — が
ない限り、これは行2である：二つの修正をフラットに並べ（「コメントの言う通りにコードを引き上げるか、コードが
実際にやっていることを言うようにコメントを直すか」）、著者自身のスコープ判断に選ばせよ。開示された意図的な
スコープ分割 — 後続チケット、「まだ繋いでいない」という注記、`TODO(#N)` — はこれの最も明快なケースである：
それは食い違いが意図的だと教えるが、どちらが誤りかは教えない。その不在もまた証拠ではない — 誰もまだ説明して
いないコメントは、何かが実際に一方を支持するまで、同じ行2の既定値のままである。

行3のために立てられる issue はそれ自体が決定のための issue であり、`write-nice-issue-description` で書かれる。
何が決められねばならないか、何がそれを決着させるかは、この指摘の中ではなく、その issue 自身の本文に着地する。

強さは**重大度と直交する**：`critical` / `major` / `minor` / `nit` はその指摘がマージを止めるかどうかを言い、
強さは対処をどれだけ強く述べるかを言う。`major` に既知の修正がない（行3）こともあれば、`nit` にちょうど一つ
ある（行1）こともある。

以下の実例が英語なのは、このファイルが英語だからである。強さは何を言い切るかの性質であって、それをどの言語で
言い切るかの性質ではない — リポジトリのレビューがすでに使っている言語で指摘を書き、同じ三つの行を保て。

## Contents

- Row 1 — 擁護できる修正が一つ
- Row 2 — 本当に互換な選択肢
- Row 3 — 名指しできる修正がない

## Row 1 — 擁護できる修正が一つ

### Bad: 修正は分かっているのに、メニューとして書かれている

```markdown
This PR looks good overall, nice work! One thing about the cache key — it might be worth
considering whether it could be made a bit more stable. There are a few options: key on the
assembled query, normalize the restored form, compare the two before fetching, or leave it as is
and document the behaviour. Any of them would probably work. The tests might also have a little
more room to cover.
```
（訳：「このPRは全体的に良いです、お疲れさまです！ キャッシュキーについて一点 — もう少し安定させられ
ないか検討する価値があるかもしれません。いくつか選択肢があります：組み立て済みクエリでキーを作る、
復元されたフォームを正規化する、fetch 前に両者を比較する、あるいはそのままにして振る舞いを文書化する。
どれでもたぶん動くでしょう。テストにもう少しカバーの余地があるかもしれません。」）

Title が事実ではなく評価である。4つの選択肢は同等に良くはなく、書き手はそれを知っている。ヘッジのせいで
何かを変えねばならないのかどうかが不明である。テストについての二つ目の指示が同じ指摘に束ねられている。
そして全体が散文なので、そのどれもが数えられない。

### Good: 一つの修正を言い切り、却下した選択肢は制約として保つ

```markdown
**minor** — the cache key is derived from the raw filter form rather than from the assembled query
it represents

- `app/composables/foo/useFetchFoo.ts:23` keys `useAsyncData` on the raw filter form: the modal and
  the URL restore serialize the same conditions in two different shapes.
- One set of conditions therefore lands in `payload.data` as two entries.
- Key on the assembled query instead: `JSON.stringify(buildFooListQuery({ ... }))`.

The two shapes differ because the modal sends every key, including the ones whose value means
"all", while the URL restore stores only the keys it actually filters on. Nothing is visibly broken
today — both issue the identical `/v1/foo` request. Fixing it now is worth it because a second list
screen is adopting the same URL-restore pattern, and `useFooFilterUrlState.isSameForm` already
treats both forms as equal, which leaves the cache key as the only place the two disagree.

Do not take the normalize-the-restored-form route. `readFromQuery` deliberately leaves an
equivalent-conditions form in the shape the dialog submitted: reassigning even an equivalent object
is still a write to a `shallowRef` and re-triggers the fetch watcher, which is what took this list
from three `/v1/foo` calls down to one.

The composable's other callers (`pages/bar/index.vue` and the `asBarView: true` path) will both see
the new key string, so both need regression coverage.
```
（訳：Title＝「キャッシュキーが、それが表す組み立て済みクエリではなく、生のフィルタフォームから導出
されている」／①`useAsyncData` を生のフィルタフォームでキーづけしている：モーダルとURL復元が同じ条件を
二つの異なる形でシリアライズしている ②そのため一組の条件が `payload.data` に二つのエントリとして着地する
③代わりに組み立て済みクエリでキーを作れ。／第2段落＝二つの形が異なる理由と、今直す価値がある理由。
／第3段落＝「復元フォームを正規化する」経路を取ってはならない理由。／第4段落＝他の呼び出し元にも回帰
テストが必要であること。）

**却下した選択肢を並べることと、制約を述べることは別のことである。** 中段の段落は読み手に差し出された代替案
ではない — 明白なローカルの修正に手を伸ばしたときに彼らがぶつかることになる壁である。一つの言い切られた修正
と、それを修正たらしめる制約。

## Row 2 — 本当に互換な選択肢

### Good: フラットで、重みづけなしで、短い

```markdown
**nit** — `path/to/config.ts:41` emits one log line per config key

- Any of these is fine: drop the per-key logging, lower it to `trace`, or replace it with a single
  summary line carrying the key count.
```
（訳：Title＝「`path/to/config.ts:41` は config のキーごとに1行ログを出している」／「どれでも構わない：
キーごとのログをやめる、`trace` に下げる、あるいはキー数を担う1行のサマリに置き換える。」）

三つのうちどれかで軽くがっかりするなら、あなたは行1にいるのだから、どれかを言うべきである。行2は、その選択を
本当にレビューしないであろう場合のためにある。

### Bad: コメントが正しく読めるので、コードのほうを直すものとして言い切っている

```markdown
**major** — the header comment at `useBarSender.ts:8` says a failed send is retried once and then
dropped, but `sendBar()` implements no retry and discards the payload immediately on failure

- Implement the retry that `sendBar()`'s comment describes.
```
（訳：Title＝「`useBarSender.ts:8` のヘッダコメントは送信失敗時に1回リトライしてから破棄すると述べて
いるが、`sendBar()` はリトライを実装しておらず失敗時に即座にペイロードを捨てている」／「`sendBar()` の
コメントが記述しているリトライを実装せよ。」）

コメントのほうがより意図的で完全な側に読めるので、それが真実として言い切られてしまっている — しかしここには、
リトライが欠けた半分であって、コードがすでに追い越した計画の残骸ではない、と立証するものが何もない。

### Good: 開示があることが、これを行2に動かす

```markdown
**major** — the header comment and the code it describes disagree about the retry behaviour

- The header comment at `useBarSender.ts:8` says a failed send is retried once and then dropped,
  but `sendBar()` implements no retry and discards the payload immediately on failure.
- The PR body's own "Seams" section defers retry handling to the queue-based sender (a follow-up
  ticket), and nothing states that a retry is still expected in this PR.
- Either implement the retry, or correct the comment to say retries are not in place yet and link
  the follow-up ticket — whichever the author has already decided.
```
（訳：Title＝「ヘッダコメントと、それが記述するコードが、リトライの振る舞いについて食い違っている」／
③リトライを実装するか、リトライはまだ入っていないとコメントを直して後続チケットにリンクするか —
著者がすでに決めているほうを。）

ここで手に入るものは、どちらの側がバグかを何も言っていない：コメントが古びた計画でありうるし、このPRが
意図的に部分的な一歩でありうる。「リトライを足せ」と言い切ることは、報告する代わりにそのスコープの問題を
決めてしまうことになる。

具体的な修正が二つ存在し — リトライを実装する、あるいはコメントに先送りを述べさせる — どちらか一方で矛盾が
解消するので、これは行2であって行3ではない。行1でもない：ここには grep も明示もなく、一方を他方より支持する
ものがない。何かがそれをしたら（PR本文が「コメントは古い、無視せよ」と明言する等）、その修正を名指しして
行1に移れ。

## Row 3 — 名指しできる修正がない

目標が変わる：もはや修正を指示しているのではなく、失われないように**問題を登録している**。書いている場所に
よって二つの形がある。

### Good: PRレビューで — issue を立て、コードからリンクする

```markdown
**major** — `pages/foo/[id].vue:24` swallows `useAsyncData`'s `error`

- On failure the body renders empty, and the reader is shown an article with no text in it.
- There is no fix to include in this PR. Two things have to be decided first.
- Open an issue covering both and link it from a `TODO(#N)` at the fetch site.

`fooBlocks` falls back to `[]` and `isLocked` to `false`, so the failure shows up neither in the UI
nor in the DOM. There are two reasons it cannot be fixed here. No spec defines the failure copy, so
implementing it would make the implementer the author of user-facing text. And this page is mounted
from several routes — the article list, search results, external links — each with a different
layout, so there is no basis for deciding that the failure UI belongs to this one. Where the failure
renders is an open design question.
```
（訳：Title＝「`pages/foo/[id].vue:24` が `useAsyncData` の `error` を握りつぶしている」／①失敗時、
本文は空でレンダリングされ、読み手はテキストのない記事を見せられる ②このPRに含める修正はない。先に
二つのことが決まらねばならない ③両方を扱う issue を立て、fetch 箇所の `TODO(#N)` からリンクする。／
Details＝ここで直せない二つの理由。）

指摘は「エラー処理を検討したほうがよいかも」に軟化されておらず、解けないからといって落とされてもいない。
Summary が事実と指示を担い、修正を名指しできない理由が Details である。

### 修正が新しい issue を開くときの、問題の登録

```markdown
**major** — the STG environment badge renders white text on `#ff2a1f`, a contrast ratio of 3.75:1,
below the 4.5:1 AA threshold that applies to 16px bold

- There is no fix to include in this PR. An accessible color pairing is a design decision, not an
  implementation detail.
- Open an issue carrying the measured alternatives and what has to be decided, and link it from a
  comment on the `stg` entry in `path/to/resolveEnvironmentBadge.ts`.
```
（訳：Title＝「STG環境バッジが `#ff2a1f` 上に白文字をレンダリングしており、コントラスト比 3.75:1 は
16px bold に適用される AA 閾値 4.5:1 を下回る」／②測定した代替案と決めるべきことを担う issue を立て、
該当箇所のコメントからリンクする。）

「調査が必要」だけでは行3ではない — それは作業が抜け落ちた行3である。リンク先の issue こそが、非選択肢を
閉じ、決定を名指しする場所であり、その issue 自身の本文はこのテンプレートではなく
`write-nice-issue-description` で書かれる。
