#! /usr/bin/env bash

if pgrep "wf-recorder" ; then
	pkill wf-recorder
else
  now=$(date +'%d-%m_%H-%M.mp4')
  wf-recorder -a "--file=$HOME/Screencasts/auto/$now"
fi
