#!/usr/bin/zsh

level=$(cat /sys/class/power_supply/BAT0/capacity)
charging=$(cat /sys/class/power_supply/BAT0/status)
# symbol="🔋"
symbol=" bat"
green="#a9dc76"
red="#ff6188"

if [[ "$charging" = "Charging" ]]; then
    # symbol="🔌"
    symbol=" chr"
fi

case $level in
[0-9])
    result="<span background='$red'><b> $level%$symbol </b></span>"
    ;;
# 1[0-9])
#     result="<span background='red'><b> $level%$symbol</b></span>"
#     ;;
# # [2-3][0-9])
# #     symbol=""
# #     ;;
# # [4-5][0-9])
# #     symbol=""
# #     ;;
# # [6-7][0-9])
# #     symbol=""
# #     ;;
# [8-9][0-9])
#     level="<span color='red'>$level%</span>"
#     ;;
# 100)
#     level="<span color='red'>$level%</span>"
#     ;;
*)
    result="<span background='$green'> $level%$symbol </span>"
    ;;
esac

echo "$result"
