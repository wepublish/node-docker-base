FROM node:16.18.1-alpine

LABEL maintainer="tomasz@wepublish.ch"

RUN apk update

ARG LIBVIPS_VERSION=8.13.3
ARG LIBVIPS_SOURCE_TAR=vips-${LIBVIPS_VERSION}.tar.gz
ARG LIBVIPS_SOURCE_URL=https://github.com/libvips/libvips/releases/download/v${LIBVIPS_VERSION}/${LIBVIPS_SOURCE_TAR}

# Install build tools
RUN apk add python3 gcc g++ make --update-cache

# Install libvips dependencies
RUN apk add libjpeg-turbo-dev libexif-dev lcms2-dev fftw-dev giflib-dev glib-dev libpng-dev \
  libwebp-dev expat-dev orc-dev tiff-dev librsvg-dev --update-cache --repository https://dl-3.alpinelinux.org/alpine/latest-stable/main/

# Build libvips with SVG support
RUN mkdir ./libvips \
  && cd ./libvips \
  && wget ${LIBVIPS_SOURCE_URL} \
  && tar -xzf ${LIBVIPS_SOURCE_TAR} --strip 1 \
  && ./configure \
  --prefix=/usr \
  --enable-debug=no \
  --without-gsf \
  --disable-static \
  --mandir=/usr/share/man \
  --infodir=/usr/share/info \
  --docdir=/usr/share/doc \
  && make \
  && make install