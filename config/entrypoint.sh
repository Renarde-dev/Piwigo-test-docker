#!/bin/sh

# Ensure directories are writable (see https://github.com/MariaDB/mariadb-docker/blob/master/docker-entrypoint.sh)
user="$(id -u)"
if [ "$user" = "0" ]; then # Only chown if root
    # iterate through every volume
    for volume_folder in "_data" "upload" "galleries" "local/config"; do
        # this will cause less disk access than `chown -R`
        find "/var/www/html/piwigo/$volume_folder" \! -user nginx \( -exec chown nginx: '{}' + -o -true \)
    done
fi

# Load user scripts if it exist
if [ -e "/usr/local/bin/scripts/user.sh" ]; then
    echo "Loading user script"
    chmod +x "/usr/local/bin/scripts/user.sh"
    /bin/ash -c "/usr/local/bin/scripts/user.sh"
else
    echo "No user script found, you can add one at ./piwigo-data/scripts/user.sh"
fi

# Log that the script has finished
echo "Starting supervisord"