#!/usr/bin/env sh

# Creating a copy/backup with rsync
# from home folder
# too /media/Desktop_backup on admin:Pi

rsync -Cavz /home/sthewessen/ admin@pi:/media/Desktop_backup/\
    --exclude='.npm' --exclude='.cache' --exclude='.cinnamon'\
    --exclude='.thunderbird' --exclude='.thumbnails' --exclude='.nave'\
    --exclude='.mozzila' --exclude='.nv' --exclude='.dbus' --exclude='.gvfs'\
    --groupmap='sthewessen:admin'
