# この `_ja/` について（一時ディレクトリ・後で削除する）

`_ja/` は**リポジトリ本体のドキュメントの和訳**を、元のディレクトリ構造そのままにミラーしたもの。
内容整合性を人間が判断するための作業用で、整合性の整理が終わったら
`git rm -r _ja` で丸ごと消す前提。プラグインの動作には一切関与しない。

## 訳の方針

1. **見つかっている不整合は直さず、そのまま訳す。**
   判断材料が目的なので、訳の段階で辻褄を合わせると意味がなくなる。
   矛盾している箇所は矛盾したまま日本語になっている。
2. **見出し構造・箇条書き・表の行順は原文と一対一。**
   原文の `README.md:26` のような行指定から追えるようにするため。
3. **識別子・パス・コマンド名・スキル名・セクション名は英語のまま。**
   `## Background / Why` などの節名は、原文の散文がその英語名で参照しているので訳さない。
4. **コードブロック／Markdown例の中の自然文は訳す。**
   ただし `**major** — ` のような構造マーカー、パス、識別子は原文どおり残す。
   例そのものが判断対象（Titleの先頭句が付いているか等）なので、ここを崩さない。
5. 訳注が必要な箇所は `> 【訳注】` で本文と区別して入れている。

## 対応表

| 和訳 | 原文 |
|---|---|
| `_ja/README.md` | `README.md` |
| `_ja/DESIGN.md` | `DESIGN.md` |
| `_ja/.claude-plugin/plugin.json.md` | `.claude-plugin/plugin.json` |
| `_ja/commands/*.md` | `commands/*.md` |
| `_ja/skills/<name>/SKILL.md` | `skills/<name>/SKILL.md` |
| `_ja/skills/<name>/references/*.md` | `skills/<name>/references/*.md` |
| `_ja/skills/write-nice-instructions/rules/*.md` | `skills/write-nice-instructions/rules/*.md` |
| `_ja/skills/write-nice-issue-description/assets/issue-template.md` | 同 `assets/issue-template.md` |
| `_ja/skills/write-nice-skills/GLOSSARY.md` | `skills/write-nice-skills/GLOSSARY.md` |
| `_ja/skills/write-nice-skills/scripts/count-tokens.sh.md` | `scripts/count-tokens.sh` のコメント部 |

`LICENSE` は訳していない。
