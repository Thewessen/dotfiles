#!/bin/bash
source /etc/ntfy-tokens.env
THRESHOLD=85
NTFY="http://192.168.10.82:8080/disk-space/publish"

df -h --output=pcent,target -x tmpfs -x devtmpfs | tail -n +2 | while read -r pcent mount; do
  pct=${pcent%\%}
  if [ "$pct" -ge "$THRESHOLD" ]; then
    curl -s -G -H "Authorization: Bearer $DISK_CHECK_TOKEN" \
      --data-urlencode "message=Disk $mount at ${pct}% on $(hostname)" \
      --data-urlencode "title=Disk space warning" \
      "$NTFY"
  fi
done
