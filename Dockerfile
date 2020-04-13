FROM node:alpine
LABEL maintainer="alex@openzula.org"

RUN apk update
RUN apk add --no-cache nasm git unzip

WORKDIR /usr/src/app

## Make some common directories that may need to exist
RUN mkdir -p public/dist/css
RUN mkdir -p public/dist/fonts
RUN mkdir -p public/dist/js
RUN mkdir -p resources/assets

## Following are ran at build time to allow the real code to run
ONBUILD COPY src/package.json .
ONBUILD RUN npm install

