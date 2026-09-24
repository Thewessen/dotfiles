#!/usr/bin/env bash
set -euo pipefail
# reads $CONTAINER and $DEST from the instance's EnvironmentFile
mkdir -p "$DEST"
docker exec "$CONTAINER" pg_dumpall -U postgres | gzip > "$DEST/dump-$(date +%F).sql.gz"
find "$DEST" -name 'dump-*.sql.gz' -mtime +7 -delete
