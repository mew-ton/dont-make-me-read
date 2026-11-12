# 21 · "Each one" in the next step

**Pattern.** A list item names the item before it by position, with "each one". A change inserts
a new item between the two, so "each one" now has the new item before it, and the change touches
the old item only to renumber it.

## Bad

**Bad** the change to `docs/release.md`

```diff
 ## Steps

 1. **List the packages that changed.** Compare each package's files with the last tag.
-2. **Check each one.** Run `eslint` on it.
+2. **List the files each one changed.** Compare its files with the last tag, one by one.
+3. **Check each one.** Run `eslint` on it.
```

### Graph

As the change leaves the file:

| Node | Address | Source or derived |
|---|---|---|
| what to list first | `docs/release.md › Steps` (*List the packages that changed*) | derived |
| what to list next | `docs/release.md › Steps` (*List the files each one changed*) | derived |
| what to check | `docs/release.md › Steps` (*Check each one*) | derived |

| From | To | Edge |
|---|---|---|
| *List the files each one changed* | *List the packages that changed* | **missing**: "each one" is a position, the item before it |
| *Check each one* | *List the packages that changed* or *List the files each one changed* | **missing**: "each one" is a position, and it now reads as a package or as a file |

### What is wrong

Before the change, "each one" in *Check each one* was a package, the only item before it. The
inserted item is now the item before it and lists files, so a reader who lands on *Check each one*
can no longer tell whether to run `eslint` on a package or on a file.

The change touches *Check each one* only to renumber it, and a writer who renumbers an item does
not read it again. It holds none of the words of either item before it, so a search for them does
not find it. Only reading the file for what points at the inserted item's position finds it, as the
step *Read the claim's file for what points at it* under `dont-make-me-read--extract-dependents ›
Steps` says.

## Good

**Good** the change to `docs/release.md`

```diff
 ## Steps

 1. **List the packages that changed.** Compare each package's files with the last tag.
-2. **Check each one.** Run `eslint` on it.
+2. **List the files each package changed.** For each package *List the packages that changed*
+   lists, compare its files with the last tag, one by one.
+3. **Lint the packages.** Run `eslint` on each package *List the packages that changed* lists.
```

### Why

Rule 3: a dependency is named by address. A list item stands alone as a paragraph does, as
*Paragraph* in `dont-make-me-read--glossary` says, and the heading of the item it leans on is the
address. *Address* in `dont-make-me-read--glossary` says an address leads to exactly one claim, and
"each one" in *Check each one* led to one only while nothing stood between it and *List the packages
that changed*. The instances of *Dependency* in `dont-make-me-read--glossary` list this way of
naming: "a word whose referent is in another paragraph, such as "it" or "each one" in a list item
that means the item before it".

With the dependency named, an item inserted between *List the packages that changed* and *Lint the
packages* leaves *Lint the packages* meaning what it meant, and a search for the heading it names
finds it.
