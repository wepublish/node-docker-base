FROM node:16.18.1-alpine

LABEL maintainer="tomasz@wepublish.ch"

RUN apk upgrade --update-cache --available && \
  rm -rf /var/cache/apk/*