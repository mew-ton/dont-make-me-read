# Claim

Instances of a claim, each with how many it is and why.

- "Checkout times out after 30 seconds when the provider is slow. It is 30 because the provider's
  SLA is 25. Please raise it to 60.": three claims, an observation, a reason and a request.
- A commit message "Fix the checkout timeout and rename `fmt` to `formatPrice`": two claims. Each
  can be reverted alone.
- A function that rejects an empty order and then saves it: two claims. The rule can change while
  saving stays.
- A test named "adds an item" that also checks the total: two claims, and the name summarises one.
- "A payment call is tried at most `maxAttempts` times, and then the order is marked failed": two
  claims. What happens when the tries run out can change while the limit stays.
- `const MAX_ATTEMPTS = 3`: one claim. No part of it can change alone.
