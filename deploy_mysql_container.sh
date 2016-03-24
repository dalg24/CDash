#!/usr/bin/env bash

if [ -z "${MYSQL_ROOT_PASSWORD}" -o -z "${CDASH_DB_PASSWORD}" ]; then
    echo >&2 "Nope..."
    exit 1
fi

docker run --detach \
  --name mysql \
  --env MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD} \
  --env MYSQL_ALLOW_EMPTY_PASSWORD=yes \
  --env MYSQL_USER=cdash \
  --env MYSQL_PASSWORD=${CDASH_DB_PASSWORD} \
  --env MYSQL_DATABASE=cdash \
  mysql
