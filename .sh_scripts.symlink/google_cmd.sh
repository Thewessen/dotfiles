#!/usr/bin/env zsh

# Use ggl [...] to search all argument as a google search string
ggl() {
    if [[ $# == 0 ]]; then
        echo "Enter search string"
    else
        srch=''
        while [[ $# -gt 0 ]]; do
            srch="$srch $1"
            shift
        done
        firefox -new-tab "https://www.google.com/search?q=$srch"
    fi
}
