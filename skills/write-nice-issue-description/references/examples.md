# Worked examples

Read this when you are about to draft or revise an actual issue body. Each example demonstrates
one part of Gate 1 or Gate 2 from `SKILL.md`.

## Gate 1 — decision vs. choice

### Bad: the implementation method is written in

```markdown
## Affected areas

- `path/to/types.ts` (extend the discriminated union with a `previewOnly` variant,
  and update `createFooResolver.ts` to branch on it)
```

Whether to extend the union or branch on a separate boolean field still satisfies whatever the
acceptance criteria actually require — it is a choice, and the parenthetical is doing the
implementer's job for them.

### Good: the same area, without the implementation method

```markdown
## Affected areas

- `path/to/types.ts` (an existing discriminated-union example is `FooResolution` in
  `_internals/foo/fooResolution.ts`)
```

The parenthetical names what already exists at that location — a lead — and leaves how to model
the new state to whoever implements it against the current shape of the file.

## Gate 1 — a fixed shape is a constraint, not a choice

### Bad: a settled interface is omitted as though it were still a choice

```markdown
## Affected areas

- `path/to/FooViewModel.ts` (the foo card's response shape)
```

The rendering component in another repo was already built against a specific `FooViewModel`
shape — a prior design step fixed it, and a consumer already depends on it. Leaving it out of
Acceptance criteria and filing it as a mere lead treats a settled fact as though it were still open
for whoever implements this.

### Good: the shape stated as a criterion, in its own block

```markdown
## Acceptance criteria

- [ ] The response conforms to the `FooViewModel` shape below.

  ```ts
  type FooViewModel =
    | { status: "open"; title: string; company: string }
    | { status: "closed" | "not_found" | "fetch_error" };
  ```
```

The shape is not the implementation method — it is what the implementation must produce, and a
consumer outside this issue already depends on it. Stating it as a criterion with its own block
keeps it out of a single checkbox line without reaching for a `Design / Approach` section.

## Gate 1 — constraint, with its reason in the right place

### Bad: the reason sits next to the constraint

```markdown
## Acceptance criteria

- [ ] The 410 path reuses the existing `GoneError` (introducing a second error type for the same
      HTTP status would leave two shapes for API consumers to handle, and the OpenAPI schema
      already documents `GoneError`'s shape for this status)
```

The parenthetical turns the checkbox back into a paragraph, and the paragraph is the seed of a
Design / Approach section: once one reason is inline, the next constraint's reason gets one too.

### Good: the constraint stands alone; its reason is a problem in Background

```markdown
## Background / Why

Two exhausted-listing paths already return `GoneError` (`GET /v1/foo/{id}`,
`GET /v1/bar/{id}`), each with the same OpenAPI shape. A third ad-hoc 410 shape would leave
API consumers handling three different bodies for the same status.

## Acceptance criteria

- [ ] The 410 path reuses the existing `GoneError`.
```

The checkbox states what must hold; the paragraph that justifies it lives where a reader expects a
justification — next to the rest of the problem, not folded into a checklist item.

## Gate 1 — references

### Bad: a reference that only makes sense once resolved

```markdown
Refs #1784

## Background / Why

#1784 makes the article body's foo link return a 4-state view model.
```

A reader who cannot open #1784 cannot finish this sentence — the fact itself is deferred to
another document, not stated here.

### Good: the same dependency, stated so the reader can stop without opening it

```markdown
depends on #1784

## Background / Why

A foo card shown in an article can be in one of these states: closed, the foo no longer exists, or
fetch failed.
```

"Depends on #1784" tells the reader everything they need to decide whether to keep reading this
issue right now, without requiring them to open it. The fact the issue is actually about is stated
here, once, on its own.

## Background — subject is a path when the entity is a document or code

### Bad: a prose description stands in for the entity

```markdown
## Background / Why

The backend's layer boundary rule document says circular dependencies between layers are
disallowed.
```

The reader has to go find "the backend's layer boundary rule document" before the sentence means
anything — the description is an extra resolution step the writer already did and threw away.

### Good: the path is the subject

```markdown
## Background / Why

The rules under `.claude/rules/backend/` say circular dependencies between layers are disallowed.
```

The path already tells the reader where this fact lives; there is nothing left to resolve.

## Background — chaptering multiple problems

### Bad: two problems left flat

```markdown
## Background / Why

- `architecture.md` says each layer's code is nested one level per service, with no top-level
  directory per layer.
- `domain-layer.md`, `application-layer.md`, and five other layer docs show directory trees and
  paths rooted flatly, not per service.
- `proposal-multi-service-structure.md` presents the cross-service import restriction as an
  unimplemented future proposal.
- `backend/CLAUDE.md` already states that restriction as current policy.
```

The reader has to reconstruct which bullets pair up: the first two are one problem (which storage
layout is real), the last two another (a proposal doc nobody updated after the policy shipped) —
nothing marks where one problem ends and the next begins.

### Good: one reason, then one heading per problem

```markdown
## Background / Why

The rules under `.claude/rules/backend/` carry two inconsistencies whose fixes are entangled: which
doc to trust decides which one gets rewritten to match the other.

### Storage layout contradiction

- `architecture.md` says each layer's code is nested one level per service, with no top-level
  directory per layer.
- `domain-layer.md`, `application-layer.md`, and five other layer docs show directory trees and
  paths rooted flatly, not per service.
- Both sets load together when editing under `backend/`, so the reader cannot tell which layout to
  follow.

### Proposal doc gone stale

- `proposal-multi-service-structure.md` presents the cross-service import restriction as an
  unimplemented future proposal.
- `backend/CLAUDE.md` already states that restriction as current policy.
```

Whether a bullet reads as a problem on its own is not what decided the split — "both sets load
together" does not stand alone either, and it still stays inside the first chapter, because it is
one fact among several that make up that same problem. What decided the split is that the bullets
sorted into two distinct problems, not whether any single bullet was self-sufficient.

## Background — same-shape requirements: a table, not repeated prose

With only one requirement, a table buys nothing over the sentence that already states it:

```markdown
## Background / Why

`config/timeouts.yaml` sets the request timeout to 10s, but `docs/sla.md` requires 30s.
```

### Bad: the same sentence, repeated once per requirement

```markdown
## Background / Why

`config/timeouts.yaml` sets the request timeout to 10s, but `docs/sla.md` requires 30s. It also
sets the retry count to 1, but `docs/sla.md` requires 3. It also disables backoff, but `docs/sla.md`
requires exponential backoff.
```

Each sentence only changes the fill-in values of "sets ____ to ____, but requires ____" — this is
Gate 2's paragraph-compression duplication, spread across three sentences instead of caught inside
one.

### Good: one table

```markdown
## Background / Why

`config/timeouts.yaml` diverges from `docs/sla.md` on more than one setting.

| | Actual | Requirement |
|---|---|---|
| Request timeout | 10s | 30s |
| Retry count | 1 | 3 |
| Backoff | none | exponential |
```

The repeated template is gone; only what differs per requirement remains, as a row.

Chaptering still applies on top of this when more than one *kind* of problem is present — each
heading then gets its own table:

```markdown
## Background / Why

Both the request-timeout config and the retry config diverge from `docs/sla.md`.

### `config/timeouts.yaml`

| | Actual | Requirement |
|---|---|---|
| Request timeout | 10s | 30s |

### `config/retry.yaml`

| | Actual | Requirement |
|---|---|---|
| Retry count | 1 | 3 |
| Backoff | none | exponential |
```

Chaptering and tabulating answer different questions — how many kinds of problem this issue holds,
versus how many requirements one kind of problem holds — so nothing stops both from applying to the
same issue.

## Goal — covers every Acceptance criteria item

### Bad: an item Goal doesn't reach

```markdown
## Goal

404 / 410 semantics conform to RFC 9110.

## Acceptance criteria

- [ ] Returns 410 when the foo was published in the past and is now unpublished or closed.
- [ ] Returns 404 when no foo with that ID has ever existed.
- [ ] The foo list endpoint's response now includes a `lastCheckedAt` timestamp.
```

The third item has nothing to do with 404/410 semantics — it is a second, unrelated problem riding
along on the same issue, and Goal gives the reader no way to see that it belongs somewhere else.

### Good: split into the issue Goal actually covers

```markdown
## Goal

404 / 410 semantics conform to RFC 9110.

## Acceptance criteria

- [ ] Returns 410 when the foo was published in the past and is now unpublished or closed.
- [ ] Returns 404 when no foo with that ID has ever existed.
```

The `lastCheckedAt` addition becomes its own issue, with its own Goal.

## Acceptance criteria — an "all" claim needs a path-scoped subject

### Bad: "all" with no set behind it

```markdown
## Acceptance criteria

- [ ] All backend architecture docs state the same dependency direction.
```

Nobody can check this — "all backend architecture docs" could mean one folder or five, and the
sentence itself does not say which.

### Good: the subject's path is the set

```markdown
## Acceptance criteria

- [ ] All architecture docs under `.claude/rules/backend/` and `backend/docs/` state the same
      dependency direction.
```

The path range is the set to check; there is no separate definition to hunt for.

## Affected areas — a future-placement note is still an implementation method

### Bad: the parenthetical states where something will move to

```markdown
## Affected areas

- `.claude/skills/` (where layer-specific implementation patterns get split out to)
```

"Where it will move to" is a plan, not an observation — it commits the reader to relocating
something, which is exactly the kind of decision Affected areas is not supposed to carry.

### Good: the parenthetical states only what is already there

```markdown
## Affected areas

- `.claude/skills/` (existing layer-specific implementation-pattern docs live here)
```

## Gate 2 — duplication

### Bad: Out of scope restates the scope statement

```markdown
## Background / Why

`GET /v1/foo/{id}` returns the same 404 whether the foo was deleted, never published, or closed.

## Design / Approach

Add a `status` discriminant to the response and have the backend resolve it.

## Out of scope

- Updating the rendering component to show per-status copy (tracked separately).
- Adding a `status` filter to the foo list endpoint.
```

The first Out-of-scope bullet is the same fact as "this task covers the backend; the rendering
component is a follow-up" — said in a different section, in list form instead of prose. The
second is a feature nobody asked for a decision on; if it truly needs recording, it is a follow-up
task, not a boundary this issue is drawing.

### Good: the scope statement carries it, and Design / Approach does not exist

```markdown
## Background / Why

`GET /v1/foo/{id}` returns the same 404 whether the foo was deleted, never published, or closed,
and does not distinguish why.

This task covers the backend response shape. Reflecting the new states in the rendering component
is #1851's.

## Acceptance criteria

- [ ] `GET /v1/foo/{id}` returns a `status` field distinguishing deleted / unpublished / closed.
```

One statement of scope, in the one place a scope statement belongs. Nothing survives to duplicate
it, because there is no Design / Approach or Out of scope section to restate it in.

## A full passing issue

```markdown
Refs #1558

## Background / Why

`GET /v1/foo/{id}` returns the same 404 whether the foo was deleted, never published, or closed,
and does not distinguish why. A foo card shown in an article can currently only render "not
found," which reads as permanently gone even when the foo is a temporary fetch error away from
reappearing.

## Goal

404 / 410 semantics conform to RFC 9110.

## Acceptance criteria

- [ ] Returns 410 when the foo was published in the past and is now unpublished or closed.
- [ ] Returns 404 when no foo with that ID has ever existed.
- [ ] An existing endpoint's error response shape does not change for any other status.
- [ ] `<this repository's lint / type-check / test commands>` pass (`path/to/foo`).

## Affected areas

- `path/to/getFoo.ts`
- `path/to/error-handler.ts` (an existing `GoneError` → 410 mapping for
  `GET /v1/bar/{id}`)

depends on #1784
```

No Design / Approach, no Out of scope, no Verification — every sentence still true after the issue
closes, every checkbox in domain vocabulary, and the one boundary (the endpoint's other statuses
are unaffected) stated once, as a criterion rather than a caveat bolted onto Background.

The last checkbox is the one placeholder left standing in this example: in a real issue it names
the commands that repository actually runs. Every other value here (`path/to/getFoo.ts`, `#1784`,
`GET /v1/foo/{id}`) is a stand-in for the specifics of whatever issue you are writing, but the
verification commands are a stand-in for something you must go and read out of the repository, not
invent.
