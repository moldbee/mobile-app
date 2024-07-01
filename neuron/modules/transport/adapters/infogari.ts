import axios from 'axios';
import { launchPuppeteer } from 'crawlee';

class InfogariAdapter {
  async getIdOptionOfCity(name: string, which: 'arrival' | 'departure') {
    type Option = { id: string };
    const response = await axios.post<Option[]>(
      'https://infogari.md/book/en/api/searchlocation',
      {
        q: name,
        which: which,
      },
      {
        headers: {
          'User-Agent':
            'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:127.0) Gecko/20100101 Firefox/127.0',
          Accept: '*/*',
          'Accept-Language': 'en-US,en;q=0.5',
          'Accept-Encoding': 'gzip, deflate, br, zstd',
          'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
          'X-Requested-With': 'XMLHttpRequest',
          Origin: 'https://infogari.md',
          Connection: 'keep-alive',
          Referer: 'https://infogari.md/',
        },
      }
    );

    console.log(response);

    return response.data[0].id;
  }

  async search(from: string, to: string) {
    const url = `https://infogari.md`;

    const browser = await launchPuppeteer({
      launchOptions: {
        headless: false,
      },
    });

    const page = await browser.newPage();

    const [fromId, toId] = await Promise.all([
      await this.getIdOptionOfCity(from, 'departure'),
      await this.getIdOptionOfCity(to, 'arrival'),
    ]);
    await page.goto(
      `https://infogari.md/book/en/site/search?from=${fromId}&to=${toId}&date=03-07-2024&passengers=1`
    );
  }
}

export const infogari = new InfogariAdapter();
