import { GTR } from 'https://deno.land/x/gtr/mod.ts';
import * as base64 from 'https://deno.land/std@0.208.0/encoding/base64.ts';

Deno.serve(async (req) => {
  const { text, lang } = await req.json();
  const gtr = new GTR();
  // const projectId = 'smartcity-407217';
  // const location = 'global';

  const { trans } = await gtr.translate(text, { targetLang: lang ?? 'ro' });
  return new Response(JSON.stringify(base64.encode(trans)), {
    headers: { 'Content-Type': 'application/json' },
  });
});
