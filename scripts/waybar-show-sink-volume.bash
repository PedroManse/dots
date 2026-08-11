#! /usr/bin/env bash

set -e

gen_json() {
	text="$1"
	alt="$2"
	class="$3"
	tooltip="$4"
	echo '{ "text": "'"$text"'", "alt": "'"$alt"'", "class": "'"$class"'", "tooltip": "'"$tooltip"'" }'
}

source "/home/manse/.shenv.bash"
source "/home/manse/dots/bash/bashrc"
while true ; do
	sink=$(pwa.find_current_output)
	volume=$(pactl get-sink-volume "$sink" | head -n1 | awk ' { print $5 } ')
	icon=$(pwa.find_icon)
	gen_json "$icon $volume" "Volume of sink ${sink}: ${volume}" "volume" "Click to change sinks"
	sleep 1
done

