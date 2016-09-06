#!/bin/bash
export PGPASSWORD="$POSTGRES_PASSWORD"

if [ "$1" = 'autodump' ]; then
    exec pg_dumpall -h postgres -U postgres -f "/data/$(date +%Y%m%d).sql"
else
    exec "$@"
fi
