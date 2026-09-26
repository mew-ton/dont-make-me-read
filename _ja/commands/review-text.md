---
description: PRの説明文と、そのPRが変更するコードコメントを自己完結性で監査する。
argument-hint: "[<pr-url-or-number>] [--repo <owner/repo>] [--worktree <path>] [--comment]"
---

この対象に対して `review-self-contained-docs` スキルを走らせる。引数は与えられたまま素通しで渡すこと。
それぞれが何を意味するかは、そのスキルが決着させる。

引数なしなら、現在のブランチのPRをレビューする。

$ARGUMENTS
