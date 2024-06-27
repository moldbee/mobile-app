import { getClient } from './client.js';
import { CHANNELS } from './constants.js';
import { Api } from 'telegram';

const scrapeTelegram = async () => {
  const client = await getClient({
    // connectionRetries: 5,
  });

  if (!client.connected) {
    await client.connect();
  }

  const chat = await client.getInputEntity('zdgmd');

  // for await (const message of client.iterMessages(chat, { limit: 10 })) {
  //   console.log("Message text is", message.text, message);
  // }

  for await (const message of client.iterMessages(chat, {
    limit: 1,
  })) {
    console.log(message.id, message.entities);
  }
};

scrapeTelegram();
