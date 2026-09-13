# Worked examples（実例）

逆向きに走っている片方向の矢印、両方向の対、そして両端が一つのファイルの中にある辺。

## Contents

- ドキュメントから出ていくのではなく、ドキュメントへ刺さっている片方向の矢印
- 二つのシステムに分かれた、両方向の対
- 両端が一つのファイルの中にある辺

## ドキュメントから出ていくのではなく、ドキュメントへ刺さっている片方向の矢印

コードがどこにあるかを記述しているアーキテクチャドキュメント：

```markdown
## Layers

The parsing layer is `lexer` and `parser`. The analysis layer is `resolver` and `typeck`.
```

（訳：パース層は `lexer` と `parser`。解析層は `resolver` と `typeck`。）

この四つのモジュールはいずれも、いまやこのファイルと強い依存関係にある：どれか一つを改名すればこの
ファイルは誤りになる。五つ目も同様で、誰かがそれを書いた日に — それは単に欠けているだけであり、この節は
完全な答えであるかのように読まれ続ける。

ここには何もリンクがないので、何もチェックしない。その文は構文として通ったまま、自信に満ちたまま、
何の兆候も出さない。見つかり方は、貢献者がそれを信じて何かを間違った場所に置くこと — つまり、かかる
はずのコストがすでにかかったあとである。

**報告の形は一本の辺：**

```
the modules → the doc   strong   §Layers
  fires on: any module added, removed, or renamed
  span:     "The parsing layer is `lexer` and `parser`. …"
```

ドキュメントが統べているはずのものから、ドキュメントへと刺さっている矢印。それがここで許されるかは
呼び出し元の問いであり、それが存在すること自体がこのスキルの答えである。

同じ節を、何も固定せずに書いたもの：

```markdown
## Layers

A module is in the parsing layer if it turns text into a tree without resolving a name, and in the
analysis layer if it resolves names against a tree it did not build.
```

（訳：名前を解決せずにテキストを木に変えるならパース層。自分が作っていない木に対して名前を解決するなら
解析層。）

矢印は逆向きになり — このドキュメント → 任意のモジュール — 戻ってくるものは一本もない。新しいモジュールは
自分で自分の居場所を決められるようになり、どちらの定義にも当てはまらないモジュールのほうが、譲るべきものに
なる。

## 二つのシステムに分かれた、両方向の対

一つのロールアウトが、計画されるページと、作業に使われるトラッカーの二箇所にある。ページ：

```markdown
## Rollout

Three phases. Phase 2 begins once the migration ships.
```

（訳：3フェーズ。フェーズ2は移行がリリースされ次第開始する。）

トラッカーの項目：

```markdown
Blocked until the migration ships — phase 2 of the rollout plan (link).
```

（訳：移行のリリースまでブロック — ロールアウト計画のフェーズ2（リンク）。）

リンクは弱で、そしてツールに見えるのはその部分だけである。実際に壊れるのはその両側の散文であり、しかも
両方向に壊れる：

- ページ側でフェーズ数を変える、あるいはフェーズ2の開始条件を変えると、トラッカーの項目が誤りになる。
- トラッカー側でフェーズ2を分割する、あるいはブロック条件を変えると、ページが誤りになる。

**報告の形は、二つの findings ではなく一つの対：**

```
the page → the tracker item   strong   "Blocked until the migration ships — phase 2 …"
  fires on: the phase count or phase 2's trigger changing on the page
the tracker item → the page   strong   "Three phases. Phase 2 begins once the migration ships."
  fires on: the blocking condition or the phase's shape changing in the tracker
both ways: one plan in two places, neither system able to see the other
weak, same span: the link to the page — still resolving long after the two disagree
```

対であることが findings である。片方向の辺を二本として報告すれば、片付けるべき小さな不整合が二つあると
読まれる。対として報告すれば、それが実際にそうであるもの — 一つの計画に所有者が二人いる状態 — として
読まれ、どちらの場所がそれを保持するのかを呼び出し元が決めることになる。

## 両端が一つのファイルの中にある辺

スキルは、使ってよいツールを frontmatter で宣言し、何をするかを本文で述べる。

```yaml
allowed-tools:
  - Bash(git log:*)
```

```markdown
## The pass

1. **Read for candidates.** Work through the document with `references/what-counts.md` — the
   shapes a dependency takes, and how the strong ones surface.
```

（訳：候補を読み出す。`references/what-counts.md` — 依存が取る形と、強いものがどう表に出てくるか — を
手にドキュメントを通す。）

この宣言は、書かれた時点では真だった：パスは何が変わったかを git に尋ねるだけで、何も読んでいなかった。
そこにファイルを開くステップが加わり、同じファイルの先頭にある行は、それを偽にしたコミットの中で古びた。

**報告の形は一本の辺：**

```
the body → the frontmatter   strong   allowed-tools
  fires on: a step being added that needs a tool the declaration does not list
  span:     "allowed-tools"
```

ファイル境界を何も越えていないので、外部の何もそれを指摘しない：古びたリンクはなく、差分を読むレビュアー
の目には本文の変更が映るだけである。宣言とは、本文をいじっている最中に読み返される見込みが最も低い部分
であり、それこそが辺に値する理由である。
