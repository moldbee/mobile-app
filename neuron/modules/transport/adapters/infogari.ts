import axios from 'axios';
import { launchPuppeteer, sleep } from 'crawlee';
import { makeObservable } from 'mobx';
import { FormattedRoute } from 'modules/transport/types.js';
import { waitFor } from 'utils/wait-for.js';

const selectors = {
  routeCard: '.results__block-course',
};

const browser = await launchPuppeteer({
  useChrome: true,
  launchOptions: {
    headless: false,
  },
});

export class InfogariAdapter {
  locale: 'ro' | 'ru';
  localeForUrl: string;
  baseUrl: string;

  constructor(locale: 'ro' | 'ru') {
    this.locale = locale;
    this.localeForUrl = this.locale === 'ru' ? 'ru' : '';
    this.baseUrl = 'https://infogari.md';
  }

  // search works only for latin citiy name
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

    return response.data[0].id;
  }

  async search(from: string, to: string) {
    const [fromId, toId, page] = await Promise.all([
      await this.getIdOptionOfCity(from, 'departure'),
      await this.getIdOptionOfCity(to, 'arrival'),
      await browser.newPage(),
    ]);

    const formattedRoutesOutput = makeObservable<FormattedRoute[]>([]);

    page.on('response', async (res) => {
      if (res.request().url().includes('/coursedetails')) {
        const routeFromApi: Course = await res.json();
        const formattedRoute = {
          from: {
            adress: routeFromApi.from.name,
          },
          to: {
            adress: routeFromApi.to.name,
          },
          transport: {
            image: this.baseUrl + routeFromApi.comfort.car.img,
            comforts: {
              wifi: routeFromApi.comfort.car.conviniences.some(
                (conv) => conv.shortName === 'WiFi'
              ),
              tv: routeFromApi.comfort.car.conviniences.some(
                (conv) => conv.shortName === 'TV'
              ),
              refrigerator: routeFromApi.comfort.car.conviniences.some(
                (conv) => conv.shortName === 'Frigider'
              ),
              food: routeFromApi.comfort.car.conviniences.some(
                (conv) => conv.shortName === 'Masa'
              ),
            },
          },
          company: routeFromApi.provider.name,
        };

        formattedRoutesOutput.push(formattedRoute);
      }
    });

    await page.goto(
      `https://infogari.md/book/${this.localeForUrl}/site/search?from=${fromId}&to=${toId}&date=03-07-2024&passengers=1`
    );

    await page.waitForSelector(selectors.routeCard);
    const routeCards = (await page.$$(selectors.routeCard)).reverse();

    for (const routeCard of routeCards) {
      await routeCard.scrollIntoView();
      await routeCard.click();
      await sleep(200);
    }

    return await waitFor(
      formattedRoutesOutput.length === routeCards.length,
      formattedRoutesOutput
    );
  }
}

type Location = {
  time: string;
  name: string;
  latitude: number | null;
  longitude: number | null;
};

type Station = {
  name: string;
  time: string;
};

type Description = {
  html: string;
  stations: Station[];
};

type Amount = {
  id: string;
  value: number;
  type: string;
};

type Offer = {
  id: string;
  name: string;
  code: string;
  choosable: boolean;
  amount: Amount[];
};

type Baggage = {
  name: string;
  amount?: Amount[];
  unit?: string;
};

type Prices = {
  offers: Offer[];
  baggages: Baggage[];
  otherDetails: string;
};

type Convenience = {
  img: string;
  shortName: 'WiFi' | 'TV' | 'Frigider' | 'Masa';
  title: string;
};

type Car = {
  img: string;
  conviniences: Convenience[];
};

type Comfort = {
  car: Car;
};

type Provider = {
  img: string | null;
  name: string;
};

type Course = {
  courseId: string;
  from: Location;
  to: Location;
  description: Description;
  prices: Prices;
  comfort: Comfort;
  provider: Provider;
  notes: any[];
};
