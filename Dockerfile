FROM nginx:stable-alpine
# Set PHP Version (No dot)
ARG PHP_VERSION="82"

RUN apk add --update --no-cache \
    # PHP dependencies
    php${PHP_VERSION} \
    php${PHP_VERSION}-mysqlnd \
    php${PHP_VERSION}-mbstring \
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
# Configure PHP-FPM
RUN sed -i "s|;listen.owner\s*=\s*nobody|listen.owner = nginx|g" /etc/php${PHP_VERSION}/php-fpm.d/www.conf \
&& sed -i "s|;listen.group\s*=\s*nobody|listen.group = nginx|g" /etc/php${PHP_VERSION}/php-fpm.d/www.conf \
&& sed -i "s|user\s*=\s*nobody|user = nginx|g" /etc/php${PHP_VERSION}/php-fpm.d/www.conf \
&& sed -i "s|group\s*=\s*nobody|group = nginx|g" /etc/php${PHP_VERSION}/php-fpm.d/www.conf

# Copy NGINX config
COPY ./config/nginx.conf /etc/nginx/nginx.conf
RUN mkdir -p /var/www/html/
COPY ./src /var/www/html/
RUN chown -R nginx:nginx /var/www/html/

# Configure and set the php version of supervisor
COPY ./config/supervisord.conf /etc/supervisord.conf
RUN sed -i "s/PHP-VERSION/${PHP_VERSION}/" /etc/supervisord.conf

CMD ["/usr/bin/supervisord","-c","/etc/supervisord.conf"]