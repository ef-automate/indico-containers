#!/bin/bash

set -euxo pipefail

docker compose up -d indico-postgres
sleep 10

docker compose exec -u postgres indico-postgres zcat /dbdumps/indico.db.sql.gz | psql -U indico --set ON_ERROR_STOP=on indico 

docker compose up -d indico-web

