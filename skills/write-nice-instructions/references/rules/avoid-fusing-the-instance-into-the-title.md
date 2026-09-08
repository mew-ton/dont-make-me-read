# Avoid fusing the instance into the title

Read this whenever a fact reads true only because of the one file it names.

A 表題 can be one honest fact and still sit at the wrong altitude: fusing the rule with the one
instance that broke it. **Test it with the swap test**: does the same 表題 still read true pointing
at a different file? If not, the file, the comparison, and the reasoning are evidence, not the fact,
and belong in 概要 as separate bullets — where, then why, then the fix.

### Bad: the rule and its one instance fused into 表題

```markdown
`MemberRequirementDetail.vue:4-16` に付随するコメントが長すぎる

- width サイズを変更するためだけに、関連する issue, インシデント等の情報を含んでいます。
- その他各所でも同様の傾向が見られます
- コメントを見直してください
```

Swapping the file breaks the sentence — it stops being about this bug and starts being about a
different one. That means the file is evidence, not the fact 表題 should state — and 概要 already
says as much ("その他各所でも同様の傾向が見られます"), which makes 表題 still naming just the one
file a missed abstraction, not a lack of awareness. The fix is also vague ("見直してください") where
the Good version below states a checkable rule.

### Good: 表題 names the rule the instance broke

```markdown
コメントが長すぎる

- LLM は基本的に冗長・平坦なコメントを３行以上にわたって書く癖があります。
- 補足的なコメントであっても、この傾向が強ければ、一度足を止めて読まざるを得ない文章になります。
- 修正後に空行を除いて合計３行を超えるようなコメントがあれば、削除するか、１行に圧縮をしてください
```

表題 now reads true for any comment that grew this way, anywhere it recurs. 概要 grounds it in the
mechanism (LLM comment habits) and the checkable fix, rather than the one path that happened to
trigger it this time — this example generalizes all the way, with no file needed to anchor it.

**This does not mean stripping every path from 表題.** `` `validate.ts:14` returns no field name on a
validation failure `` keeps its path because the site *is* the fact — nothing else exhibits the same
behaviour, so there is no rule to abstract to above the instance. Apply the swap test before
deciding: if the finding is about a pattern that could recur elsewhere, evidence — a path, a quoted
value, a scoping comparison — belongs in 概要, not 表題.

**Altitude and a checkable fix are two different wins, and this example happens to get both.** 表題
sits at the rule, not the instance (this file's concern); separately, its fix is already stated as a
countable check ("3行を超えるコメントがあれば圧縮する") rather than a list of files to look at —
[`avoid-naming-sampled-paths-as-the-fix.md`](avoid-naming-sampled-paths-as-the-fix.md) covers that
win on its own. When the property behind a finding cannot be reduced to a check like this one — the
call still takes a human reading the file to make — keep the evidence in 概要 and simply invite the
reader to check other files for the same pattern, rather than inventing a threshold that isn't
really there.
