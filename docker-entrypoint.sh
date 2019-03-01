#!/bin/bash
export PGPASSWORD="$POSTGRES_PASSWORD"

if [ "$1" = 'autodump' ]; then
    if [ -n "$DATABASES" ]; then
        for db in $DATABASES; do
            dest="/data/${db}_$(date +%Y%m%d).sql"
            pg_dump -h "$POSTGRES_SERVER" -U postgres -d $db -f "$dest"
            if [ -n "$SFTP_DEST" ]; then
                echo "put \"$dest\"" | sftp -b - \
                    -o UserKnownHostsFile=/etc/sshkeys/known_hosts \
                    -i /etc/sshkeys/backup "$SFTP_DEST"
                rm -f "$dest"
            fi
        done
    else
        dest="/data/$(date +%Y%m%d).sql"
        pg_dumpall -h "$POSTGRES_SERVER" -U postgres -f "$dest"
        if [ -n "$SFTP_DEST" ]; then
            echo "put \"$dest\"" | sftp -b - \
                -o UserKnownHostsFile=/etc/sshkeys/known_hosts \
                -i /etc/sshkeys/backup "$SFTP_DEST"
            rm -f "$dest"
        fi
    fi
else
    exec "$@"
fi

if [[ -n "$HEALTHCHECK_WEBHOOK" ]]; then
    curl -fsS --retry 3 $HEALTHCHECK_WEBHOOK > /dev/null
fi
