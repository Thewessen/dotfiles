#!/usr/bin/env zsh


if [ -z $TMUX ]; then
    tmux new-session -s "BACKUP" "tmux rename-window backup; /home/sthewessen/.dotfiles/backup/backup.sh"
else
    tmux new-window -n "backup" "/home/sthewessen/.dotfiles/backup/backup.sh"
fi
