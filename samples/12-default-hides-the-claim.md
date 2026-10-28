# 12 · A default that hides the claim

**Pattern.** Shared defaults for a test file are a named node, so the edge to them is visible.
The claim of one test is about a difference, and the body shows none: the input the claim is about
and the output it produces both sit inside the defaults. The reader has to open the defaults to
learn what the test proves, and a change to the defaults silently changes it.

## Bad

**Bad** `src/img.test.tsx`

```tsx
const defaultProps = { src: "a.png", width: 320, densities: [2, 3, 4] };
const defaultExpects = { src: "a.png", widths: [640, 960, 1280] };

it("setting `densities` sets `widths` to the width times each density", () => {
  expect(renderElement(defaultProps).imgElement().args).toMatchObject(defaultExpects);
});
```

### Graph

| Node | Address | Source or derived |
|---|---|---|
| the claim | `src/img.test.tsx › "setting \`densities\` sets \`widths\`…"` | derived: explains the component |
| the defaults | `src/img.test.tsx › defaultProps`, `› defaultExpects` | named: shared by every test in the file |

| From | To | Edge |
|---|---|---|
| the test body | `defaultProps`, `defaultExpects` | visible by name, and carrying the whole claim: `width`, `densities` and `widths` appear only inside them |

### What is wrong

The name says the test is about `densities` and `widths`. The body mentions neither. A reader who
lands on the test by its name sees a render of some defaults matched against some defaults, and
has to open both to find the three fields the claim is about, among the fields it is not. When
someone edits `defaultProps` for another test's sake, this test's claim changes and nothing in it
shows that it did.

A `beforeEach` block is the cruder form of the same thing: setup the body leans on by position,
with no name at all.

## Good

**Good** `src/img.test.tsx`

```tsx
const defaultProps = { src: "a.png" };
const defaultExpects = { src: "a.png" };

it("setting `densities` sets `widths` to the width times each density", () => {
  expect(
    renderElement({ ...defaultProps, width: 320, densities: [2, 3, 4] }).imgElement().args,
  ).toMatchObject({ ...defaultExpects, widths: [640, 960, 1280] });
});
```

### Why

Rule 1: the body reproduces the claim, so the part of the input the claim is about, and the part
of the output it predicts, appear in the body. Rule 3: the defaults stay named and now carry only
what the claim is not about. Every test in the file reads as a difference from the same base, and
the base can change without changing what any of them proves.
