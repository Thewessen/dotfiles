#!/bin/zsh

# For use of syntastic vim-plugin
# Add closurecompiler (google) manually

if [[ `uname` -eq Linux ]]; then
    #1e array of programs
    programs=("zsh" "terminator" "tmux" "vim" "npm" "git" "nodejs" "js" "rhino" "haskell-platform" "python-dev" "ctags" "ttf-mscorefonts-installer" "fonts-inconsolata")
    for com in ${programs[@]}; do
        command -v $com || sudo apt install $com
    done
    #2e array of programs
    utilities=("latex-cjk-common" "lynx" "texlive-base" "writer2latex")
    for util in ${utilities[@]}; do
        command -v $util || sudo apt install $util
    done
    # NPM
    npm=("standard" "jshint" "jsxhint" "jsl" "jslint" "eslint" "csslint")
    for npm in ${npm[@]}; do
        sudo npm -g install $n
    done
    # Change shell
    chsh -s $(command -v zsh)
    exit 0
else
    echo "Not the correct operatingsystem! Aborting..."
    exit 1
fi
