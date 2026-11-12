# 21 · "Each one" in the next step

**Pattern.** A list item names the item before it by position, with "each one". A change puts
"each one" into the item before it, meaning something else there, and leaves the next item as it
was. The next item now has two readings, and the change does not touch it.

## Bad

**Bad** the change to `docs/release.md`

```diff
 ## Steps

 1. **List the packages.** List every package under `packages/`.
-2. **List what it changed.** For a package, compare its files with the last tag.
+2. **List what each one changed.** Compare the package's files with the last tag.
 3. **Check each one.** Run `eslint` on it.
```

### Graph

As the change leaves the file:

| Node | Address | Source or derived |
|---|---|---|
| what to list first | `docs/release.md › Steps` (*List the packages*) | derived |
| what to list next | `docs/release.md › Steps` (*List what each one changed*) | derived |
| what to check | `docs/release.md › Steps` (*Check each one*) | derived |

| From | To | Edge |
|---|---|---|
| *List what each one changed* | *List the packages* | **missing**: "each one" is a position, the item before it |
| *Check each one* | *List what each one changed* | **missing**: "each one" is a position, and it now reads as a package or as a file that changed |

### What is wrong

Before the change, "each one" in *Check each one* had one reading: a file that *List what it
changed* lists. The change makes "each one" in the item before it mean a package, and a reader who
lands on *Check each one* can no longer tell whether to run `eslint` on a package or on a file.

The hunk touches only *List what each one changed*. *Check each one* holds none of its words, so a
search for them does not find it, and a review that keeps only the claims a hunk touches does not
read it. Only reading the file for what points at the changed item by position finds it, as the
step *Read the claim's file for what points at it* under `dont-make-me-read--extract-dependents ›
Steps` says.

## Good

**Good** the change to `docs/release.md`

```diff
 ## Steps

 1. **List the packages.** List every package under `packages/`.
-2. **List what it changed.** For a package, compare its files with the last tag.
-3. **Check each one.** Run `eslint` on it.
+2. **List what each package changed.** Compare the package's files with the last tag.
+3. **Lint the changed files.** Run `eslint` on each file *List what each package changed* lists.
```

### Why

Rule 3: a dependency is named by address. A list item stands alone as a paragraph does, as
*Paragraph* in `dont-make-me-read--glossary` says, and the heading of the item it leans on is the
address. *Address* in `dont-make-me-read--glossary` says an address leads to exactly one claim, and
"each one" led to one only until the item before it said "each one" too. The instances of
*Dependency* in `dont-make-me-read--glossary` list this way of naming: "a word whose referent is in
another paragraph, such as "it" or "each one" in a list item that means the item before it".

With the dependency named, the change to *List what each package changed* carries *Lint the
changed files* with it: a search for its heading finds the item that names it.
