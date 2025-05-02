# Set PHP Version
FROM nginx:stable-alpine
ARG PHP_VERSION="82"

RUN apk add --update --no-cache \
    # PHP dependencies
    php${PHP_VERSION} \
    php${PHP_VERSION}-mysqlnd \
    php${PHP_VERSION}-fpm \
	php${PHP_VERSION}-soap \
	php${PHP_VERSION}-openssl \
	php${PHP_VERSION}-gmp \
	php${PHP_VERSION}-pdo_odbc \
	php${PHP_VERSION}-json \
	php${PHP_VERSION}-dom \
	php${PHP_VERSION}-pdo \
	php${PHP_VERSION}-zip \
	php${PHP_VERSION}-mysqli \
	php${PHP_VERSION}-sqlite3 \
	php${PHP_VERSION}-apcu \
	php${PHP_VERSION}-pdo_pgsql \
	php${PHP_VERSION}-bcmath \
	php${PHP_VERSION}-gd \
	php${PHP_VERSION}-odbc \
	php${PHP_VERSION}-pdo_mysql \
	php${PHP_VERSION}-pdo_sqlite \
	php${PHP_VERSION}-gettext \
	php${PHP_VERSION}-xmlreader \
	php${PHP_VERSION}-bz2 \
	php${PHP_VERSION}-iconv \
	php${PHP_VERSION}-pdo_dblib \
	php${PHP_VERSION}-curl \
	php${PHP_VERSION}-ctype \
	php${PHP_VERSION}-imap \
    # External dependencies
    imagemagick exiftool ffmpeg mediainfo ghostscript \
    # Supervisor to run PHP-FPM and NGINX
    supervisor
COPY ./config/php-fpm.conf /etc/profile.d/php${PHP_VERSION}.sh
COPY ./config/nginx.conf /etc/nginx/nginx.conf
COPY ./src /www/
COPY ./config/supervisord.conf /etc/supervisord.conf
RUN sed -i "s/PHP-VERSION/${PHP_VERSION}/" /etc/supervisord.conf
CMD ["/usr/bin/supervisord","-c","/etc/supervisord.conf"]