import axios from "axios";
import _ from "lodash";

interface ScrapePage {
  date: string;
  title: string;
}

const manageNodes = (node: any) => {
  for (const prop in node) {
    if (prop.startsWith("title")) {
      const title = _.findKey(
        node[prop],
        (value, key) => key.startsWith("title") && !key.startsWith("titleimg")
      );

      const subtitle = _.findKey(node[prop], (value, key) =>
        key.startsWith("subtitle")
      );

      const mainImageUrl = _.findKey(node[prop], (value, key) =>
        key.startsWith("url")
      );
    }

    if (prop.startsWith("node")) {
      const paragraph = _.findKey(node[prop], (value, key) =>
        key.startsWith("paragraph")
      );
    }

    if (prop.startsWith("quote")) {
      const content = _.findKey(node[prop], (value, key) =>
        key.startsWith("content")
      );

      const author = _.findKey(node[prop], (value, key) =>
        key.startsWith("author")
      );
    }

    if (prop.startsWith("image")) {
      const url = _.findKey(node[prop], (value, key) => key.startsWith("url"));

      const title = _.findKey(node[prop], (value, key) =>
        key.startsWith("title")
      );

      const imageSource = _.findKey(node[prop], (value, key) =>
        key.startsWith("source")
      );
    }

    if (prop.startsWith("video")) {
      const videoUrl = node[prop];
    }
  }
};

class AgoraAdapter {
  static ARTICLE_API = "https://api.agora.md/articlepage";
  static STORAGE_API = "https://storage.agora.md/api/v1/t";

  async scrapePage({ date, title }: ScrapePage) {
    const timestamp = Date.parse(date);

    if (isNaN(timestamp) || typeof title !== "string") return;

    const endpoint = `${AgoraAdapter.ARTICLE_API}/${timestamp}/${title}`;

    const options = {
      method: "get",
      url: endpoint,
    };

    const response = await axios(options).catch((reason) => {
      // store log error
      console.error(reason);
    });

    if (response?.data) {
      const { data } = response;

      const aggregatedData = {
        id: data.id,
        url: data.url,
        published: data.published,
        updated: data.updated,
      };

      for (const node of data.content) {
        if (_.isObject(node)) {
        }
      }
    }
  }
}

export const agora = new AgoraAdapter();

agora.scrapePage({
  date: "2024/06/19",
  title:
    "accident-rutier-pe-bulevardul-renasterii-nationale-trei-masini-deteriorate-video",
});
