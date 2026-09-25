# Fitting the budget

Read this when a draft is running long, before compressing its prose.

Three statements and 20 lines are not achievable by compressing prose. They are achievable by
removing what does not change what the reader does:

| Cut | Why |
|---|---|
| Preamble and meta-narration ("I have reviewed this PR", "the following explains it in detail") | The reader knows what they opened. Start at the fact. |
| Praise and cushioning | Carries no action, and dilutes the finding after it. |
| Code, diffs, or issue text quoted back | The reader has it. Point at `path:line` instead. |
| An inventory of what you checked | Process, not instruction. |
| The same point in a summary, the details, and a closing line | Say it once, where the reader acts from. |
| Vague quantifiers standing in for a spec ("appropriately", "as necessary") | They read as complete and specify nothing. |
| The same finding restated in a second language | One finding, one language. A translation is a second copy, not a second point. |

If Details still will not fit in 20 lines after that, it is usually **two instructions in one**: go
back to the tells and split it, rather than compressing further.

**The exception is a case whose evidence is bulky** — a measurement table, a repro log. Evidence in a
code block sits outside the budget; evidence narrated in prose does not, so put it in the block. Once
a table's own size is what would overflow Details, fence the table itself in the text you actually
post.
