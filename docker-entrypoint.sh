#!/bin/bash
export PGPASSWORD="$POSTGRES_PASSWORD"

if [ "$1" = 'autodump' ]; then
    #exec pg_dumpall -h postgres -U postgres -f "/data/$(date +%Y%m%d).sql"
    pg_dump -h postgres -U postgres -d jira -f "/data/jira_$(date +%Y%m%d).sql"
    pg_dump -h postgres -U postgres -d wuvt -f "/data/wuvt_$(date +%Y%m%d).sql"
    pg_dump -h postgres -U postgres -d wuvtam -f "/data/wuvtam_$(date +%Y%m%d).sql"
else
    exec "$@"
fi
