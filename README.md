# dotfiles
All my configuration files like vimrc and tmux

Kept as a bare repo with `$HOME` as work tree, one branch per machine. This is
the `pi` branch.

## Setup on a new Pi

```sh
sudo apt install git zsh tmux fzf curl

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

## Neovim

Upstream release instead of Debian's (trixie has 0.10), because the config uses
`vim.pack` from Neovim 0.12. nvim-treesitter needs tree-sitter CLI 0.26.1+
(trixie has 0.22) to build parsers. Check the current versions and SHA-256s on
the GitHub release pages.

```sh
sudo apt install ripgrep fd-find gcc   # for fzf-lua and building parsers

cd /tmp
curl -fLO https://github.com/neovim/neovim/releases/download/v0.12.5/nvim-linux-arm64.tar.gz
echo "1aa5ca085249580ae0f91eb14f27ec0919773ff2d99a163d03f3d6c21ac29725  nvim-linux-arm64.tar.gz" | sha256sum -c
sudo rm -rf /opt/nvim-linux-arm64 && sudo tar -C /opt -xzf nvim-linux-arm64.tar.gz
sudo ln -sf /opt/nvim-linux-arm64/bin/nvim /usr/local/bin/nvim

curl -fLO https://github.com/tree-sitter/tree-sitter/releases/download/v0.27.0/tree-sitter-linux-arm64.gz
echo "3a35a2dd961ad842384e982c75daf792c01d1a67e442fc3914d4de37bd8a59cb  tree-sitter-linux-arm64.gz" | sha256sum -c
gunzip tree-sitter-linux-arm64.gz && sudo install -m 755 tree-sitter-linux-arm64 /usr/local/bin/tree-sitter
rm -f nvim-linux-arm64.tar.gz tree-sitter-linux-arm64
```

The first `nvim` installs the plugins from `~/.config/nvim/nvim-pack-lock.json`
and builds the treesitter parsers. Update plugins with
`:lua vim.pack.update()` and confirm with `:write`; that also updates the
lockfile, which belongs in this repo.

## Cloned with all branches?

An older setup (plain `clone --bare`, fetching `refs/heads/*`) has a local
branch and a remote-tracking branch for every machine. Keep only `pi`:

```sh
dot branch -D laptop master minimal work
dot config remote.origin.fetch '+refs/heads/pi:refs/remotes/origin/pi'
dot branch -dr origin/laptop origin/master origin/minimal origin/work
```

This only changes the local repo; the branches on GitHub stay.
