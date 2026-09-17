#!/bin/bash
[ "$PAM_TYPE" = "open_session" ] || exit 0
source /etc/ntfy-tokens.env
curl -s -G -H "Authorization: Bearer $SSH_LOGIN_TOKEN" \
  --data-urlencode "message=SSH login: $PAM_USER from $PAM_RHOST on $(hostname)" \
  --data-urlencode "title=SSH login" \
  --data-urlencode "priority=high" \
  "http://192.168.10.82:8080/ssh-logins/publish"
exit 0
