#!/bin/zsh

programs=("zsh" "terminator" "tmux" "vim" "npm" "git" "nodejs" "js" "rhino" "haskell-platform" "python-dev" "ctags" "ttf-mscorefonts-installer" "fonts-inconsolata")
utilities=("lynx" "texlive-base" "writer2latex")
# For use of syntastic vim-plugin
# Add closurecompiler (google) manually
npm=("standard" "jshint" "jsxhint" "jsl" "jslint" "eslint" "csslint")

for com in ${programs[@]}; do
    command -v $com || sudo apt install $com
done

for util in ${utilities[@]}; do
    command -v $util || sudo apt install $util
done

for npm in ${npm[@]}; do
    sudo npm install $n
done

chsh -s $(command -v zsh)
