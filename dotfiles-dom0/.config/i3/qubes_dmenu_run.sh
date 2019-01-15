#!/bin/bash
## https://groups.google.com/forum/#!topic/qubes-devel/IANAOzzAuYs
color_list=""
color_list+="blue: -nb aliceblue -nf blue -sb blue -sf aliceblue\n"
color_list+="green: -nb aliceblue -nf webgreen -sb webgreen -sf aliceblue\n"
color_list+="red: -nb aliceblue -nf crimson -sb crimson -sf aliceblue\n"
color_list+="orange: -nb aliceblue -nf orangered -sb orangered -sf aliceblue\n"
color_list+="yellow: -nb black -nf yellow -sb yellow -sf black \n"
color_list+="gray: -nb black -nf aliceblue -sh aliceblue  -sf black \n"
color_list+="black: -nb aliceblue -nf black -sb black -sf aliceblue \n"
color_list+="purple: -nb aliceblue -nf blueviolet -sb blueviolet -sf aliceblue"

list="root\n"$( qvm-ls | grep -v } | grep -v ] | grep -v "\-\-" | grep -v name | awk -F'|' '{print $1}' | tr -d ' ' )
chosen=$( echo -e "$list" | dmenu )
listed_color=$( qvm-ls | grep $chosen | awk -F'|' '{print $8}' | tr -d ' ' )
color=$( echo -e "$color_list" | grep "$listed_color:" | awk -F':' '{print $2}')
#echo $listed_color
#echo "\n\n"$color
if [[ "root" = $chosen ]]
then
	menu_run; exit 0
fi
if [[ -z $( qvm-ls | grep $chosen | grep Running ) ]]
then
	echo -e "Starting VM; Please Wait" | dmenu $color; qvm-start $chosen ; exit 0
fi
cache="$HOME/.cache/dmenu_run_$chosen"
qvm-run --pass-io $chosen "dmenu_path" > $cache
cache_out=$( cat $cache )
to_run=$( echo -e "$cache_out" | dmenu $color)
qvm-run $chosen $to_run
exit 0
