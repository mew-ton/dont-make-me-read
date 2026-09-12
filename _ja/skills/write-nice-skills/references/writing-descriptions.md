# description を書く

`description` は、エージェントがそのスキルを発火させるかどうかを決めるときにロードされる唯一のテキストで
ある。それ単体で判断可能でなければならず、手順を漏らしてはならない。

## 1. どの description も満たすべきこと

### 1.1 基本は命令形、主語が必要なら三人称

`Use this skill when …` — `I check your issue for …` でも `you are an expert at …` でもない。エージェントが
行動できるのは命令形であり、主語が現れるのは、それを落とすとその文が作業の記述として読まれてしまう場合だけ
である。

### 1.2 スキルが作られたユーザーの意図を示す

その著者が何を強制したかったのかを、一節で、著者の言葉で。たとえば
`keeps a callee from branching on which caller invoked it`。

### 1.3 スキルをいつ適用するものかを書く

機会を名指しする：書かれつつある成果物か、進行中の活動か。

### 1.4 英語で書く

英語の用語こそが、どの言語で打たれようとプロンプトに生き残るものであり、公開するスキルは利用者がどれを打つか
知り得ない。ここで決着するのは description だけで、本文の言語とスキルの出力は別に決まる。

### 1.5 簡潔に書く

**1024文字、厳守。** 意図と機会とトリガーが収まらないなら、そのスキルは仕事を抱えすぎている：水増しや
切り詰めではなく分割せよ。

## 2. description が決して担ってはならないもの

### 2.1 SKILL の実装の要約

詳細なルールや作業の手順。description に書くと、LLM はそれをスキルそのものとして読み、元になった本文を
読み飛ばす。手順、適用する判定基準 — たとえば「決定可能な問題、検査可能な受け入れ条件、スコープ外の境界」 —
そして本文がそれぞれに与える論拠・代償・処方が、すべてこれに当たる。

見分けのつく用語は残る。発火させるのはそれだからである：画面の名前がついた `variant` は作業がどう見えるかで
ある。

### 2.2 このスキル以外の概念の説明

callee とは何か、プルリクエストとは何か、なぜ結合が代償を伴うのか。シンプルにいえばノイズである：エージェント
は知っているし、その文字数は意図から差し引かれる。

## 3. 効果のある文体

### 3.1 意図と機会のどちらを先頭にするか決める

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

### 3.2 発火しない条件を記載する

`DO NOT use this skill when …` — description 自身の機会を否定したものなので、対で一つの使用条件として
読まれる。他の形では雑学として読まれる。

そのスキルが**生み出さないもの**も、それが取り違えの原因になっている場合には閉じる。たとえば：
`DO NOT use this skill when what is wanted is a verdict on whether a dependency is worth keeping`。

### 3.3 leading word を前に出す

スキルは、description と、エージェントが取り組んでいるものとの間で共有された語によって発火する：プロンプト
か、`/` メニューから隠されたスキルなら作業そのものである。その語を、起動の仕事をする先頭付近に置くこと。

- **形式**：自然な文の中に。タグ列ではない、たとえば `Skill / SKILL.md / description —`。キーワードとして
  飾り立てた依頼文でもない。
- **実在の語**：自分のプロンプト、ドキュメント、コードに現れる用語。キーワードのように聞こえるだけのラベル
  ではない。
- **枝ごとに一つ**：同じ枝を言い換えただけの同義語は重複である。
- **翻訳を生き延びる語**：ファイル名、ツール名、そのまま打ち込む専門用語 — たとえば `SKILL.md`、`issue`、
  `PR`。単一言語のチームから出ないスキルは、そのチームが実際に打つフレーズを追加で引用してよいが、公開する
  スキルはそうしてはならない。第二言語のキーワード列は description を膨らませ、同期がずれていくだけである。

### 3.4 固有名詞・名指しの参照は控える

他のスキル名は、可能な限り避けたほうが良い。具体名はルーティング表として読まれ、*この*成果物は自分のものか
という、境界がそもそも存在する理由である問いをエージェントに問わせなくする — たとえば
`DO NOT use for an architecture doc (that is write-nice-architecture-docs)`。文字数も食い、そのスキルが
改名された日にもう一度食う。リポジトリの不変条件も同じことを言う：スキルは自分の description によって到達
されるか、さもなくば到達されない。

禁止はしない。ファイル名やパスが機会そのものである場合があり、そのときはそれがトリガーである。ただ、
そのスキルが統べるサブフォルダ・サブパッケージのルートに配置したほうが、何も名指しせずに済むことが多い。

名指しとして唯一その場を得るのは到達節である — たとえば「also applies when another skill needs …」— 別の
スキルが本当にこれに依存している場合。それは誰も名指ししない。
