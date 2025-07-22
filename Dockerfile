FROM docker.io/alpine:latest

ARG PHP_VERSION="83"
ARG PIWIGO_VERSION="15.5.0"

RUN apk add --update --no-cache \
	# PHP fpm
	php${PHP_VERSION} php${PHP_VERSION}-fpm \
	# PHP dependencies
	php${PHP_VERSION}-bcmath php${PHP_VERSION}-calendar php${PHP_VERSION}-ctype \
	php${PHP_VERSION}-curl php${PHP_VERSION}-dom php${PHP_VERSION}-exif \
	php${PHP_VERSION}-ffi php${PHP_VERSION}-fileinfo php${PHP_VERSION}-ftp \
	php${PHP_VERSION}-gd php${PHP_VERSION}-gettext php${PHP_VERSION}-iconv \
	php${PHP_VERSION}-imap php${PHP_VERSION}-mbstring php${PHP_VERSION}-mysqli \
	php${PHP_VERSION}-mysqlnd php${PHP_VERSION}-opcache php${PHP_VERSION}-openssl \
	php${PHP_VERSION}-pcntl php${PHP_VERSION}-pdo php${PHP_VERSION}-pdo_mysql \
	php${PHP_VERSION}-phar php${PHP_VERSION}-posix php${PHP_VERSION}-session \
	php${PHP_VERSION}-shmop php${PHP_VERSION}-simplexml php${PHP_VERSION}-sockets \
	php${PHP_VERSION}-sodium php${PHP_VERSION}-sysvmsg php${PHP_VERSION}-sysvsem \
	php${PHP_VERSION}-sysvshm php${PHP_VERSION}-tokenizer php${PHP_VERSION}-xml \
	php${PHP_VERSION}-xmlreader php${PHP_VERSION}-xmlwriter php${PHP_VERSION}-xsl \
	php${PHP_VERSION}-zip \
	# External dependencies
	exiftool ffmpeg mediainfo ghostscript findutils \
	# Imagemagick
	imagemagick \
	imagemagick-heic imagemagick-jpeg imagemagick-jxl \
	imagemagick-pango imagemagick-pdf imagemagick-raw \
	imagemagick-svg imagemagick-tiff imagemagick-webp

RUN sed -i "s|;listen.group\s*=\s*nobody|listen.group = www-data|g" /etc/php${PHP_VERSION}/php-fpm.d/www.conf \
&& sed -i "s|group\s*=\s*nobody|group = www-data|g" /etc/php${PHP_VERSION}/php-fpm.d/www.conf

# Copy startup script
COPY --chmod=0755 "./entrypoint.sh" "/usr/local/bin/docker-piwigo-entrypoint"
RUN sed -i "s/#DOCKER_ARG_PHP_VERSION#/${PHP_VERSION}/" "/usr/local/bin/docker-piwigo-entrypoint"

RUN mkdir -p /var/www/html/ /var/source/html
RUN echo "<?php phpinfo();?>" > /var/source/html/index.php

# Define entrypoint
ENTRYPOINT ["/bin/ash","-c"]
CMD ["docker-piwigo-entrypoint"]