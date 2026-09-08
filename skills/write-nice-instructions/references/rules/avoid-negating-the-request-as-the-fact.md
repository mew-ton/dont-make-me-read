# Avoid negating the request as the fact

Read this whenever 表題 reads like the request with a "not" inserted.

"Extract this to a named computed" rewritten as "not extracted to a named computed" is checkable,
but it is still the request wearing 表題's shape — it names the absence of what was asked for, and
carries no more information than the ask itself. The fact sits upstream of the request: what is
happening today, in the code, that the request is a response to?

### Bad: 表題 only negates the request

```markdown
`MemberRequirementDetail.vue:140` で複合条件を `v-if` に直接埋め込んでいる（named computed 化されていない）
```

表題 is the request ("named computed として切り出す") with the polarity flipped, not an observation
— "〜化されていない" restates what the fix would do, in reverse, and carries no more information
than the ask itself. (It also fuses in the one file that happened to trigger it — a second,
independent problem that [`avoid-fusing-the-instance-into-the-title.md`](avoid-fusing-the-instance-into-the-title.md)
covers; fixing one does not excuse the other.)

### Good: 表題 names the behaviour the request responds to

```markdown
複合条件・複雑な条件式が template に直接書かれている
```

The fact is upstream of the request: what the template is actually doing today (a condition written
inline), not the mirror image of what the writer wants instead (extracted to a computed). This is
what justifies the fix without the title itself being the ask, flipped.

This same move applies when the finding proposes a better idea rather than reporting something
broken: the upstream fact does not have to be "why the code is broken"; it can be "why the code is
shaped the way it is today" — never the proposal's own negation.
