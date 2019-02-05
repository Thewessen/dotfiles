#!/usr/bin/env zsh

DOTFILES=$HOME/.dotfiles

echo -e "\\nCreating symlinks"
echo "========================"

for file in $DOTFILES/**/.*symlink; do
    target="$HOME/$(basename $file '.symlink')"
    if [ -e "$target" ]; then
        echo "~${target#$HOME} already exists... Skipping!"
    else
        ln -s "$file" "$target"
        echo "Creating symlink for $(basename "$file")"
    fi
done

echo
