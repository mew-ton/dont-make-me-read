# 21 · "Each one" in the next step

**Pattern.** Two list items next to each other say "each one", and each means something else. The
second holds none of the words of what it means, so a search for them does not find it, and a
change that puts "each one" into the first gives the second a second meaning without touching it.

## Bad

**Bad** `docs/release.md`

```md
## Steps

1. **List the packages.** List every package under `packages/`.
2. **List what each one changed.** Compare the package's files with the last tag.
3. **Build each one.** Run `npm run build` in its directory.
```

### Graph

| Node | Address | Source or derived |
|---|---|---|
| what to list first | `docs/release.md › Steps` (*List the packages*) | derived |
| what to list next | `docs/release.md › Steps` (*List what each one changed*) | derived |
| what to build | `docs/release.md › Steps` (*Build each one*) | derived |

| From | To | Edge |
|---|---|---|
| *List what each one changed* | *List the packages* | **missing**: "each one" is a position, the item before it |
| *Build each one* | *List the packages* or *List what each one changed* | **missing**: "each one" is a position, and it can be read as either item |

### What is wrong

In *List what each one changed*, "each one" is a package. In *Build each one*, the same words are a
package again or a file that changed, and "its directory" follows whichever the reader picked. A
reader who lands on *Build each one* by search cannot tell which to build.

Neither item holds the words of the item it leans on. A writer who rewrites *List what each one
changed* and searches for its words does not find *Build each one*, so the item whose meaning the
rewrite changed is the one nobody checks.

## Good

**Good** `docs/release.md`

```md
## Steps

1. **List the packages.** List every package under `packages/`.
2. **List what each package changed.** Compare the package's files with the last tag.
3. **Build the packages that changed.** Run `npm run build` in the directory of each package in
   which *List what each package changed* finds a change.
```

### Why

Rule 3: a dependency is named by address. A list item stands alone as a paragraph does, as
*Paragraph* in `dont-make-me-read--glossary` says, and the heading of the item it leans on is the
address. *Address* in `dont-make-me-read--glossary` says an address leads to exactly one claim, and
"each one" here leads to two. The instances of *Dependency* in `dont-make-me-read--glossary` list
this way of naming: "a word whose referent is in another paragraph, such as "it" or "each one" in a
list item that means the item before it".
