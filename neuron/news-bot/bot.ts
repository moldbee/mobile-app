import EventEmitter from "node:events";

export class NewsBot extends EventEmitter {
  static #instance: NewsBot;
  public variable: number = 0;

  private constructor() {
    super();
    this.on("start", () => this.start());
    this.on("stop", () => this.stop());
    this.on("status", () => this.status());
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

  start() {
    this.emit("custom", this.variable);
    this.variable = 10;
  }
  stop() {
    console.log("start");
  }
  status() {
    console.log("start");
  }
}
