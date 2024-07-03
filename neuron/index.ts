import fastify from 'fastify';
import { InfogariAdapter } from 'modules/transport/adapters/infogari.js';

const server = fastify();

server.get('/ping', async (request, reply) => {
  const infogari = new InfogariAdapter('ro');
  try {
    const data = await infogari.search('chisinau', 'iasi');
    return data;
  } catch (e) {
    console.log(e);
    return 'error';
  }
});

server.listen({ port: 8080 }, (err, address) => {
  if (err) {
    console.error(err);
    process.exit(1);
  }
  console.log(`Server listening at ${address}`);
});
