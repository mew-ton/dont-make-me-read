# 修正はチェックとして述べる。サンプルした事例としてではなく

修正が、すべての事例を見つけるチェックではなく、たまたまサンプルされたファイルを名指ししようとしていると
きにこれを読むこと。

パス、あるいはパスの一覧は、人間の読み手が突き合わせて考えるための**証拠**である。しかし修正の適用を頼まれた
コーディングエージェントは、示されたすべての事例を**触るべき完全な集合**として扱う。渡されたもの以上を探しに
行く理由がないからだ。だから指摘の背後にある性質が機械的にチェック可能なら — 行数、比率、命名パターン —
Summary の修正を**そのチェック自体**として、Title がすでに主張しているスコープ全体に適用される形で書け。
たまたまサンプルされたパスを名指しするのではなく。

水準とチェック可能な修正は、二つの別々の勝利である：Title がすでに一つの事例ではなくルールに座っていても、
その修正がなおパスの一覧を手渡していることはありうる。

### Bad: 指示代名詞が、正しく述べられた Title を、直前に列挙されたファイルへ狭め直している

```markdown
**minor** — comments take up most of the file in several places

`path/to/types.ts` is 79% comment lines (52/66) and `path/to/view-model.ts` is 73% (55/75), and
two more files look the same. Compress these into a one-line intent label per declaration that
states only the fact, and drop the per-field justifications.
```
（訳：Title＝「複数箇所でコメントがファイルの大半を占めている」／本文＝「`path/to/types.ts` は
コメント行が79%（52/66）、`path/to/view-model.ts` は73%（55/75）で、さらに2ファイルが同様に見える。
**これらを**、宣言ごとに事実のみを述べる1行の意図ラベルに圧縮し、フィールドごとの正当化を落とすこと。」）

Title はすでに正しい水準に座っている — ファイルを名指ししていない。しかし「**これらを**圧縮せよ」は、修正を
直前に列挙されたファイルにぴったり縛り付ける。ファイル名で限定された Title と同じことである。読み手は
「これら」が「少なくとも上のファイル、おそらく似た他のものも」を意味すると分かるが、修正を適用する
コーディングエージェントには、渡されたもの以上を見に行く理由がない — 同じコメント比率を持つ差分中の他の
すべてのファイルは手つかずのまま残る。

### Good: 修正がチェック自体なので、繋ぎ止めるファイルが要らない

```markdown
**minor** — comments take up most of the file in several places

- Every declaration this PR touches (type, function, field) carries a comment, several run past
  three lines, and most only repeat a per-field justification rather than stating what the
  declaration is for.
- Compress every declaration-level comment of three lines or more in this diff into a one-line
  intent label that states only the fact, and drop the justifications.
```
（訳：①このPRが触れるすべての宣言（型、関数、フィールド）がコメントを持ち、いくつかは3行を超え、
大半はその宣言が何のためのものかを述べるのではなくフィールドごとの正当化を繰り返しているだけである
②この差分の中の、3行以上のすべての宣言レベルのコメントを、事実のみを述べる1行の意図ラベルに圧縮し、
正当化を落とすこと）

修正はもはやパスの集合ではなくルール（「3行以上 → 圧縮」）なので、差分が触れるすべてのファイルをすでに
カバーしている — 「これら」が過小に選択する余地はなく、後のレビューで再度指摘し直さねばならない取りこぼしも
残らない。

**その性質がチェックに還元できないとき** — その判断がなおファイルを読む人間を要するとき — は、証拠を
Summary に留め、実在しない閾値をでっち上げるのではなく、同じパターンが他のファイルにないか確認するよう
読み手に促すだけにせよ。

**再レビューでは**、今回たまたまサンプルされたファイルに狭め直すのではなく、元のチェックを、それがカバー
すべきすべてに対して述べ直せ。きれいだったサンプルは、それが実際にカバーしたファイルについての証拠であって、
サンプル外のファイルもきれいだという証拠ではない — それらについての沈黙は沈黙であって、問題なしの証明では
ない。
