#!/usr/bin/env zsh

DESKTOP_ACTIVE=0
LAPTOP_ACTIVE=0
STORAGE_ACTIVE=0
MODE=1
CHECKED="\033[38;5;2mx\033[0m"
PUSH="\033[38;5;1m=>\033[0m"
SYNC="\033[38;5;3m<=>\033[0m"
PULL="\033[38;5;5m<=\033[0m"

ctrl_c() {
    echo
    echo "Aborting!"
    tmux kill-session
    exit
}

print_mode() {
    echo "Available modes (p)ush (s)ync pul(l) (c)lear"
    case $MODE in
        1) echo "Current mode: Push (${PUSH})\n";;
        2) echo "Current mode: Sync (${SYNC})\n";;
        3) echo "Current mode: Pull (${PULL})\n";;
        4) echo "Current mode: Syncing$string\n";;
        *) exit ;;
    esac
}

print_settings() {
    case $DESKTOP_ACTIVE in
        0) echo "[ ] Desktop.";;
        1) echo "[${CHECKED}] Desktop: $HOME ${PUSH} admin@pi:/media/Desktop_backup";;
        2) echo "[${CHECKED}] Desktop: $HOME ${SYNC} admin@pi:/media/Desktop_backup";;
        3) echo "[${CHECKED}] Desktop: $HOME ${PULL} admin@pi:/media/Desktop_backup";;
        *) exit;;
    esac
    case $LAPTOP_ACTIVE in
        0) echo "[ ] Laptop.";;
        1) echo "[${CHECKED}] Laptop: $HOME ${PUSH} admin@pi:/media/Laptop_backup";;
        2) echo "[${CHECKED}] Laptop: $HOME ${SYNC} admin@pi:/media/Laptop_backup";;
        3) echo "[${CHECKED}] Laptop: $HOME ${PULL} admin@pi:/media/Laptop_backup";;
        *) exit;;
    esac
    case $STORAGE_ACTIVE in
        0) echo "[ ] Storage.";;
        1) echo "[${CHECKED}] Storage: $HOME ${PUSH} admin@pi:/media/Storage_backup";;
        2) echo "[${CHECKED}] Storage: $HOME ${SYNC} admin@pi:/media/Storage_backup";;
        3) echo "[${CHECKED}] Storage: $HOME ${PULL} admin@pi:/media/Storage_backup";;
        *) exit;;
    esac
    echo
}

user_input() {
    printf "1) Desktop, 2) Laptop, 3) Storage: "
    if [ $MODE -ne 4 ]; then
        read -k 1 R
    fi
    echo

    case $R in
        1) case $MODE in
               1) DESKTOP_ACTIVE=1 ;;
               2) DESKTOP_ACTIVE=2 ;;
               3) DESKTOP_ACTIVE=3 ;;
               *) DESKTOP_ACTIVE=0 ;;
           esac ;;
        2) case $MODE in
               1) LAPTOP_ACTIVE=1 ;;
               2) LAPTOP_ACTIVE=2 ;;
               3) LAPTOP_ACTIVE=3 ;;
               *) LAPTOP_ACTIVE=0 ;;
           esac ;;
        3) case $MODE in
               1) STORAGE_ACTIVE=1 ;;
               2) STORAGE_ACTIVE=2 ;;
               3) STORAGE_ACTIVE=3 ;;
               *) STORAGE_ACTIVE=0 ;;
           esac ;;
        p) MODE=1 ;;
        s) MODE=2 ;;
        l) MODE=3 ;;
        c) DESKTOP_ACTIVE=0
           LAPTOP_ACTIVE=0
           STORAGE_ACTIVE=0
           ;;
        q) echo
           exit
           ;;
        *)
            printf "Are you happy with these settings? [Y/n]"
            if [ $MODE -ne 4 ]; then read -k 1
                if [ $R = "n" ]; then continue; fi
            fi
            echo
            break
            ;;
    esac
}

while true; do

    while true; do
        clear
        echo "WELCOME TO THE BACKUP UTILITY!\n"
        echo "What do you want to backup?\n"
        echo "(multiple options possible)\n"
        print_mode
        print_settings
        user_input
    done

    trap ctrl_c INT

    if [ $MODE -ne 4 ]; then
        # Keeping track of number of splits
        PANES=$(tmux list-panes | tail -1 | grep -oE '^.')

        tmux split-window "$HOME/.dotfiles/backup/backup_desktop.sh"
        tmux last-pane
        tmux split-window "$HOME/.dotfiles/backup/backup_storage.sh"
        tmux last-pane
        MODE=4
    fi
    CURRENT=$(tmux list-panes | tail -1 | grep -oE '^.')
    if [ $CURRENT -eq $PANES ]; then
        echo
        echo "DONE!"
        tmux kill-pane
        exit
    fi
    string=".$string"
    if [ ${#string} -eq 4 ]; then
        string="."
    fi
    sleep 1
done
