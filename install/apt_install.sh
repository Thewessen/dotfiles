#!/bin/bash

programs=("terminator" "tmux" "vim" "npm" "git" "nodejs" "js" "haskell-platform" "python" "ctags" "ttf-mscorefonts-installer" "fonts-inconsolata")

for com in ${programs[@]}; do
    command -v $com || sudo apt install $command
done
