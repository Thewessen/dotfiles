
-- font = "-misc-fixed-*-*-*-*-13-*-*-*-*-*-*-*"
Config { font = "xft:Open Sans:size=8:antialias=true"
    , bgColor = "#2c292d"
    , fgColor = "grey"
    , position = Top
    , lowerOnStart = True
    , allDesktops = True
    , pickBroadest = False
    , overrideRedirect = False
    , commands = [  Run Date "%_d %b %H:%M" "date" 10
                    , Run UnsafeStdinReader
                    , Run Com "/bin/zsh" [ "-c", "/home/sthewessen/bin/wifi_status" ] "wifi" 30 
    ]
    , sepChar = "%"
    , alignSep = "}{"
    , template = "%UnsafeStdinReader% }{ %date% | %wifi%"
}
