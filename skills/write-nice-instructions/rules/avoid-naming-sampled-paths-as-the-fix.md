# State the fix as a check, not the sampled instances

Read this whenever a fix names the files that happened to be sampled instead of the check that would
find every instance.

A path or list of paths is evidence for a human reader to weigh against; a coding agent asked to
apply the fix instead treats every instance it is shown as the complete set to touch, since it has no
reason to go looking past what was given. If the property behind the finding is machine-checkable —
a line count, a ratio, a naming pattern — write Summary's fix as that check itself, applied over
whatever scope Title already claims, instead of naming the paths that happened to be sampled.

### Bad: a demonstrative pronoun re-narrows a correctly stated Title back to the files just listed

```markdown
**minor** — comments take up most of the file in several places

`path/to/types.ts` is 79% comment lines (52/66) and `path/to/view-model.ts` is 73% (55/75), and
two more files look the same. Compress these into a one-line intent label per declaration that
states only the fact, and drop the per-field justifications.
```

Title already sits at the right altitude — it does not name a file. But "compress **these**" binds
the fix to exactly the files just listed, the same way a file-qualified Title would. A reader can
tell "these" means "at least the files above, and probably others like them," but a coding agent
applying the fix has no reason to look past what it was handed — every other file in the diff at the
same comment ratio is left untouched.

### Good: the fix is the check itself, so no file needs to anchor it

```markdown
**minor** — comments take up most of the file in several places

- Every declaration this PR touches (type, function, field) carries a comment, several run past
  three lines, and most only repeat a per-field justification rather than stating what the
  declaration is for.
- Compress every declaration-level comment of three lines or more in this diff into a one-line
  intent label that states only the fact, and drop the justifications.
```

The fix is now a rule ("3+ lines → compress") instead of a set of paths, so it already covers every
file the diff touches — there is nothing for "these" to under-select, and nothing left over for a
later review to have to re-flag.

The same applies on a re-review: re-state the original check across everything it should cover,
rather than re-narrowing it to only the files that happened to be sampled this time. A sample that
came back clean is evidence about the files it actually covered — it is not evidence that files
outside the sample are clean too; silence about them is silence, not a clean bill.
