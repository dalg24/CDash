#!/usr/bin/env bash

docker run --detach \
  --name mysql \
  --env MYSQL_ALLOW_EMPTY_PASSWORD=yes \
  --env MYSQL_USER=cdash \
  --env MYSQL_PASSWORD="" \
  --env MYSQL_DATABASE=cdash \
  mysql
