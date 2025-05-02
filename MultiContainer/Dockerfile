# Set PHP Version
FROM php:8.2-fpm-alpine

RUN apk add --update --no-cache \
    # PHP dependencies
    libzip-dev zip \
    libjpeg-turbo-dev libpng-dev libwebp-dev freetype-dev \
    imap-dev krb5-dev openssl-dev \
    # External dependencies
    imagemagick exiftool ffmpeg mediainfo ghostscript
RUN docker-php-ext-configure gd --with-jpeg --with-webp --with-freetype 
RUN docker-php-ext-configure imap --with-imap-ssl --with-kerberos
RUN docker-php-ext-install mysqli gd imap zip bcmath
RUN docker-php-ext-enable mysqli gd imap zip bcmath
RUN chown -R 101:101 /var/www/html