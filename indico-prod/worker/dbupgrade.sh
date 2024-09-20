#!/bin/bash

# /opt/indico/set_user.sh
# . /opt/indico/.venv/bin/activate

connect_to_db() {
    psql -lqt | cut -d \| -f 1 | grep -qw $PGDATABASE
}

# Wait until the DB becomes available
until connect_to_db; do
    echo "Waiting for DB to become available..."
    sleep 1
done

echo 'Upgrading DB...'
indico db upgrade
indico db --all-plugins upgrade
echo ''
echo 'DB Upgrade done'
echo ''
echo 'container will sleep now, you can use that maintenance ...'

sleep 100000000

# echo 'Starting Indico...'
# uwsgi /etc/uwsgi.ini
