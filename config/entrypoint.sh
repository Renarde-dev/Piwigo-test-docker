#!/bin/sh

# Ensure directories are writable (see https://github.com/MariaDB/mariadb-docker/blob/master/docker-entrypoint.sh)
find "/var/www/html/piwigo/" \! -user nginx \( -exec chown nginx: '{}' + -o -true \)

# Check if the version of piwigo in the volume folder is different from the source
if ! diff /var/www/source/version /var/www/html/piwigo/version &> /dev/null; then
    echo "Installing piwigo version $(cat /var/www/source/version)"
    /bin/cp -arT /var/www/source/piwigo /var/www/html/piwigo/
    /bin/cp -aT /var/www/source/version /var/www/html/piwigo/version
else
    echo "Current piwigo version $(cat /var/www/html/piwigo/version)"
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