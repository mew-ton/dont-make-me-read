# このスキルの規則がどこから来たか

このファイルは何にもロードされない：`SKILL.md` から参照されていないので、エージェントの文脈を一切消費しない。
これがあるのは、保守する人が、受け継いだ規則と自分たちで発明した規則を見分けられるようにするため、そして
各上流が動いたときに再確認できるようにするためである。

上流は動く。`writing-for-agents` は v1.1 まで `writing-great-skills` という名前で、別名も残さず改名された。
そしてこのスキルは何ヶ月も古い名前を引用し続け、その間なにも壊れなかった — 自分が所有しないファイルへ刺さった
矢であり、`find-document-dependencies` が記述し、機械的には誰も捕まえないものである。規則の帰属を信じる前に、
以下の出典を読み直すこと。

## 出典

| 出典 | 場所 |
|---|---|
| **Skill authoring best practices**（Anthropic） | <https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices> |
| **`writing-for-agents`**（Matt Pocock） | <https://github.com/mattpocock/skills> の `skills/productivity/writing-for-agents/`、およびそこから開示される `SKILL-MECHANICS.md` |
| **`agent-skills`**（Addy Osmani） | <https://github.com/addyosmani/agent-skills> の `docs/skill-anatomy.md` |
| **`skill-creator`**（Anthropic） | Claude に同梱。`scripts/quick_validate.py` が仕様の機械可読な形である |
| **Skill creation best practices**（agentskills.io） | <https://agentskills.io/skill-creation/best-practices>、およびそこがリンクする specification |

## それぞれが何を与えているか

### Anthropic の best practices

- **常に三人称**：「description はシステムプロンプトに注入されるので、視点が揺れると発見の問題を起こしうる」。
  ここの description は、これを読むまですべて命令形だった。`Applies when …` と `Does not apply when …` が、
  その対のなれの果てである。
- 硬い上限：`name` は64文字以内、小文字・数字・ハイフンのみ、XMLタグ不可、予約語 `anthropic` と `claude`
  は不可。`description` は空でなく、1,024文字以内、XMLタグ不可。`quick_validate.py` が同じ数値を強制する。
- description が何のためにあるか：「Claude はそれを使って、100個以上ありうるスキルの中から正しいものを
  選ぶ」。だから description はスキルが何をするか*と*いつ使うかを担い、実装は `SKILL.md` の残りが担う。
- **同梱ファイルは一段だけ**。そしてその機構：入れ子になったファイルは部分的にしか読まれない — 「Claude は
  ファイル全体を読む代わりに `head -100` のようなコマンドで中身を覗き見ることがある」。
- `SKILL.md` は500行以内。
- 何が無料で何がそうでないか：全スキルの name と description だけが事前ロードされ、同梱ファイルは読まれる
  まで一切かからない。
- 評価駆動の開発 — ドキュメントを書く前に評価を書き、最低3つ、そしてそのスキルが走るすべてのモデルで試す。
- このスキルが自分の言葉で言い直しているアンチパターン：既定値ひとつと逃げ道で足りるところで選択肢を並べる、
  用語を揺らす、時期に依存した書き方をする。

### `writing-for-agents`

- 語彙：**leading word**、**context pointer**、**progressive disclosure**、そして **two loads** — 毎ターン
  支払う context load と、そのスキルの存在を覚えていなければならない人が支払う cognitive load。
- **sequence** による切断：完了後の手順を隠し、目の前の作業の邪魔をさせない。あちらの `## When to Split` が
  うちの `## When to split` の直接の出典である。
- **trigger word** による切断は、開示先の `SKILL-MECHANICS.md`（`## Splitting by invocation`）から。そこには
  model-invoked と user-invoked の選択、そして **router skill** のパターンもある。
- 各ステップの**鋭い完了条件**、およびそこから導かれる順序：曖昧な境界は、sequence を分割する前に鋭くする。
- **pruning** — モデルが促されなくても従う no-op を取り除くこと。

### `agent-skills`

- **`## Common Rationalizations`** というセクション名そのまま、そして2列 `| Rationalization | Reality |`。
  埋め方の規則も：エージェントが実際に口にした言い訳を毎回捕まえ、それぞれに事実に基づく反論を付ける。
- そのアナトミーのうち、このスキルが取っていない2節：**Red Flags**（そのスキルが破られている観察可能な兆候）
  と **Verification**（どのチェックボックスも証拠で答えられるチェックリスト）。

### agentskills.io

- **まとまりのある単位。** スキルは、関数がそうであるように一単位の作業を覆う。狭すぎれば一つの作業で複数の
  スキルがロードされ、それぞれの指示を突き合わせる羽目になる。広すぎれば正確に起動できない。これは*いつ
  分割しないか*に答える規則であり、他の出典はそこを暗黙にしている。
- **詳細はほどほどに。** 「あらゆるエッジケースを網羅している自分に気づいたら、その大半はエージェント自身の
  判断に任せたほうがよくないか考えること」。
- 本文の予算の **5,000トークン**側。そこがリンクする specification のものであり、他の出典が与える500行と
  並ぶ。
- context pointer は**いつ**そのファイルをロードするかを述べる — 「APIが200以外を返したら
  `references/api-errors.md` を読む」 — 何についてのファイルかではない。
- **宣言ではなく手続きを。** 一つの事例に対して何を出力するかではなく、ある種類の問題にどう取り組むかを
  教える。
- **Gotchas** をインラインに：まっとうな前提を裏切る、その環境固有の事実。それを知らないエージェントは、
  それが書いてあるファイルをロードさせる条件を認識できないからである。エージェントを訂正する羽目になった
  たびに足すこと。
- このスキルが担っていないパターン：出力テンプレート、進捗チェックリスト、検証ループ、
  plan-validate-execute、そして同じロジックを毎回作り直しているのを見つけたらスクリプトを同梱すること。

### `skill-creator`

- 実行可能な仕様：`scripts/quick_validate.py` は上記の上限を破る name と description を拒否し、公開スキルの
  frontmatter には `name`、`description`、`license`、`allowed-tools`、`metadata`、`compatibility` しか許さない。
- description の発火を測るハーネス：`scripts/run_loop.py` が、評価セットを train と held-out test に分けて、
  description が実際にどれだけ発火するかを測る。
- 逆方向への注意：Claude はスキルを*過少*発火させる傾向があるので、description は「少し押しつけがましく」
  書いてよい。

## このリポジトリ自身のもの

- 活動全体でオンのスキルの **2000トークン予算**、予算がファイルではなく同時に立つスキルの集合に属すると
  いう枠、そして推定ではなく計測する `scripts/count-tokens.sh`。5000トークンという数字は agentskills.io の
  specification のものであり、他の出典は行数で数える。
- **`Forces the X that Y.`** を、作業が何も名指ししないスキルの先頭に置き、成果物を名指しするスキルには
  `Writes and revises …` と `Applies when …` を置くこと。この形は Dietrich Gebert の `ponytail` のものだが、どちらを使うかを
  「そのスキルが成果物より長生きするか」から導く規則はうちのものである。
- **`Does not apply when …`** という境界の固定形：機会を否定したもの。
- **delegation** による切断、および子スキルの frontmatter と命名。
- **Staying in force** — 自分をロードしたターンを越えて生き延びる必要があるスキルのために。
- description が同じことを言っていても、本文がそのスキル自身の説明を担うという規則。

## このリポジトリが承知のうえで違えているところ

- **否定。** `writing-for-agents` は否定を刈り取り、肯定の目標を促す。このリポジトリは2箇所で意図的に否定を
  使う：誤発火を止めるために存在する境界と、禁止を裏返しで述べると弱く届く DON'T リストである。
- **frontmatter。** ここのスキルはすべて `user-invocable`、`disable-model-invocation`、`context`、
  `background` を設定している。これらは Claude Code プラグインのフィールドであり、公開スキルのバリデータは
  拒否する。これはプラグインなのでここでは正しく、そしてどこへも持ち出せない。

## これらへの到達について

`agentskills.io` はこの環境の network egress proxy に遮断されている。その best practices がこのリポジトリに
届いたのは、セッションに貼り付けられたテキストとしてであって、ここにいる誰かが取得できるページとしてでは
ない。それ以外はすべて出典そのものから読んだ。
