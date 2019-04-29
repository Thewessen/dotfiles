#!/usr/bin/env zsh

volume_lvl_perc=`amixer get Master | awk -F'[][]' '{ print $2 }' | tail -n 1`
volume_lvl_perc_number=`echo $volume_lvl_perc | head -c 2`
volume_mixer=`amixer get Master | awk -F'[][]' '{ print $6 }' | tail -n 1`

result=$volume_lvl_perc
if [ "$volume_mixer" -eq "off" ]; then
    result+=🔇
elif [ "$volume_lvl_perc" -eq "100%" ] || [ $volume_lvl_perc_number -gt 75 ]; then
    result+=🔊
elif [ $volume_lvl_perc_number -gt 10 ]; then
    result+=🔉
else
    result+=🔈
fi

echo $result
