#!/usr/bin/env sh

# from https://gist.github.com/othiym23/4ac31155da23962afd0e
# a safe way to upgrade all of your globally-installed npm packages

set -e
set -x

for package in $(npm -g outdated --parseable --depth=0 | cut -d: -f2)
do
    npm -g install "$package"
done
