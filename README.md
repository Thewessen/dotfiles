# dotfiles
All my configuration files like vimrc and tmux

## Bare repo

Clone this repo as a bare repo:

`git clone -b laptop --single-branch --bare https://github.com/Thewessen/dotfiles.git`

Create an alias, e.g.:

`alias dot='/usr/bin/git --git-dir=<dir-of-repo> --work-tree=$HOME`

Add nice config:

`dot config status.showuntrackedfiles no`


From: [The best way to store your dotfiles: A bare Git repository](https://www.atlassian.com/git/tutorials/dotfiles)
