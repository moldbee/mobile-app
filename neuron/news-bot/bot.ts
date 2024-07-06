// import { MyEmitter } from "./singleton.js";

// interface BotCommands {
//   [key: string]: Function;
// }

// export const botCommands: BotCommands = {
//   start: async () => {
//     console.log(MyEmitter.instance.randomG);
//   },
//   stop: () => {
//     console.log((MyEmitter.instance.setrandom = 2));
//   },
//   status: () => {
//     console.log("status");
//   },
// };
// Import the framework and instantiate it

import Fastify from "fastify";
const fastify = Fastify({
  logger: true,
});

// Declare a route
fastify.get("/", async function handler(request, reply) {
  return { hello: "world" };
});

// Run the server!
try {
  await fastify.listen({ port: 8080 });
} catch (err) {
  fastify.log.error(err);
  process.exit(1);
}
