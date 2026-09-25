# `scripts/check-examples.sh`（コメント部の和訳）

シェルスクリプト本体は訳していない。設計を説明しているコメントだけを訳す。

## ファイル冒頭のヘッダ

> 二つの reference ファイルが、出荷されている description を引用している：`examples.md` の Good ブロックと、
> `writing-descriptions.md` の worked opening である。これは、その一つずつがいまもそのスキルの live な
> description とバイト単位で一致することを検査する。
>
>   `bash <このスキルのディレクトリ>/scripts/check-examples.sh [skills-dir]`
>
> どれかが古びていたら、最初に食い違った行を印字して非ゼロで終了する。

## `goods` の上のコメント

> Good ブロックとは、`**Good**` の行の後に来るフェンス付きブロックである。

## `pairs` の上のコメント

> Bad がその Good より長い場合、その Bad は当の Good に何かを足しただけのもので、他は何も変えていない。
> それを検査する。片方のコピーだけを編集したら落ちるように。

## `descriptions` の上のコメント

> `writing-descriptions.md` は description の形を一度だけ、プレースホルダで示し、そのあとは worked opening
> として live な description を引用している。形のほうは、中にプレースホルダが入っているブロックである。
> それ以外はどれも、出荷されている description でなければならない。
