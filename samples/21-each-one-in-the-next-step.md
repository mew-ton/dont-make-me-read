# 21 · "Each one" in the next step

**Pattern.** A list item names the item before it by position, with a word such as "each one". It
holds none of that item's words, so a search for them does not find it, and a change to the item
before it leaves it meaning something else.

## Bad

**Bad** `docs/release.md`

```md
## Steps

1. **List what changed in each package.** Compare the package's files with the last tag.
2. **Build each one.** Run `npm run build` in its directory.
```

### Graph

| Node | Address | Source or derived |
|---|---|---|
| what to list | `docs/release.md › Steps` (*List what changed in each package*) | derived |
| what to build | `docs/release.md › Steps` (*Build each one*) | derived |

| From | To | Edge |
|---|---|---|
| *Build each one* | *List what changed in each package* | **missing**: "each one" is a position, the item before it |

### What is wrong

"Each one" means whatever the item before it lists. That item names two things, a package and the
files that changed in it, and a reader who lands on *Build each one* by search cannot tell which
one to build, or which directory "its" is. *Build each one* holds none of the words of the item it
leans on, so a writer who changes that item and searches for its words does not find it either.

## Good

**Good** `docs/release.md`

```md
## Steps

1. **List what changed in each package.** Compare the package's files with the last tag.
2. **Build the packages that changed.** Run `npm run build` in the directory of each package that
   *List what changed in each package* lists.
```

### Why

Rule 3: a dependency is named by address. A list item stands alone as a paragraph does, as
*Paragraph* in `dont-make-me-read--glossary` says, and the heading of the item it leans on is the
address. The instances of *Dependency* in `dont-make-me-read--glossary` list this way of naming: "a
word whose referent is in another paragraph, such as "it" or "each one" in a list item that means
the item before it".
