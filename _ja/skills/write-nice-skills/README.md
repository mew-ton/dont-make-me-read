# write-nice-skills

スキルを書き、レビューする — その `description` を、作業が必要としたときに発火するように。そしてその本文を、
エージェントが規則を読み飛ばすのではなく読むように。

スキルに到達する手段は `description` だけである：エージェントが判断する時点で、本文は文脈に入っていない。
だからその著者は、すでに読んだスキルに照らしてその `description` を判断しており、それを読んでいないものから
どう見えるかを感じ取れない。同じ失敗はもう一段下でも起きる — 自分の reference を言い直す `SKILL.md` は、
誰もその reference を開かない `SKILL.md` である。

スキル以外のドキュメントはレビューしないし、リポジトリ全体のレビューパスでもない。

## The way in（入口）

[ルートの README](../../README.md) が説明するとおりにプラグインをインストールする。そのうえで、どちらかを：

- `/write-skill` と打ち、意図して書く・改訂する。あるいは
- `SKILL.md` を編集して、スキル自身に発火させる。これは model-invoked である — その名前を打つことは決してない。

スキルの費用を計測するには、このディレクトリから：

```bash
bash scripts/count-tokens.sh path/to/SKILL.md              # 5000 トークン予算
TARGET=2000 bash scripts/count-tokens.sh path/to/SKILL.md   # 常時オンのスキル
```

これは、現在デフォルトのモデルに対する入力側トークン数の差分を取る。だから API キーは要らず、モデル世代にも
固定されない。予算超過なら非ゼロで終了する。

## Where the rest lives（残りはどこにあるか）

`SKILL.md` が、各判断をそれを決着させるファイルへ振り分ける：`description` は
`references/writing-descriptions.md`、Bad → Good の対は `references/examples.md`、本文のサイズと形および
一つのスキルを二つに分割することは `references/structuring-skills.md`、それらが使う用語は `GLOSSARY.md`。
ここではなく、そこから始めること。

## Why the rules are not in SKILL.md（なぜ規則が SKILL.md に無いのか）

このファイルは何にもロードされない：`SKILL.md` から参照されていないので、エージェントの文脈を一切消費しない。
以下は、このスキルを保守する人に向けた、この形の論拠である。

`SKILL.md` で reference を要約することは、`description` で本文を要約することが本文を飛ばさせるのと
まったく同じように、その reference を飛ばさせる。一つの機構、二つの階層：

| 要約が置かれる場所 | 読み手が飛ばすもの |
|---|---|
| `description` | 本文 |
| `SKILL.md` | reference |

`SKILL.md` だけで規則を決着させられる著者は、そのスキルを手渡されており、その規則の出所のファイルを開かない。
だから `SKILL.md` が担うのは、なぜそのスキルが存在するのか、どう進めるのか、各 reference へ振り分ける条件で
あり、規則そのものと取り違えられうるものは何も担わない。

routing は二度目のロードを要する。それは検討のうえで却下された：ここでの主題は規則を確実に効かせることで
あって、ロード回数を最小化することではない。

## The two rules that stay in SKILL.md anyway（それでも SKILL.md に残る二つの規則）

- **frontmatter のコメント。** frontmatter は自分の reference を持たず、規則は一文なので、それを述べることは
  何かを要約することにならない。
- **Common Rationalizations。** その表は読み飛ばしに対するガードである。ポインタの後ろにあれば、他のすべてと
  一緒に飛ばされる。

## Where `## Scope` came from（`## Scope` はどこから来たのか）

それは一度も方針ではなかった。`structuring-skills.md` はかつて、インラインに置くものを「scope、core
principles を簡潔に、そして Common Rationalizations のガード」と列挙しており、12 のスキルのうち 9 つが
その一語から `## Scope` という見出しを生やした。それを無視した 3 つ — `dont-make-me-read`、
`review-nice-issues`、`review-self-contained-docs` — は代わりに `## Why this exists` か `## Purpose` で
始まっており、そしてそれが、そのスキルが何のためにあるかを本文が述べていた唯一の 3 つだった。いまその箇条書きが
求めるのは why / how / routing である。
