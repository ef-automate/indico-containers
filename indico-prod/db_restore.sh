#!/bin/bash

set -euxo pipefail

docker compose up -d indico-postgres
sleep 10

docker compose exec -u postgres indico-postgres dropdb -U indico --force --if-exists indico
docker compose exec -u postgres indico-postgres createdb -U indico indico
docker compose exec -u postgres indico-postgres bash -c "zcat /dbdumps/indico.db.sql.gz | psql -U indico --set ON_ERROR_STOP=on indico"

