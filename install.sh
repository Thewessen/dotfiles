#!/bin/bash

if [ $( uname ) -ne 'Linux' ]; then
    echo "Your current OS is not supported.\nThis script is made for Linux and not tested on other OS.\n Run every script in ./install individualy and check for errors. \n Aborting..."
    exit 1
else
    # Create symlinks before installing (so config files are already in place)
    source install/symlink.sh

    # Install most wanted programs (root passw needed)
    source install/apt_install.sh

    # Install vim-plugins
    vim +PluginInstall +qall
fi

exit 0
