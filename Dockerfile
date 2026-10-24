
FROM node:20-bookworm-slim

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       ffmpeg yt-dlp unzip ca-certificates \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY 3zane-main.zip /tmp/3zane-main.zip

RUN unzip -q /tmp/3zane-main.zip -d /tmp/project \
    && cp -a /tmp/project/WEB-CONVERTER-main/. /app/ \
    && npm ci --omit=dev \
    && rm -rf /tmp/project /tmp/3zane-main.zip

ENV NODE_ENV=production

EXPOSE 10000

CMD ["npm", "start"]
