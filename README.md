# dotfiles
All my configuration files like vimrc and tmux

Kept as a bare repo with `$HOME` as work tree, one branch per machine. This is
the `pi` branch.

## Setup on a new Pi

```sh
sudo apt install git zsh curl

# oh-my-zsh first: its installer refuses to run when ~/.oh-my-zsh already exists
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# --single-branch: only this branch, not the other machines' configs
git clone --bare --single-branch -b pi https://github.com/Thewessen/dotfiles.git "$HOME/.dotfiles"
alias dot='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
dot config status.showUntrackedFiles no
# Fetch only pi as well, so a stray `dot checkout work` can't create a branch
# from origin/work and overwrite $HOME with another machine's config
dot config remote.origin.fetch '+refs/heads/pi:refs/remotes/origin/pi'
dot fetch origin && dot branch -u origin/pi pi

# -f overwrites the default .bashrc and the .zshrc oh-my-zsh just wrote
dot checkout -f pi

chsh -s "$(command -v zsh)"
```

## Cloned with all branches?

An older setup (plain `clone --bare`, fetching `refs/heads/*`) has a local
branch and a remote-tracking branch for every machine. Keep only `pi`:

```sh
dot branch -D laptop master minimal work
dot config remote.origin.fetch '+refs/heads/pi:refs/remotes/origin/pi'
dot branch -dr origin/laptop origin/master origin/minimal origin/work
```

This only changes the local repo; the branches on GitHub stay.
