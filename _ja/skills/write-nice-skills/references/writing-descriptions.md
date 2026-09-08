# description を書く

スキルの `description` や frontmatter を書く／レビューするときに読むこと。`description` は、エージェントが
そのスキルを発火させるかどうかを決めるときにロードされる唯一のテキストなので、それ単体で判断可能でなければ
ならず、手順を漏らしてはならない。四つのルール、それからサイズ制限。

## 1. 三人称、what + when

三人称で書き、**スキルが何をするか**と**いつ適用するか**の両方をカバーして、エージェントが description
だけから判断できるようにする。到達節（「also applies when another skill needs …」）は、別のスキルが本当に
これに依存しているときにだけ足す。

## 2. description に手順を書かない

手順を追った指示を description に決して置かない。手順がそこにあると、エージェントは description からそのまま
行動できると信じて本文を決してロードせず、そのスキルが届けるために存在する指示が飛ばされる。*what* と
*when* を述べ、*how* は本文に留めよ。

## 3. leading word を前に出す

スキルは、description の中の語が、エージェントが取り組んでいるものの中の語と合致したときに発火する。それが
プロンプトであることもある。そうでないことも多い：`/` メニューから隠されたスキル（`user-invocable: false`）は
作業の途中で発火し、利用できる語は作業そのものの中にあるもの — 編集中のファイル、書かれつつある成果物、
コードがすでに使っている用語 — だけである。したがって description に **leading word** — このスキルが必要と
されるときに現れる語、何がそれを生むにせよ — を仕込み、それが起動の仕事をする場所である先頭付近に置くこと。

- **形式**：自然な文の中にある leading word。スラッシュ区切りのタグ列（`Skill / SKILL.md / description —`）
  ではなく、キーワードとして飾り立てた依頼文でもない。
- **もっともらしい語ではなく、実在の語**：自分のプロンプト、ドキュメント、コードに実際に現れる用語を使う —
  キーワード*のように聞こえる*だけのでっち上げのラベルではない。
- **枝ごとにトリガー一つ**：別個の状況をそれぞれ一度ずつ名指しする。同じ枝を言い換えただけの同義語は重複で
  ある。
- **トリガーの言語**：description は英語である（ルール4）ので、共有される語は、エージェントが読んでいる
  ものが何語であれそこに生き残る語でなければならない — ファイル名、ツール名、固有名詞、そのまま打ち込む
  専門用語（`SKILL.md`、`issue`、`PR`、`description`）。単一言語のチームから出ないスキルは、そのチームが
  実際に打つフレーズを、英語の文の中の引用された例として*追加で*埋め込んでよい。公開するスキルはそうしては
  ならない：利用者がどの言語でプロンプトを打つか知り得ず、第二言語のキーワード列は description を膨らませ、
  同期がずれていくだけである。このプラグインのどの description もそれを持たないのは、そのためである。
- **本文の素性を削る**：description はトリガーと到達節に留める。本文がすでに説明していることはここに属さない。

### Bad → Good

**Bad** — 先頭にタグ列、でっち上げのキーワード、手順の漏れ：

```text
Skill authoring / SKILL.md / quality — first read the whole file, then rewrite
each section, then check the frontmatter, for great skills and better writing.
```

**Good** — leading word が先頭、what + when、手順なし：

```text
SKILL.md authoring — write a skill's description and body so it fires reliably
and stays lean. Use when writing, editing, or reviewing a skill, a SKILL.md, or
its description.
```

## 4. 英語

別の言語でプロンプトを打つときでも、description は英語で書く。英語の用語は、いずれにせよプロンプトに生き
残るもの — ファイル名、ツール名、ライブラリ名 — であり、公開されたスキルは利用者がどの言語で打つか知り得
ない。

三つの言語が別々に決まり、ここで決着するのは最初の一つだけである：**description**（常に英語）、**本文**
（一つのチームを越えて出荷されるスキルではこれも英語。エージェントが読むので）、そして**そのスキルが生み
出す出力** — issue、指摘、ドキュメント — これは*その*読者がすでに使っている言語に属する。最後のルールは各
writing スキルが自分で述べる。このファイルの「英語」を、スキルがエージェントに何を書けと指示するかにまで
持ち下ろさないこと。

## Size（サイズ）

`description` には **1024 文字**のハード予算がある。what + when + トリガーが収まらないなら、そのスキルは
たいてい仕事を抱えすぎている — description を水増ししたり切り詰めたりするのではなく、分割せよ
（[`structuring-skills.md`](structuring-skills.md) を参照）。
