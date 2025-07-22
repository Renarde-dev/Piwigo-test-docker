#!/bin/sh

PHP_VERSION=#DOCKER_ARG_PHP_VERSION#

# Ensure directories are writable (see https://github.com/MariaDB/mariadb-docker/blob/master/docker-entrypoint.sh)
find "/var/www/html/" \! -user nobody \( -exec chown nobody: '{}' + -o -true \) 

if [ true ]; then
    cp -arT /var/source/html /var/www/html/
fi

# Load user scripts if it exist
if [ -e "/usr/local/bin/scripts/user.sh" ]; then
    echo "Loading user script"
    chmod +x "/usr/local/bin/scripts/user.sh"
    /bin/ash -c "/usr/local/bin/scripts/user.sh"
else
    echo "No user script found, you can add one in ./piwigo-data/scripts/user.sh"
fi

# Configure supervisor
exec "php-fpm$PHP_VERSION" -F -R