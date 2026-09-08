# State the fix as a check, not the sampled instances

Read this whenever a fix names the files that happened to be sampled instead of the check that would
find every instance.

A path or list of paths is evidence for a human reader to weigh against; a coding agent asked to
apply the fix instead treats every instance it is shown as the complete set to touch, since it has no
reason to go looking past what was given. If the property behind the finding is machine-checkable —
a line count, a ratio, a naming pattern — write 概要's fix as that check itself, applied over whatever
scope 表題 already claims, instead of naming the paths that happened to be sampled.

### Bad: a demonstrative pronoun re-narrows a correctly stated 表題 back to the files just listed

```markdown
**minor** — 複数箇所でコメントがファイルの大部分を占めている

`path/to/types.ts` はコメント行が79%（52/66）、`path/to/view-model.ts`
は73%（55/75）で、他にも同様のファイルが2件ある。これらを宣言ごとに短く事実のみを述べる意図
ラベル1行に圧縮し、フィールドごとの理由付けは削る。
```

表題 already sits at the right altitude — it does not name a file. But "compress **these**" binds the
fix to exactly the files just listed, the same way a file-qualified 表題 would. A reader can tell
"these" means "at least the files above, and probably others like them," but a coding agent applying
the fix has no reason to look past what it was handed — every other file in the diff at the same
comment ratio is left untouched.

### Good: the fix is the check itself, so no file needs to anchor it

```markdown
**minor** — 複数箇所でコメントがファイルの大部分を占めている

- このPRが触れる宣言（type・function・field）はすべてコメントが付いており、複数が3行を超えて
  おり、大半は宣言の意図というよりフィールドごとの理由付けを繰り返しているだけである。
- このdiff内で3行以上ある宣言レベルのコメントはすべて、短く事実のみを述べる意図ラベル1行に
  圧縮し、理由付けは削る。
```

The fix is now a rule ("3+ lines → compress") instead of a set of paths, so it already covers every
file the diff touches — there is nothing for "these" to under-select, and nothing left over for a
later review to have to re-flag.

The same applies on a re-review: re-state the original check across everything it should cover,
rather than re-narrowing it to only the files that happened to be sampled this time. A sample that
came back clean is evidence about the files it actually covered — it is not evidence that files
outside the sample are clean too; silence about them is silence, not a clean bill.
