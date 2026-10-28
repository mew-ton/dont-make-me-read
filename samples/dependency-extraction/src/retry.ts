import config from "../config/retry.json";

let attemptsSeen = 0;

// Retries the given function until it succeeds or the limit is reached,
// waiting longer between each try.
export async function withRetry<T>(
  fn: () => Promise<T>,
  fromCheckout: boolean,
): Promise<T> {
  const limit = Number(process.env.RETRY_LIMIT ?? config.maxRetries);
  let delay = config.baseDelayMs;
  for (let attempt = 1; ; attempt++) {
    try {
      attemptsSeen++;
      return await fn();
    } catch (err) {
      if (attempt >= limit) {
        throw fromCheckout ? new Error("contact support") : err;
      }
      await new Promise((r) => setTimeout(r, delay));
      delay *= 2;
    }
  }
}

export function __resetForTests() {
  attemptsSeen = 0;
}
