# 01 · A copy that went stale

**Pattern.** A number has an owner, and a document restates it instead of citing it. The owner
changed; the document did not.

## Bad

**Bad** `config/retry.json`

```json
{ "maxAttempts": 3, "baseDelayMs": 200 }
```

**Bad** `README.md`

```md
## Retries

A payment call is tried up to five times before the order is marked failed. The wait between
tries doubles each time.
```

### Graph

| Node | Address | Source or derived |
|---|---|---|
| the retry limit | `config/retry.json › maxAttempts` | source |
| the README's account of retries | `README.md › Retries` | derived: it explains the service |

| From | To | Edge |
|---|---|---|
| `README.md › Retries` | `config/retry.json › maxAttempts` | **missing**: the value is restated, the owner is not named |

### What is wrong

Two paragraphs make the same claim and only one of them is checked by anything. A reader who finds
the README decides on five. Nothing tells them there is a second place, and nothing told the
writer who changed the config that there was a first.

## Good

**Good** `README.md`

```md
## Retries

A payment call is tried at most `maxAttempts` times (`config/retry.json`), and then the order is
marked failed.
```

### Why

Rule 4: a claim that has an owner is cited, not restated. Restate only what the reader needs, in
the owner's words, and name the owner. How the wait grows between tries is the body of `withRetry`
to say, so the README no longer says it either. The config is unchanged; it was never the problem.
