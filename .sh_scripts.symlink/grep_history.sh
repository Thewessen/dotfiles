#!/usr/bin/env zsh

# A history grep function

hg() {
    if [ $# -eq 0 ]; then
        echo "Usage hg arg1.\nArgument can also be 'regex' search pattern.\nAdd an argument!"
        return 1
    fi
    ^ history | grep -E $1

    return 0
}

