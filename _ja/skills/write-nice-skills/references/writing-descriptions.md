# description を書く

`description` は、エージェントがそのスキルを発火させるかどうかを決めるときにロードされる唯一のテキストで
ある。それ単体で判断可能でなければならず、手順を漏らしてはならない。

## DO

- **命令形で書くこと。** `Use this skill when …` — `I check your issue for …` でも
  `you are an expert at …` でもない。主語が現れるのは、それを落とすとその文が作業の記述として読まれてしまう
  場合だけである。
- **スキルが作られたユーザーの意図を示すこと** — その著者が何を強制したかったのかを、一節で、著者の言葉で。
  たとえば `keeps a callee from branching on which caller invoked it`。
- **機会を名指しすること**：書かれつつある成果物か、進行中の活動か。
- **発火しない条件を、その機会を否定した形で書くこと**：`DO NOT use this skill when …`。そうすれば対で一つの
  使用条件として読まれる。他の形では境界が雑学として読まれる。
- **英語で書くこと。** 英語の用語こそが、どの言語で打たれようとプロンプトに生き残るものであり、公開する
  スキルは利用者がどれを打つか知り得ない。ここで決着するのは description だけで、本文の言語とスキルの出力は
  別に決まる。
- **1024文字以内に収めること、厳守。** 意図と機会と境界が収まらないなら、そのスキルは仕事を抱えすぎている：
  水増しや切り詰めではなく分割せよ。

## DON'T

- **SKILL の実装を要約すること** — 作業の手順、適用する判定基準（たとえば「決定可能な問題、検査可能な受け入れ
  条件、スコープ外の境界」）、そして本文がそれぞれに与える論拠・代償・処方。description に書くと、LLM はそれを
  スキルそのものとして読み、元になった本文を読み飛ばす。見分けのつく用語は残る。発火させるのはそれだから
  である：画面の名前がついた `variant` は作業がどう見えるかである。
- **このスキル以外の概念を説明すること** — callee とは何か、プルリクエストとは何か、なぜ結合が代償を伴うのか。
  ノイズである：エージェントは知っているし、その文字数は意図から差し引かれる。
- **他のスキルを名指しすること。** 名指ししたくなるのは、たいていそのスキルがオーケストレーションを含んで
  いるからであり、何をオーケストレーションするのかを述べるのは本文の仕事である — だからその名指しは、一つ上の
  項目と同じ漏洩が一段外に出たものである。さらにそれはルーティング表として読まれ、*この*成果物は自分のものか
  という問いをエージェントに問わせなくする：たとえば
  `DO NOT use for an architecture doc (that is write-nice-architecture-docs)`。リポジトリの不変条件も同じ
  ことを言う：スキルは自分の description によって到達されるか、さもなくば到達されない。ファイル名やパスが
  機会そのものである場合、それはルーティング表ではなくトリガーである — そして、そのスキルが統べるサブフォルダの
  ルートに配置したほうが、何も名指しせずに済むことが多い。
- **タグ列や、キーワードを詰めた依頼文を書くこと。** `Skill / SKILL.md / description —` は文ではなく、
  誰が打つものにも一致しない。
- **第二言語のキーワードを引用すること。** 単一言語のチームから出ないスキルは、そのチームが実際に打つ
  フレーズを追加してよいが、公開するスキルはそうしてはならない。その列は description を膨らませ、同期が
  ずれていくだけである。

名指しとして唯一その場を得るのは到達節である — たとえば「also applies when another skill needs …」— 別の
スキルが本当にこれに依存している場合。それは誰も名指ししない。

## Choosing the lead（どちらを先頭にするか）

**作業はその成果物を名指しするか。** — それは裏側から見れば、そのスキルがその成果物とともに終わるのか、と
いう同じ問いである。

**名指しする → 機会を先頭に。** 作業がその語を口にし、その語がスキルを発火させる。たとえば issue、README、
`ARCHITECTURE.md`、`SKILL.md`：

```text
Use this skill when writing or revising a README, and when adding a section to
one that already exists. DO NOT use this skill when the artifact is an
architecture doc, reference documentation, a tutorial, or a changelog.
```

**名指ししない → 姿勢を先頭に、`Forces the X that Y.`** 誰かがコードやコメントを書いているあいだ効いて
いなければならない規則には共有すべき語が無く、誰も名指ししない機会は、エージェントが diff の途中で忘れる
機会である：

```text
Forces the fact restated at the point of use over the pointer that sends the
reader away to get it … Use this skill when writing a code comment, a docstring,
a PR description, or any text that points elsewhere to be understood. DO NOT use
this skill when the target does not exist …
```

機会はそのあとに続き、活動として名指しされる — たとえば "writing, revising, reviewing, or designing code"。
その活動のあいだ効かせ続けるのは本文の仕事である。

## The leading word（leading word）

スキルは、description と、エージェントが取り組んでいるものとの間で共有された語によって発火する：プロンプト
か、`/` メニューから隠されたスキルなら作業そのものである。その語を、起動の仕事をする先頭付近に置くこと。

- **実在の語**：自分のプロンプト、ドキュメント、コードに現れる用語。キーワードのように聞こえるだけのラベル
  ではない。
- **枝ごとに一つ**：同じ枝を言い換えただけの同義語は重複である。
- **翻訳を生き延びる語**：ファイル名、ツール名、そのまま打ち込む専門用語 — たとえば `SKILL.md`、`issue`、
  `PR`。
