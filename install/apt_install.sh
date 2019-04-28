#!/bin/zsh

# For use of syntastic vim-plugin
# Add closurecompiler (google) manually

if [[ -z $(command -v zsh) ]]; then
  echo "ZSH should be installed first!! Aborting!"
elif [[ `uname` -eq Linux ]]; then
    #1e array of programs
    programs=("sshpass" "nmap" "xclip" "cmake" "terminator" "tmux" "vim" "npm" "git" "nodejs" "js" "rhino" "haskell-platform" "python3" "python3-dev" "python3.6-dev" "python-dev" "ctags" "ttf-mscorefonts-installer" "fonts-inconsolata")
    for com in ${programs[@]}; do
        echo "Installing $com..."
        command -v $com || sudo apt install $com
    done
    #2e array of programs
    utilities=("latex-cjk-common" "lynx" "texlive-base" "writer2latex")
    for util in ${utilities[@]}; do
        echo "Installing $util..."
        command -v $util || sudo apt install $util
    done
    # NPM
    npm=("live-server" "standard" "jshint" "jsxhint" "jsl" "jslint" "eslint" "csslint")
    for npm in ${npm[@]}; do
        sudo npm -g install $n
    done
    exit 0
else
    echo "Not the correct operatingsystem! Aborting..."
    exit 1
fi
