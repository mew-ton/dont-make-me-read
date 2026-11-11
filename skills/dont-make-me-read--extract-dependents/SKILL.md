---
name: dont-make-me-read--extract-dependents
description: >
  Finds the claims in a repository that depend on each claim under one address, as
  dont-make-me-read--glossary defines a dependency, and returns one JSON record per claim.
user-invocable: false
disable-model-invocation: false
---

## What it does

Finds, in the repository, the claims that depend on each claim the task names, and returns one
record for each. The task names the claims under one address of one file, or the claims of one
file that have no address, or the claims a change removed from under one address. The words are as `dont-make-me-read--glossary` defines them: read its *Claim*,
*Address*, *Dependency* and *Location* before searching.

## Steps

1. **Read the claims and their address.** The task names each claim by its location, or, for a
   claim a change removed, by the words it had. Read the rest of its file only to find the address.
2. **Search for each claim's address and its words.** A dependent shows itself by the claim's address or by
   the claim's words, whether or not it names the claim: an identifier the claim declares, its
   heading, its file's path, a value it holds, a phrase of its body. Search the repository for each,
   and for the words its readers would use instead, `attempts`, `tries`, `tried` for `maxAttempts`:
   a dependent that restates the claim in other words is found by its subject, not by its value.
3. **Keep what depends.** A hit depends on the claim when a change to the claim would mean checking
   the hit again, as *Dependency* says. A hit that uses a word as everyone uses it does not.
4. **Stop there.** What a dependent depends on beyond this claim, and what depends on the
   dependent, are its own records.

## Record

The answer is the records and nothing else: one JSON array, with one object for each claim the
task names, in the task's order, and no text and no code fence around it.

```json
[
{
  "claim": "config/retry.json:2-2",
  "dependents": [
    {
      "at": "README.md:5-6",
      "named_as": null,
      "restated": "up to five times",
      "found_by": "tried"
    }
  ]
}
]
```

- `claim`: the claim's location, as the task gave it, or its words when the task gave those.
- `dependents`: one entry per claim found, in the order found. Each is one edge from the
  dependent to the claim.
  - `at`: the dependent's location.
  - `named_as`: the dependent's own words that name the claim, verbatim, or `null` when nothing in
    it names the claim.
  - `restated`: the dependent's own words that restate part of the claim, verbatim, or `null` when
    it restates nothing.
  - `found_by`: the search term that found it.
