import { TelegramClient } from "telegram";
import readline from "readline";
import { StringSession } from "telegram/sessions/index.js";

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout,
});

export const getClient = async (clientParams = {}) => {
  const client = new TelegramClient(
    new StringSession(process.env.TELEGRAM_SESSION_STRING),
    Number(process.env.TELEGRAM_API_ID),
    process.env.TELEGRAM_API_HASH,
    clientParams
  );

  const isUserAuthorized = await client.isUserAuthorized();

  if (!isUserAuthorized) {
    await client.start({
      phoneNumber: () => process.env.TELEGRAM_PHONE_NUMBER,
      password: () => process.env.TELEGRAM_ACCOUNT_PASSWORD,
      phoneCode: async () =>
        new Promise((resolve) => rl.question("Enter received code: ", resolve)),
      onError: (err) => console.log(err),
    });
  }

  return client;
};
