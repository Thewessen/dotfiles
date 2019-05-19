#!/usr/bin/env sh

# Creating a copy/backup with rsync
# from /mnt/hdd1 on sthewessen:Desktop
# too /media/Storage on sthewessen:Pi

rsync -Cavzg /mnt/hdd1/ sthewessen@pi:/media/Storage\
    --exclude='.Trash*' --exclude='timeshift' --exclude='boot'\
    --exclude='Spelletjes/Steam'\
    --groupmap='sthewessen:sambashare'

