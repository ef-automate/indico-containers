#!/bin/bash

# set -euxo pipefail

# stop everything
docker compose stop

# start up necessary containers and run db upgrade
docker compose -f docker-compose.yml -f docker-compose.override.yml -f docker-compose.dbupgrade.yml up -d indico-web

# start all
docker compose up -d
