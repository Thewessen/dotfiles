#!/bin/sh zsh

programs=("zsh" "terminator" "tmux" "vim" "npm" "git" "nodejs" "js" "rhino" "haskell-platform" "python" "ctags" "ttf-mscorefonts-installer" "fonts-inconsolata")
utilities=("lynx" "texlive-base" "writer2latex")
# For use of syntastic vim-plugin
# Add closurecompiler (google) manually
npm=("standard" "jshint" "jsxhint" "jsl" "jslint" "eslint" "csslint")

for com in ${programs[@]}; do
    command -v $com || sudo apt install $command
done

chsh -s $(command -v zsh)
