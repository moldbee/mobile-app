import fs from "fs";
import { CHANNELS, initialScrapingDetails } from "src/tg-spider/constants.js";
import { managePosts } from "src/tg-spider/helpers.js";
import { TelegramClient } from "telegram";

interface ScrapeAgoraNewsProps {
  client: TelegramClient;
}

export const scrapeAgoraNews = async ({ client }: ScrapeAgoraNewsProps) => {
  const chat = await client.getInputEntity(CHANNELS.agora.telegram.username);
  // const chat = await client.getInputEntity("moldbeemd");

  const messages = await client.getMessages(chat, {
    limit: initialScrapingDetails.channelNewsThreshold,
  });

  const posts = await managePosts(chat, client, messages);

  fs.writeFileSync("test.json", JSON.stringify(posts), "utf8");
};
