# syntax=docker/dockerfile:1

ARG NODE_VERSION=20.15.0

FROM node:${NODE_VERSION}-alpine

ENV NODE_ENV development

WORKDIR /app

RUN --mount=type=bind,source=package.json,target=package.json \
    --mount=type=bind,source=package-lock.json,target=package-lock.json \
    --mount=type=cache,target=/root/.npm \
    npm ci --omit=dev

RUN chown -R node:node /app
RUN mkdir -p /app/build && chown -R node:node /app/build

USER node

COPY . .

EXPOSE 8080

CMD ["npm", "start"]
