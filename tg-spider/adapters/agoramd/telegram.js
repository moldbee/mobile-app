import { managePosts } from "../../helpers";

export const scrapeAgoraNews = async ({ client }) => {
  const chat = await client.getInputEntity(CHANNELS.agora.telegram.username);
  // const chat = await client.getInputEntity("moldbeemd");

  const messages = await client.getMessages(chat, {
    limit: initialScrapingDetails.channelNewsThreshold,
  });

  const posts = await managePosts(chat, client, messages || []);

  fs.writeFileSync("test.json", JSON.stringify(posts), "utf8");
};
