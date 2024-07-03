import { getClient } from "./client.js";
// import cron from "node-cron";
// import winston from "winston";
import { scrapeAgoraNews } from "./adapters/agoramd/telegram.js";

const scrapePoint = async () => {
  const client = await getClient({
    // connectionRetries: 5,
  });

  if (!client.connected) {
    await client.connect();
  }

  scrapeAgoraNews({ client });
};

scrapePoint();

// // import { Telegraf, Telegram } from "telegraf";

// // const bot = new Telegraf(process.env.TELEGRAM_BOT_TOKEN);

// // const random = async () => {
// //   console.log(
// //     await new Telegram(process.env.TELEGRAM_BOT_TOKEN).getFileLink(
// //       "5471996504035156505"
// //     )
// //   );
// // };
// // random();
