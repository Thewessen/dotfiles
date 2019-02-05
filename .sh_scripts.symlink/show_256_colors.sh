#!/usr/bin/env zsh

# =================================
#  Show all 256 colors in stdout
# =================================

colors256() {
    for i in {0..255}; do 
        printf "\x1b[38;5;${i}mcolour${i}\x1b[0m\n"; 
    done
}

