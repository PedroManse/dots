#! /usr/bin/env bash

format_rec_time() {
	printf '%d:%02d' $(( "$1" / 60 )) $(( "$1" % 60 ))
}

if ! pkill -2 wf-recorder ; then
	source "/home/manse/.shenv.bash"
	source "/home/manse/dots/bash/bashrc"
	pwa.mic.autofix
	now=$(date +'%d-%m_%H:%M.mp4')
	now_unix=$(date +'%s')
	wf-recorder "--audio=record-audio-sink" "--file=$HOME/Screencasts/auto/$now"
	end_unix=$(date +'%s')
	diff_unix=$(( end_unix - now_unix ))
	diff=$(format_rec_time $diff_unix)
	hyprctl dismissnotify
	hyprctl notify -1 3000 'rgb(000000)' "$diff @ ~/Screencasts/auto/$now"
fi
