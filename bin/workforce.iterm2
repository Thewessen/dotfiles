#!/usr/bin/osascript

local cmd
set cmd to "mono && cd apps/workforce && vssh php artisan queue:refinancingworker-comparison -vvv"

tell application "iTerm"
    tell current window
        -- create a tab for background db stuff
        create tab with default profile
        tell current session
            write text cmd
            write text "n"
            -- split tab horizontally to run scheduler
            split horizontally with default profile
        end tell
        tell last session of last tab
            write text cmd
            write text "n"
            -- split tab horizontally to run scheduler
            split horizontally with default profile
        end tell
        tell last session of last tab
            write text cmd
            write text "n"
            -- split tab horizontally to run scheduler
            split horizontally with default profile
        end tell
        tell last session of last tab
            write text cmd
            write text "n"
            -- split tab horizontally to run scheduler
            split horizontally with default profile
        end tell
        tell last session of last tab
            write text cmd
            write text "n"
            -- split tab horizontally to run scheduler
            split horizontally with default profile
        end tell
        tell last session of last tab
            write text cmd
            write text "n"
        end tell
    end tell
end tell
