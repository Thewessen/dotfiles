#!/bin/bash

DOTFILES=$HOME/.dotfiles

echo -e "\\nCreating symlinks"
echo "========================"

symlinks=$(find -H "$DOTFILES" -maxdepth 3 -name '*.symlink')

for file in $symlinks; do
    target="$HOME/$(basename $file '.symlink')"
    if [ -e "$target" ]; then
        echo "~${target#$HOME} already exists... Skipping!"
    else
        ln -s "$file" "$target"
        echo "Creating symlink for $(basename "$file")"
    fi
done

echo

# Special case vim color
# mkdir -p $HOME/.vim/colors
# ln -s $DOTFILES/vim/sthew.vim $HOME/.vim/colors/sthew.vim
