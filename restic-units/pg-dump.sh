#!/usr/bin/env bash
set -euo pipefail
# reads $CONTAINER and $DEST from the instance's EnvironmentFile
mkdir -p "$DEST"
out="$DEST/dump-$(date +%F).sql.gz"
tmp="$out.tmp"
trap 'rm -f "$tmp"' EXIT
docker exec "$CONTAINER" pg_dumpall -U postgres | gzip > "$tmp"
gzip -t "$tmp"
[ "$(zcat "$tmp" | tail -n 5 | grep -c "dump complete")" -eq 1 ]
mv "$tmp" "$out"
find "$DEST" -name 'dump-*.sql.gz' -mtime +7 -delete
