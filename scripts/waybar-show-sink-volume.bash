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
	sink=$(pwa.desktop.get_current_link)
	volume=$(pw.get_volume_by_name "$sink")
	icon=$(pwa.pretty_icon_of "$sink")
	gen_json "${icon% }$volume" "Volume of sink ${sink}: ${volume}" "volume" "Click to change sinks"
	sleep 1
done

