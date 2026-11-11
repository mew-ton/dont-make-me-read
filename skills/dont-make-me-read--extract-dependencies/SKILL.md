---
name: dont-make-me-read--extract-dependencies
description: >
  Lists what each claim under one address depends on, as dont-make-me-read--glossary defines a
  dependency, and returns one JSON record per claim.
user-invocable: false
disable-model-invocation: false
---

## What it does

Lists what each claim the task names depends on, and returns one record for each. The task names
the claims under one address of one file, or the claims of one file that have no address. The
words are as
`dont-make-me-read--glossary` defines them: read its *Claim*, *Address*, *Dependency* and
*Location* before listing.

## Steps

1. **Read the claims and their address.** The task names each claim by its location. Read the
   rest of its file only to find the address and what each claim depends on, the way a reader who
   landed on the address by search would have to.
2. **List what each one depends on.** Ask what change elsewhere would mean checking this claim again.
   Look for a word or an identifier it uses and does not define, a value or a behaviour whose
   owner is elsewhere, the reason it holds, and, for an address, what it summarises. A word that
   points at one of these instead of naming it, as the instances of *Dependency* list, is a sign
   of one.
3. **Find where each one is.** Search the repository, and open what the claim names in it. Keep what
   the claim says to name it apart from where you found it: the first goes in `named_as`, the second
   in `on`.
4. **Stop there.** What the place you found depends on is that place's own record.

## Record

The answer is the records and nothing else: one JSON array, with one object for each claim the
task names, in the task's order, and no text and no code fence around it.

```json
[
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
      "kind": "reason",
      "named_as": "as discussed",
      "restated": null
    }
  ]
}
]
```

- `claim`: the claim's location, as the task gave it.
- `dependencies`: one entry per dependency.
  - `on`: its location, or `null` when it cannot be found.
  - `kind`: `word`, `value`, `reason` or `summary`, the four things *List what it depends on*
    looks for, in its order.
  - `named_as`: the claim's own words that name it, verbatim, or `null` when nothing in the claim
    names it.
  - `restated`: the claim's own words that restate part of it, verbatim, or `null` when it
    restates nothing.
