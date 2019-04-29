#!/usr/bin/env zsh

batt_stat_perc=`acpi -b | grep -oE '[0-9]+'%`
batt_stat_num=`echo $batt_stat_perc | grep -oE '[0-9]+'`
batt_discharging=`acpi -b | grep Dis`
batt_discharging_zerorate=`acpi -b | grep "zero rate"`
batt_icon=🔋 
low_batt_icon=🕱 
cabel_icon=🔌 

batt_stat=$batt_stat_perc


if [ "$batt_discharging" ]; then
   if ! [ "$batt_discharging_zerorate" ]; then
      if [ $batt_stat_num -lt 20 ]; then
          batt_stat="#[fg=colour1]$batt_stat$low_batt_icon#[fg=colour7]"
      else
          batt_stat="$batt_stat$batt_icon"
      fi
   else
       batt_stat="$batt_stat$cabel_icon"
   fi
else
    batt_stat="$batt_stat$cabel_icon"
fi
echo $batt_stat
