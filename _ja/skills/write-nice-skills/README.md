# write-nice-skills — なぜこの形なのか

このスキルを保守する人のために。このファイルは何にもロードされない：`SKILL.md` から参照されていないので、
エージェントの文脈を消費しない。

## なぜ規則が SKILL.md に無いのか

`SKILL.md` で reference を要約することは、`description` で本文を要約することが本文を読み飛ばさせるのと、
まったく同じように reference を読み飛ばさせる。一つの機構が、二つの段で起きている：

| 要約の置き場所 | 読み飛ばされるもの |
|---|---|
| `description` | 本文 |
| `SKILL.md` | reference 群 |

`SKILL.md` だけで規則を決着させられる著者は、すでにスキルを手渡されていて、その規則の元になったファイルを
開かない。だから `SKILL.md` が担うのは、なぜそのスキルが存在するのか、どう進めるか、どの reference へ
振り分けるかの条件 — そして規則そのものと取り違えられうるものは何も置かない。

routing にすると2ロードになる。それは検討のうえ却下した：ここでの主題は規則を確実に効かせることであって、
ロード回数を最小化することではない。

## それでも SKILL.md に残る二つの規則

- **frontmatter のコメント。** frontmatter は自分の reference を持たず、規則は一文なので、述べることは何かの
  要約にならない。
- **Common Rationalizations。** この表は読み飛ばしに対するガードである。ポインタの後ろに置けば、他のすべてと
  一緒に飛ばされる。

## `## Scope` はどこから来たのか

方針として定められたことは一度もない。`structuring-skills.md` がかつて、インラインにするものとして
「scope、中核の原則の要約、Common Rationalizations のガード」を挙げており、12スキルのうち9つがその一語から
`## Scope` という見出しを生やした。それを無視した3つ — `dont-make-me-read`、`review-nice-issues`、
`review-self-contained-docs` — は代わりに `## Why this exists` か `## Purpose` で始まっており、本文がそのスキル
の目的を述べている唯一の3つだった。この箇条書きは今、why / how / routing を求めている。
