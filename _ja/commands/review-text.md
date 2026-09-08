---
description: PRの説明文と、そのPRが変更するコードコメントを自己完結性で監査する。
argument-hint: "[<pr-url-or-number>] [--repo <owner/repo>] [--worktree <path>] [--comment]"
---

この対象に対して `review-self-contained-docs` スキルを走らせる。引数は与えられたまま素通しで渡すこと。
それらの定義はそのスキルの Inputs 表にある。

引数なしなら、現在のブランチのPRをレビューする。

$ARGUMENTS

> 【訳注】`argument-hint` に `--comment`（PRへのインラインコメント投稿）が含まれている。
> `README.md` のコマンド表はこの投稿機能に触れていない。
