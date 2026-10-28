import { withRetry } from "./retry";
import { charge } from "./payment";

export async function pay(orderId: string, amount: number): Promise<string> {
  try {
    await withRetry(() => charge(orderId, amount), true);
    return "paid";
  } catch (err) {
    return err instanceof Error ? err.message : "try again";
  }
}
