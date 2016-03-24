#!/usr/bin/env bash

docker run --detach \
  --publish 80:80 \
  --name cdash \
  --link mysql:mysql \
  cdash
