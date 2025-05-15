#!/bin/sh

# Ensure directories are writable (see https://github.com/MariaDB/mariadb-docker/blob/master/docker-entrypoint.sh)
user="$(id -u)"
if [ "$user" = "0" ]; then # Only chown if root to avoid errors
    # iterate through every volume
    for volume_folder in "_data" "upload" "galleries" "local/config"; do
        # this will cause less disk access than `chown -R`
        find "/var/www/html/piwigo/$volume_folder" \! -user nginx \( -exec chown nginx: '{}' + -o -true \)
    done
fi

# Launch supervisord (php-fpm + nginx)
/usr/bin/supervisord -c /etc/supervisord.conf