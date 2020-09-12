#!/usr/bin/env bash

set -o errexit
set -o nounset

main () {
	local REPO=https://github.com/Thewessen/dotfiles
	echo 'cloning int repo $REPO'
	git clone --bare $REPO $HOME/.dotfiles
	if [ -f $HOME/.zshrc ]; then
		echo 'sourcing zshrc'
		source $HOME/.zshrc
	fi
	echo 'setting config for bare repo'
	dot config --local status.showUntrackedFiles no
}

main "$@"
