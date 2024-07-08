import fastify from "fastify";
import EventEmitter from "node:events";

type Status = "stopped" | "running";

export class NewsBot extends EventEmitter {
  static #instance: NewsBot;
  public botProcess: Status = "stopped";

  private constructor() {
    super();
  }

  public static get instance(): NewsBot {
    if (!NewsBot.#instance) {
      NewsBot.#instance = new NewsBot();
    }

    return NewsBot.#instance;
  }

  on(eventName: string | symbol, listener: (...args: any[]) => void) {
    const currentEvents = this.eventNames();

    if (!(currentEvents.length && currentEvents.includes(eventName))) {
      super.on(eventName, listener);
    } else {
      console.warn("Event already defined");
    }

    return this;
  }

  async start() {
    this.botProcess = "running";
  }

  async stop() {
    this.botProcess = "stopped";
  }

  async status() {
    return this.botProcess;
  }
}

const server = fastify();

server.get("/status", async (request, reply) => {
  try {
    return await NewsBot.instance.status();
  } catch (e) {
    console.log(e);
    return "error";
  }
});

server.get("/start", async (request, reply) => {
  try {
    await NewsBot.instance.start();
    return await NewsBot.instance.status();
  } catch (e) {
    console.log(e);
    return "error";
  }
});

server.get("/stop", async (request, reply) => {
  try {
    await NewsBot.instance.stop();
    return await NewsBot.instance.status();
  } catch (e) {
    console.log(e);
    return "error";
  }
});

server.listen({ port: 4321 }, (err, address) => {
  if (err) {
    console.error(err);
    process.exit(1);
  }
  console.log(`Server listening at ${address}`);
});
