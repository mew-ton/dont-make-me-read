---
name: dont-make-me-read--extract-dependencies
description: >
  Lists what one claim depends on, as dont-make-me-read defines a dependency, and returns it as one
  JSON record. Step 2 of a dont-make-me-read analysis.
user-invocable: false
disable-model-invocation: false
---

## What it does

Lists what the claim the task names depends on, and returns it as one record. The words are as
`${CLAUDE_SKILL_DIR}/../dont-make-me-read/references/glossary.md` defines them: read its
*Claim*, *Address* and *Dependency*, with their instances, before listing.

## Steps

1. **Read the claim and its address.** The task names the claim by its lines. Read the rest of its
   file only to find what the claim depends on, the way a reader who landed on the claim by search
   would have to.
2. **List what it depends on.** Ask what change elsewhere would mean checking this claim again.
   Look for a word or an identifier it uses and does not define, a value or a behaviour whose
   owner is elsewhere, the reason it holds, and a word that points by position, by role or at a
   conversation.
3. **Find where each one is.** Search the repository and open what the claim names. Keep what the
   claim says to name it apart from where you found it: the first goes in `named_as`, the second
   in `on`.
4. **Stop there.** What the place you found depends on is that place's own record.

## Record

The answer is the record and nothing else: one JSON object, with no text and no code fence around
it.

```json
{
  "claim": "README.md:5-6",
  "dependencies": [
    {
      "on": "config/retry.json:2-2",
      "kind": "value",
      "named_as": null,
      "restated": "up to five times"
    },
    {
      "on": null,
      "kind": "pointer",
      "named_as": "as discussed",
      "restated": null
    }
  ]
}
```

- `claim`: the claim's `at`, as the task gave it.
- `dependencies`: one entry per dependency.
  - `on`: where it is, as `path:first-last` in this repository, `owner/repo#number`, or a URL; or
    `null` when it cannot be found.
  - `kind`: what step 2 found it as: `word`, a word or an identifier the claim does not define;
    `value`, a value or a behaviour whose owner is elsewhere; `reason`, the reason the claim holds;
    `pointer`, a word that points by position, by role or at a conversation.
  - `named_as`: the claim's own words that name it, verbatim, or `null` when nothing in the claim
    names it.
  - `restated`: the claim's own words that restate part of it, verbatim, or `null` when it
    restates nothing.
