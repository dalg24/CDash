#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status.
set -e

if [ -z "$CDASH_DB_NAME" ]; then
    CDASH_DB_NAME='cdash'
fi

if [ -z "$CDASH_DB_PASSWORD" ]; then
    CDASH_DB_PASSWORD=''
    echo >&2 'warning: CDASH_DB_PASSWORD environment variable is not set'
    echo >&2 '  The field will be left blank.'
    echo >&2 '  While not mandatory, it is recommended you set a password for'
    echo >%2 '  the CDash database.'
fi

if [ -z "$CDASH_DB_USER" ]; then
    CDASH_DB_USER='cdash'
fi

if [ -z "$CDASH_DB_HOST" ]; then
    echo >&2 'error: missing CDASH_DB_HOST'
    echo >&2 '  Did you forget to --link some_mysql_container:mysql or set an external db'
    echo >&2 '  with -e CDASH_DB_HOST=hostname:port?'
    exit 1
fi

sed -i \
    -e "s/@CDASH_DB_NAME@/$CDASH_DB_NAME/g" \
    -e "s/@CDASH_DB_USER@/$CDASH_DB_USER/g" \
    -e "s/@CDASH_DB_PASSWORD@/$CDASH_DB_PASSWORD/g" \
    -e "s/@CDASH_DB_HOST@/$CDASH_DB_HOST/g" \
    /var/www/html/CDash/cdash/config.local.php

mkdir /var/www/html/CDash/rss
chown -R www-data:www-data /var/www/html/CDash

echo "Done!"

exec "$@"
