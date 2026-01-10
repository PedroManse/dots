#! /usr/bin/env bash

if ! pkill -2 wf-recorder ; then
	source "/home/manse/.shenv.bash"
	source "/home/manse/dots/bash/bashrc"
	_pwa_fix_outputs
	now=$(date +'%d-%m_%H:%M.mp4')
	wf-recorder "--audio=virtualmic" "--file=$HOME/Screencasts/auto/$now"
fi
