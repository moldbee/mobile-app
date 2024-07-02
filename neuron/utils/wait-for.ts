export async function waitFor<Value>(
  condition: boolean,
  value: Value,
  timeout?: number
) {
  const waitPromise = new Promise((resolve, reject) => {
    if (condition) resolve(value);

    if (timeout) setTimeout(() => reject(`Timeout ${timeout} exceed`), timeout);
  });

  return await waitPromise;
}
