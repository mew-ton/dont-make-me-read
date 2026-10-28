import { withRetry, __resetForTests } from "./retry";

let calls: number;
let failing: () => Promise<never>;

beforeEach(() => {
  __resetForTests();
  calls = 0;
  failing = async () => {
    calls++;
    throw new Error("declined");
  };
});

it("works correctly", async () => {
  await expect(withRetry(failing, false)).rejects.toThrow();
  expect(calls).toBe(3);
});

it("stops after the configured number of attempts", async () => {
  await expect(withRetry(failing, false)).rejects.toThrow("declined");
  expect(calls).toBe(3);
});

it("gives up after three tries", async () => {
  await expect(withRetry(failing, false)).rejects.toThrow();
  expect(calls).toBe(3);
});
