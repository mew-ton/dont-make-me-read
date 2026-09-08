# Avoid fusing the instance into the title

Read this whenever a fact reads true only because of the one file it names.

A Title can be one honest fact and still sit at the wrong altitude: fusing the rule with the one
instance that broke it. **Test it with the swap test**: does the same Title still read true pointing
at a different file? If not, the file, the comparison, and the reasoning are evidence, not the fact,
and belong in Summary as separate bullets — where, then why, then the fix.

### Bad: the rule and its one instance fused into Title

```markdown
The comment attached to `FooDetail.vue:4-16` is too long

- It carries the related issue and incident history, all for a change that only adjusts a width.
- The same tendency shows up in various other places.
- Please review the comments.
```

Swapping the file breaks the sentence — it stops being about this bug and starts being about a
different one. That means the file is evidence, not the fact Title should state — and Summary
already says as much ("the same tendency shows up in various other places"), which makes Title
still naming just the one file a missed abstraction, not a lack of awareness. The fix is also vague
("please review the comments") where the Good version below states a checkable rule.

### Good: Title names the rule the instance broke

```markdown
Comments are too long

- An LLM tends to write verbose, flat comments that run to three lines or more.
- Even a supplementary comment becomes text the reader has to stop and work through once that
  tendency is strong enough.
- Delete or compress to one line any comment that, after the fix, runs past three lines excluding
  blank lines.
```

Title now reads true for any comment that grew this way, anywhere it recurs. Summary grounds it in
the mechanism (LLM comment habits) and the checkable fix, rather than the one path that happened to
trigger it this time — this example generalizes all the way, with no file needed to anchor it.

**This does not mean stripping every path from Title.** `` `validate.ts:14` returns no field name on
a validation failure `` keeps its path because the site *is* the fact — nothing else exhibits the
same behaviour, so there is no rule to abstract to above the instance. Apply the swap test before
deciding: if the finding is about a pattern that could recur elsewhere, evidence — a path, a quoted
value, a scoping comparison — belongs in Summary, not Title.

**Altitude and a checkable fix are two different wins, and this example happens to get both.** Title
sits at the rule, not the instance (this file's concern); separately, its fix is already stated as a
countable check ("compress any comment past three lines") rather than a list of files to look at —
[`avoid-naming-sampled-paths-as-the-fix.md`](avoid-naming-sampled-paths-as-the-fix.md) covers that
win on its own. When the property behind a finding cannot be reduced to a check like this one — the
call still takes a human reading the file to make — keep the evidence in Summary and simply invite
the reader to check other files for the same pattern, rather than inventing a threshold that isn't
really there.
