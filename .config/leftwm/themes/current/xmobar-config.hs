
-- font = "-misc-fixed-*-*-*-*-13-*-*-*-*-*-*-*"
Config { font = "xft:Open Sans:size=8:antialias=true"
    , bgColor = "#2c292d"
    , fgColor = "grey"
    , position = Top
    , lowerOnStart = True
    , allDesktops = True
    , pickBroadest = False
    , overrideRedirect = False
    , commands = [  Run MultiCpu ["-L","15","-H","50","--normal","green","--high","red"] 10
                    , Run Memory [] 10
                    , Run Swap [] 10
                    , Run TopProc [] 10
                    , Run Date "%a %b %_d %Y %H:%M:%S" "date" 10
                    , Run UnsafeStdinReader
                    , Run Com "sh" [ "-c", "wifi_status" ] "wifi" 30 
    ]
    , sepChar = "%"
    , alignSep = "}{"
    , template = "%UnsafeStdinReader% }{ %top% | %multicpu% | %memory% * %swap% | %date% | %wifi%"
}
