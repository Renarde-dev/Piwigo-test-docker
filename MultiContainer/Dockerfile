# Set PHP Version
FROM php:8.2-fpm-alpine
ARG PHP_VERSION="82"

RUN apk add --update --no-cache \
    # PHP dependencies
    php${PHP_VERSION}-mysqli \
    php${PHP_VERSION}-gd \
    php${PHP_VERSION}-imap \
    php${PHP_VERSION}-zip \
    php${PHP_VERSION}-bcmath \
    # External dependencies
    imagemagick exiftool ffmpeg mediainfo ghostscript