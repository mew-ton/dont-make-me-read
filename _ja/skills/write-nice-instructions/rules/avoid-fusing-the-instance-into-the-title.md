# 事例を title に融合させない

事実が、そこで名指しされている1ファイルのおかげでのみ真として読めるときは常にこれを読むこと。

Title は一つの誠実な事実でありながら、なお誤った水準に座りうる：**ルールを、それを破った一つの事例と融合
させてしまう**という誤り。**swap test でテストせよ**：同じ Title は、別のファイルを指してもまだ真として
読めるか？ 読めないなら、そのファイル、その比較、その理由づけは証拠であって事実ではなく、Summary に個別の
箇条書きとして — どこで、次になぜ、次に修正、の順で — 属する。

### Bad: ルールと、その一つの事例が Title に融合している

```markdown
The comment attached to `FooDetail.vue:4-16` is too long

- It carries the related issue and incident history, all for a change that only adjusts a width.
- The same tendency shows up in various other places.
- Please review the comments.
```
（訳：Title＝「`FooDetail.vue:4-16` に付いたコメントが長すぎる」／①幅を調整するだけの変更のために、
関連 issue とインシデントの経緯を担っている ②同じ傾向が他の様々な箇所にも現れている ③コメントを
見直してください）

> 【訳注】この例の Title にも `**<severity>** — ` の先頭句が付いていない（Bad/Good どちらも）。
> `SKILL.md` のテンプレート表の定義と食い違う。

ファイルを差し替えると文が壊れる — このバグについての話ではなくなり、別のバグについての話になってしまう。
つまりファイルは証拠であって、Title が述べるべき事実ではない — そして Summary 自身がそう言っている
（「同じ傾向が他の様々な箇所にも現れている」）ので、Title がまだ1ファイルだけを名指ししているのは、
気づいていないのではなく**抽象化の取りこぼし**である。修正もまた曖昧である（「コメントを見直してください」）。
下の Good 版はチェック可能なルールを述べている。

### Good: Title が、その事例が破ったルールを名指しする

```markdown
Comments are too long

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
修正に接地させている — この例は最後まで一般化しており、それを繋ぎ止めるファイルを必要としない。

**これはあらゆるパスを Title から剥がせという意味ではない。** `` `validate.ts:14` returns no field name
on a validation failure ``（訳：「`validate.ts:14` はバリデーション失敗時にフィールド名を返さない」）は
パスを保つ。その場所**こそ**が事実だからである — 同じ振る舞いを示すものが他になく、事例の上に抽象化すべき
ルールが存在しない。決める前に swap test を適用せよ：指摘が他所でも再発しうるパターンについてのものなら、
証拠 — パス、引用された値、スコープの比較 — は Title ではなく Summary に属する。

**水準とチェック可能な修正は二つの別々の勝利であり、この例はたまたま両方を得ている。** Title が事例では
なくルールに座っていること（このファイルの関心事）。それとは別に、その修正がすでに、見に行くべきファイルの
一覧ではなく数えられるチェック（「3行を超えるコメントは圧縮せよ」）として述べられていること —
[`avoid-naming-sampled-paths-as-the-fix.md`](avoid-naming-sampled-paths-as-the-fix.md) がその勝利を単体で
扱う。指摘の背後にある性質が、この例のようなチェックに還元できないとき — その判断がなおファイルを読む人間を
要するとき — は、証拠を Summary に留め、実在しない閾値をでっち上げるのではなく、同じパターンが他のファイルに
ないか確認するよう読み手に促すだけにせよ。
