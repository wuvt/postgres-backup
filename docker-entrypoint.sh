#!/bin/bash
export PGPASSWORD="$POSTGRES_PASSWORD"
exec "$@"
