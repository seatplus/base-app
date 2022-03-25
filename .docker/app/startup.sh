#!/bin/sh
set -e

# Wait for the database
while ! mysqladmin ping --host=${DB_HOST} --user=${DB_USERNAME} --password=${DB_PASSWORD} --silent; do

    echo "MariaDB container might not be ready yet... sleeping..."
    sleep 10
done

FILE=/var/www/html/composer.json
if [ ! -f "$FILE" ]; then
    echo "$FILE does not exists."
fi
