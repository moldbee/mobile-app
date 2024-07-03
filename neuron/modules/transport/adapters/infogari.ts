import axios from 'axios';
import { JSDOM } from 'jsdom';

export class InfogariAdapter {
  locale: 'ro' | 'ru';
  localeForUrl: string;
  headers: any;
  csrf: {
    cookie: string | null | undefined;
    header: string | null | undefined;
  };

  constructor(locale: 'ro' | 'ru') {
    this.locale = locale;
    this.csrf = {
      cookie: null,
      header: null,
    };
    this.localeForUrl = this.locale === 'ru' ? 'ru' : '';
    this.headers = {
      Host: 'infogari.md',
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
    };
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
      { headers: this.headers }
    );

    return response.data[0].id;
  }

  async getBackendDataFromPage(url: string) {
    const response = await axios.get(url);

    const jsdom = new JSDOM(response.data);

    this.csrf = {
      header: jsdom.window.document
        .querySelector('meta[name="csrf-token"]')
        ?.getAttribute('content'),
      // @ts-ignore
      cookie: response?.headers['set-cookie']?.at(1).split(';').at(0) + ';',
    };

    let backendData: any;
    jsdom.window.document.querySelectorAll('script').forEach((script) => {
      if (!script.textContent?.includes('renderBookATicketWizardComponent'))
        return;

      const getDataFromBackend = new Function(
        'jQuery',
        'renderBookATicketWizardComponent',
        'document',
        'backendData',
        script.textContent
      );

      getDataFromBackend(
        (func: any) => {
          return func();
        },
        (arg: any, jsObject: any) => (backendData = jsObject),
        jsdom.window.document,
        backendData
      );
    });

    return backendData;
  }

  async search(from: string, to: string) {
    const [fromId, toId] = await Promise.all([
      await this.getIdOptionOfCity(from, 'departure'),
      await this.getIdOptionOfCity(to, 'arrival'),
    ]);

    const backendData = await this.getBackendDataFromPage(
      `https://infogari.md/book/${this.localeForUrl}/site/search?from=${fromId}&to=${toId}&date=05-07-2024&passengers=1`
    );
    const coursesPromises = backendData.results.blocks.left.courses.list.map(
      async ({
        courseId,
        segmentId,
      }: {
        segmentId: string;
        courseId: string;
      }) => {
        console.log(this.csrf);
        const { data: courseDataFromBackend } = await axios.post<Course>(
          `https://infogari.md/${this.locale}/site/coursedetails`,
          { courseId, segmentId },
          {
            headers: {
              'X-CSRF-Token': this.csrf.header,
              Cookie: this.csrf.cookie,
              ...this.headers,
            },
          }
        );

        console.log(courseDataFromBackend);

        const formattedRoute = {
          from: {
            adress: courseDataFromBackend.from.name,
          },
          to: {
            adress: courseDataFromBackend.to.name,
          },
          price: courseDataFromBackend.prices.offers[0].amount,
          transport: {
            image:
              'https://infogari.md' + courseDataFromBackend.comfort.car.img,
            comforts: {
              wifi: courseDataFromBackend.comfort.car.conviniences.some(
                (conv) => conv.shortName === 'WiFi'
              ),
              tv: courseDataFromBackend.comfort.car.conviniences.some(
                (conv) => conv.shortName === 'TV'
              ),
              refrigerator: courseDataFromBackend.comfort.car.conviniences.some(
                (conv) => conv.shortName === 'Frigider'
              ),
              food: courseDataFromBackend.comfort.car.conviniences.some(
                (conv) => conv.shortName === 'Masa'
              ),
            },
          },
          company: courseDataFromBackend.provider.name,
        };

        return formattedRoute;
      }
    );

    return await Promise.all(coursesPromises);
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
