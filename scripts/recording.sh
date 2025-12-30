#! /usr/bin/env bash

set -e

gen_json() {
	text="$1"
	alt="$2"
	class="$3"
	tooltip="$4"
	echo '{ "text": "'"$text"'", "alt": "'"$alt"'", "class": "'"$class"'", "tooltip": "'"$tooltip"'" }'
}

format_rec_time() {
	printf '%d:%02d' $(( "$1" / 60 )) $(( "$1" % 60 ))
}

rec_time=0
red=0
while : ; do
	red=$(( ! "$red" ))
	if pgrep "wf-recorder" > /dev/null ; then
		rec_time=$(( "$rec_time" + 1 ))
		rec_str=$(format_rec_time $rec_time)
		if [ $red = 0 ] ; then
			gen_json "$rec_str" "Recording" "rec-red" "Click to stop recording"
		else
			gen_json "$rec_str" "Recording" "rec-white" "Click to stop recording"
		fi
	else
		rec_time=0
		gen_json " " "Not Recording" "" "Click to start recording"
	fi
	sleep 1
done
