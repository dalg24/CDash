#!/usr/bin/env bash

if [ -z "${CDASH_DB_PASSWORD}" ]; then
    echo >&2 "Nope..."
    exit 1
fi

docker run --detach \
  --publish 80:80 \
  --name cdash \
  --link mysql:mysql \
  --env CDASH_DB_HOST=mysql:3306 \
  --env CDASH_DB_USER=cdash \
  --env CDASH_DB_PASSWORD=${CDASH_DB_PASSWORD} \
  --env CDASH_DB_NAME=cdash \
  cdash
