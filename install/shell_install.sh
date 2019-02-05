#!/usr/bin/env zsh

# This script requires root priveledge
if command -v sudo >/dev/null 2>&1; then
    sudo
elif command -v su >/dev/null 2>&1; then
    su
else
    echo "This script requires root priveledge!\n Not able to get it with sudo or su (make sure theese are installed).\n Aborting!"
    exit 1
fi

# Changing the default shell font
if [ -f /etc/default/console-setup ]; then
    # Change shell font configurations
    sed -i 's/\(FONTFACE=\).*/\1"VGA"/g' /etc/default/console-setup
    sed -i 's/\(FONTSIZE=\).*/\1"12x24"/g' /etc/default/console-setup
    # Read font configurations
    setupcon -f
else
    echo "Can't find /etc/default/console-setup. Shell default font not set!"
fi

if [ -f /etc/default/keyboard ]; then
    # Change shell keyboard configurations
    sed -i 's/\(XKBLAYOUT=\).*/\1"us"/g' /etc/default/keyboard
    sed -i 's/\(XKBVARIANT=\).*/\1"dvorak"/g' /etc/default/keyboard
else
    echo "Can't find /etc/default/keyboard. Shell default keyboard configurations not set!"
fi

exit 0
