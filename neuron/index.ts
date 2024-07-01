import fastify from 'fastify';
import { infogari } from './modules/transport/adapters/infogari';

const server = fastify();

server.get('/ping', async (request, reply) => {
  await infogari.search('chisinau', 'iasi');
  return 'hog\n';
});

server.listen({ port: 8080 }, (err, address) => {
  if (err) {
    console.error(err);
    process.exit(1);
  }
  console.log(`Server listening at ${address}`);
});
