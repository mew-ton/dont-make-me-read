# Avoid negating the request as the fact

Read this whenever Title reads like the request with a "not" inserted.

"Extract this to a named computed" rewritten as "not extracted to a named computed" is checkable,
but it is still the request wearing Title's shape — it names the absence of what was asked for, and
carries no more information than the ask itself. The fact sits upstream of the request: what is
happening today, in the code, that the request is a response to?

### Bad: Title only negates the request

```markdown
**minor** — `FooDetail.vue:140` embeds a compound condition directly in `v-if` (not extracted into
a named computed)
```

Title is the request ("extract it into a named computed") with the polarity flipped, not an
observation — "not extracted into…" restates what the fix would do, in reverse, and carries no more
information than the ask itself. (It also fuses in the one file that happened to trigger it — a
second, independent problem that
[`avoid-fusing-the-instance-into-the-title.md`](avoid-fusing-the-instance-into-the-title.md)
covers; fixing one does not excuse the other.)

### Good: Title names the behaviour the request responds to

```markdown
**minor** — compound and complex conditional expressions are written directly in the template
```

The fact is upstream of the request: what the template is actually doing today (a condition written
inline), not the mirror image of what the writer wants instead (extracted to a computed). This is
what justifies the fix without the title itself being the ask, flipped.

This same move applies when the finding proposes a better idea rather than reporting something
broken: the upstream fact does not have to be "why the code is broken"; it can be "why the code is
shaped the way it is today" — never the proposal's own negation.
