# 03 · "As discussed in standup"

**Pattern.** An explanation depends on something no reader can reach: a conversation.

## Bad

**Bad** `https://github.com/example/orderly/issues/231`

```md
# Checkout hangs when the payment provider is slow

As discussed in standup, QA found that paying with a declining card locks the page for several
seconds and then shows the wrong message.
```

### Graph

| Node | Address | Source or derived |
|---|---|---|
| the task | `https://github.com/example/orderly/issues/231` | derived from an observation |
| the standup | none | not a node: it has no address and no text |

| From | To | Edge |
|---|---|---|
| `https://github.com/example/orderly/issues/231` | the standup | **dangling**: the target cannot be reached by anyone who was not there |

### What is wrong

Whatever was settled in standup is what the issue leans on, and it is not written anywhere. The
reader either reconstructs it, wrongly, or asks, which is the round trip the issue was meant to
save.

## Good

**Good** `https://github.com/example/orderly/issues/231`

```md
# Checkout hangs when the payment provider is slow

QA report 142 (`docs/qa-report-142.md`): "The screen freezes for about ten seconds after pressing
Pay, then shows 'contact support'." We decided (here, 2026-10-27) to treat this as a defect in the
retry layer rather than in the provider.
```

### Why

Rule 3: never "as discussed". Rule 4: state the part the reader needs, and name the owner. If the
standup produced a decision, the decision now needs an address; the issue is where it gets one.
