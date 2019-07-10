#!/usr/bin/zsh

level=$(cat /sys/class/power_supply/BAT0/capacity)
charging=$(cat /sys/class/power_supply/BAT0/status)
symbol="🔋"

case $level in
[0-9])
    level="<span color='red'>$level</span>"
    ;;
1[0-9])
    level="<span color='red'>$level</span>"
    ;;
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
    level="$level%"
    ;;
esac

if [[ "$charging" = "Charging" ]]; then
    symbol="🔌"
fi

echo "$level$symbol"
