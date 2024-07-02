import fastify from 'fastify';
import { InfogariAdapter } from 'modules/transport/adapters/infogari.js';

const server = fastify();

server.get('/ping', async (request, reply) => {
  const infogari = new InfogariAdapter('ru');
  const data = await infogari.search('chisinau', 'berlin');
  console.log('🚀 ~ server.get ~ data:', data);
  return JSON.stringify(data);
});

server.listen({ port: 8080 }, (err, address) => {
  if (err) {
    console.error(err);
    process.exit(1);
  }
  console.log(`Server listening at ${address}`);
});
