# dotfiles (work)

This repo contains all my dotfiles used for my working machine (mac).
The repo is best used as a `--bare` repo.

1. `git clone --bare --single-branch --branch work https://github.com/Thewessen/dotfiles $HOME/.dotfiles`
2. `alias dot='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'`
3. `dot checkout`
4. `dot config --local status.showuntrackedfiles no`

NOTE: If conflicts excist. Backup or delete them and `checkout` again.
