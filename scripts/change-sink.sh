#! /usr/bin/env bash

if [ "$1" = "-1" ] ; then
	dif=-1
else
	dif=1
fi

sinks_str=$(pactl list sinks | filte and[ +Name -my ] | cut -d' ' -f2 )
curent_sink=$(pactl get-default-sink)
curent_sink_index="NOT DEFINED"
iter=0

sinks=()
for sink in $sinks_str
do
	sinks[$iter]=$sink
	if [ $sink = $curent_sink ] ; then
		curent_sink_index=$iter
	fi
	iter=$(($iter+1))
done

if [ $iter = 0 ]
then
	echo "No sinks found!"
else
	next_sink_index=$((($curent_sink_index+$iter+"$dif")%$iter))
	next_sink=${sinks[$next_sink_index]}
	sink_name=$(echo $next_sink | cut -d. -f4)
	pactl set-default-sink ${next_sink}
	hyprctl dismissnotify
	hyprctl notify -1 3000 'rgb(000000)' "Current audio sink:
$sink_name"
fi

