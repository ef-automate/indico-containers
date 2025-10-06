cd ~/indico-containers/indico-prod
docker compose exec -u postgres indico-postgres bash -c "pg_dump -U indico indico | gzip > /dbdumps/indico.db.sql.gz"
