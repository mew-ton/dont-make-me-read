# Fitting the budget

Read this whenever a draft is running long, before compressing its prose.

Three statements and 20 lines are not achievable by compressing prose; they are achievable by removing
what does not change what the reader does:

| Cut | Why |
|---|---|
| Preamble and meta-narration ("この PR を確認しました", "以下に詳しく説明します") | The reader knows what they opened. Start at the fact. |
| Praise and cushioning | Carries no action, and dilutes the finding after it. |
| Code, diffs, or issue text quoted back | The reader has it. Point at `path:line` instead. |
| An inventory of what you checked | Process, not instruction (`write-self-contained-docs`). |
| The same point in a summary, the details, and a closing line | Say it once, where the reader acts from. |
| Vague quantifiers standing in for a spec ("適切に", "必要に応じて") | They read as complete and specify nothing. |

If 詳細 will not fit in 20 lines, that is usually **two instructions in one** — see
[`one-instruction-one-application.md`](one-instruction-one-application.md) rather than compressing
further.

**The exception is a case whose evidence is bulky** — a measurement table, a repro log. Evidence in a
code block sits outside the budget; evidence narrated in prose does not, so put it in the block. Once
a table's own size is what would overflow 詳細, fence the table itself in the text you actually post.
