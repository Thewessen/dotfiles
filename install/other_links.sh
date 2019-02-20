# Some other files that can be helpfull setting up.
# If put in the right place...

# Firefox dev-tool/console fontsize and fontface change.
if [ -d ~/.mozilla/firefox/*.default/chrome ]; then
    echo "~/.mozilla/firefox/*.default/chrome already excists..."
else
    mkdir -vp ~/.mozilla/firefox/*.default/chrome
fi
if [ -f ~/.mozilla/firefox/*.default/chrome/userChrome.css ]; then
    echo "userChrome.css already excists in your Firefox profile, Aborting..."
    echo "Check ~/.mozilla/firefox/*.default/userChrome.css manually!"
    return 1
else
    cp -n ../userChrome.css $_
    echo "Restart firefox and enjoy your devtool fonts(size)."
    return 0
fi
