import EventEmitter from "node:events";
export class MyEmitter extends EventEmitter {
    static #instance;
    random = 0;
    constructor() {
        super();
    }
    static get instance() {
        if (!MyEmitter.#instance) {
            MyEmitter.#instance = new MyEmitter();
        }
        return MyEmitter.#instance;
    }
    on(eventName, listener) {
        const currentEvents = this.eventNames();
        if (!(currentEvents.length && currentEvents.includes(eventName))) {
            super.on(eventName, listener);
        }
        else {
            console.warn("Event already defined");
        }
        return this;
    }
    set setrandom(num) {
        this.random = num;
    }
    get randomG() {
        return this.random;
    }
}
