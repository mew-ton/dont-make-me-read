# frontmatter を書く

スキルの、あるいは子スキルの frontmatter を設定するときに読むこと。

## What is required（必須のもの）

`name` と `description`。インストールされているすべてのスキルについて、毎ターン事前ロードされる二つである。

## What the rest settles（残りが決めること）

他のフィールドはすべて任意で、見つけられるかどうかではなく、どう走るかを決める。

| フィールド | 何を決めるか |
|---|---|
| `user-invocable`、`disable-model-invocation` | どちらの呼び出し元が到達できるか — 人の `/` メニュー、モデル、あるいは両方 |
| `context`、`background`、`model` | それ自身の実行環境として走るのか、そして何のもとで走るのか |
| `allowed-tools` | すでに手の届く範囲のうち、何がプロンプトなしで事前承認されるか |
| `disallowed-tools` | 何に手を伸ばしてはならないか — ツールを取り上げるのはこのフィールドである |

## A child skill's fields（子スキルのフィールド）

親が一つのフェーズを走らせるために起動するスキルは、`name` と `description` に加えて次を持つ。

```yaml
user-invocable: false
disable-model-invocation: false
context: fork
background: false
```

**`context: fork` こそが、それを子にするものである。** 子を、親のターンの延長ではなくそれ自身の実行環境に
する。それがないと、`model` は現在のターンの残り — メインの会話 — に適用される。

**`background: false` が、答えが返るまで親のターンを留める。** 既定は `true` で、それは子が何かを生み出す前に
親へターンを返してしまう。

残る二つは、どのスキルでもする到達可能性の選択である：`user-invocable: false` は子をユーザーの `/` メニューの
外に置き、`disable-model-invocation: false` はモデルを通す — それが子の唯一の呼び出し元である。

`model` はコストと能力を天秤にかける。省けば fork は親のものを継承する。**ツールセット**のために取る fork は、
それを `allowed-tools` と `disallowed-tools` で狭める。どのスキルでも使う、同じ二つのフィールドである。

## No comments（コメントを書かない）

そのすべてをコメントなしで書くこと。frontmatter はそのスキルが発火するたびにロードされる。その*選択*に議論が
要るフィールドが要するのは、著者が反論できる散文 — 本文 — であって、末尾の `#` ではない。設定をただ言い直す
一文は、本文が落とすものである。
