---
name: dont-make-me-read--extract-claims
description: >
  Cuts one file into claims, as dont-make-me-read--glossary defines a claim, and returns them as
  one JSON record.
user-invocable: false
disable-model-invocation: false
---

## What it does

Cuts the file the task names into claims, and returns them as one record. The words are as
`dont-make-me-read--glossary` defines them: read its *Paragraph*, *Claim*, *Address* and
*Location* before cutting.

## Steps

1. **Read the whole file.**
2. **Cut it into claims,** as *Claim* says what one is, even where one shares a paragraph with
   another.
3. **Give each claim its address,** as *Address* says what it is. Several claims can share one.
4. **Account for every other line,** as *Record* says.

## Record

The answer is the record and nothing else: one JSON object, with no text and no code fence around
it.

```json
{
  "file": "README.md",
  "claims": [
    {
      "at": "README.md:5-6",
      "paragraph": "README.md:5-6",
      "address": { "at": "README.md:3-3", "text": "## Retries" },
      "quote": "A payment call is tried up to five times before the order is marked failed."
    }
  ],
  "uncovered": [
    { "at": "README.md:1-1", "why": "the file's title, which no claim sits under" }
  ]
}
```

- `file`: the file's path, as the task gave it.
- `claims`: one entry per claim, in the file's order.
  - `at`: the claim's location, its address left out.
  - `paragraph`: the location of the paragraph the claim is written in, which claims written in
    one paragraph share.
  - `address`: the address's `at` and its `text` verbatim, or `null` when the claim has none.
  - `quote`: the claim's first sentence in prose, or its first line in a program, verbatim.
- `uncovered`: each range of non-blank lines in no claim and no address, with its `at` and `why`.

Every non-blank line of the file is in a claim, an address or an `uncovered` range, and in no more
than one address or `uncovered` range.
