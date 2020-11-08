#!/usr/bin/env bash

# A setup script for the bare dotfiles repo

set -o errexit
set -o nounset

main () {
	local REPO="https://github.com/Thewessen/dotfiles"
    local BRANCH="laptop"
    local FOLDER="$HOME/repos/dotfiles"
	echo "cloning int repo $REPO"
	git clone -b $BRANCH --single-branch --bare $REPO $FOLDER
    cd $FOLDER
    local dot="git --work-tree=$HOME --git-dir=$FOLDER"
    dot checkout
	echo "setting config for bare repo"
	dot config --local status.showUntrackedFiles no
    git --init --separate-git-dir=. $HOME
    cd -
}

main "$@"
