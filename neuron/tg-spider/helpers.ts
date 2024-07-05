import { NEWS_CHANNELS, initialScrapingDetails } from "../constants.js";
import fsPromise from "fs/promises";
import fs from "fs";
import { utils } from "telegram";
import { fileTypeFromBuffer } from "file-type";
import _ from "lodash";

export const downloadMedia = (post) => async () => {
  if (!post?.media) return;

  let fileExtension = utils.getExtension(post.media);

  if (fileExtension && !fileExtension.startsWith(".")) {
    fileExtension = `.${fileExtension}`;
  }

  if (post.media?.document?.mimeType?.startsWith("audio/")) {
    await post.downloadMedia({
      outputFile: `outputMedia/audio-${post.id}${fileExtension}`,
    });
  }

  if (utils.isImage(post.media)) {
    await post.downloadMedia({
      outputFile: `outputMedia/image-${post.id}${fileExtension}`,
    });
  }

  if (
    post.media?.video &&
    post.media?.document?.mimeType?.startsWith("video/")
  ) {
    await post.downloadMedia({
      outputFile: `outputMedia/video-${post.id}${fileExtension}`,
      // thumb: 0 - interesting
    });
  }

  if (
    post.media?.webpage &&
    (post.media?.webpage?.className !== "WebPageEmpty" ||
      post.media?.webpage?.className !== "WebPagePending")
  ) {
    const outputFile = `outputMedia/image-${post.id}`;

    await post.downloadMedia({
      outputFile,
    });

    try {
      const buffer = await fsPromise.readFile(outputFile);

      if (!buffer) {
        fs.unlink(outputFile, () => {});
      } else {
        const file = await fileTypeFromBuffer(buffer);

        fs.rename(outputFile, `${outputFile}.${file.ext}`, (err) => {
          if (err) throw err;
        });
      }
    } catch (e) {
      console.error(e);
    }
  }
};

const getPromise = (fn) => {
  return new Promise((res, rej) => {
    fn().then(res).catch(rej);
  });
};

export const downloadAllMedia = (posts) => {
  const promisesArray = posts.map((post) => {
    if (post.media) {
      return getPromise(downloadMedia(post));
    } else {
      console.warn("Doesn't have media === ", post.id);
      return Promise.resolve();
    }
  });

  Promise.all(promisesArray).then(() => {
    console.log("theoretically everything is downloaded");
  });
};

export const manageLastPost = async (
  chat,
  client,
  oldestPost,
  prevMessages = []
) => {
  const messages = await client.getMessages(chat, {
    maxId: oldestPost.id,
    limit: initialScrapingDetails.searchForAllMedia,
  });

  const oldestAlbumId = oldestPost.groupedId;

  let breakTheAlbumLoop = false;

  for (const post of messages) {
    if (post.groupedId === oldestAlbumId) continue;

    breakTheAlbumLoop = true;
  }

  if (!breakTheAlbumLoop)
    return manageLastPost(
      chat,
      client,
      messages[messages.length - 1],
      prevMessages.concat(messages)
    );

  return prevMessages.concat(messages);
};

export const groupPosts = (messages) => {
  const posts = [];

  let lastGroupId = null;

  for (const post of messages) {
    const initial = {
      message: post.message,
      messageDate: post.date,
      pinned: post.pinned,
      views: post.views,
      editDate: post.editDate,
      groupedId: post.groupedId,
      restrictionReason: post.restrictionReason,
      ttlPeriod: post.ttlPeriod,
      factcheck: post.factcheck,
      entities: post.entities,
      reactions: post.reactions,
    };

    const currentPostGroupedIdString = post.groupedId.value?.toString();

    if (post.groupedId) {
      if (post.message) {
        if (lastGroupId === currentPostGroupedIdString) {
          const lastPost = posts[posts.length - 1];
          const newMedia = [...lastPost.media];
          if (post.media) {
            newMedia.push({ id: post.id });
          }
          initial.media = newMedia;
          posts[posts.length - 1] = initial;
        } else {
          initial.media = [{ id: post.id }];
          posts.push(initial);

          lastGroupId = currentPostGroupedIdString;
        }
      } else if (lastGroupId === currentPostGroupedIdString && post.media) {
        posts[posts.length - 1].media.push({ id: post.id });
      } else if (lastGroupId !== currentPostGroupedIdString && post.media) {
        initial.media = [{ id: post.id }];
        posts.push(initial);

        lastGroupId = currentPostGroupedIdString;
      }
    } else {
      initial.media = post.media ? [{ id: post.id }] : [];
      posts.push(initial);

      lastGroupId = null;
    }
  }

  return posts;
};

export const managePosts = async (chat, client, messages = []) => {
  let posts = messages;

  const oldestPost = posts[posts.length - 1];

  if (oldestPost.groupedId) {
    const anotherPosts = await manageLastPost(chat, client, oldestPost);
    posts.push(...anotherPosts);

    const lastIndexOfGroupedId = _.findLastIndex(
      posts,
      (post) => post.groupedId === oldestPost.groupedId
    );

    posts.splice(lastIndexOfGroupedId + 1);
  } else {
    console.log("no groupedID", posts.length - 1);
  }

  // downloadAllMedia(posts);

  const newPosts = groupPosts(posts);

  return newPosts;
};

// use this to get also chats, count messages, users(maybe who are admins or did write the post) + messages
// const request = new Api.messages.GetHistory({
//   peer: chat,
//   limit: initialScrapingDetails.channelNewsThreshold,
// });

// const result = await client.invoke(request);
