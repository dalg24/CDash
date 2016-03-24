#!/usr/bin/env bash

docker run --detach \
  --publish 80:80 \
  --name cdash \
  --env CDASH_DB_HOST=mysql:3306 \
  --env CDASH_DB_PASSWORD=pass \
  --link mysql:mysql \
  cdash
