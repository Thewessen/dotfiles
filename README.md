# dotfiles
All my configuration files like vimrc and tmux

## Bare repo

Clone this repo as a bare repo:

````
git clone -b laptop --single-branch --bare https://github.com/Thewessen/dotfiles.git
```

Some repo setup:

```
cd dotfiles
git init --separate-git-dir=. $HOME
git config --bool status.showuntrackedfiles false
```

Create an alias. This makes it possible to add files to the repo from anywhere, e.g.:

````
alias dot='/usr/bin/git --git-dir=<dir-of-repo> --work-tree=$HOME
```

From: [The best way to store your dotfiles: A bare Git repository](https://www.atlassian.com/git/tutorials/dotfiles)
