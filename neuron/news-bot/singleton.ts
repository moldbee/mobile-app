import EventEmitter from "node:events";

export class MyEmitter extends EventEmitter {
  static #instance: MyEmitter;
  public random = 0;

  private constructor() {
    super();
  }

  public static get instance(): MyEmitter {
    if (!MyEmitter.#instance) {
      MyEmitter.#instance = new MyEmitter();
    }

    return MyEmitter.#instance;
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

  public set setrandom(num: number) {
    this.random = num;
  }

  public get randomG() {
    return this.random;
  }
}
