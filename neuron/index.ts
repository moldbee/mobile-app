import fastify from "fastify";

const server = fastify();

server.get("/ping", async (request, reply) => {
  try {
    return "test good";
  } catch (e) {
    console.log(e);
    return "error";
  }
});

server.listen({ port: 8080 }, (err, address) => {
  if (err) {
    console.error(err);
    process.exit(1);
  }
  console.log(`Server listening at ${address}`);
});
