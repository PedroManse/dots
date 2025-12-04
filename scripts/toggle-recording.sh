#! /usr/bin/env bash

if ! pkill -2 wf-recorder ; then
  now=$(date +'%d-%m_%H-%M.mp4')
  wf-recorder "--audio=virtualmic" "--file=$HOME/Screencasts/auto/$now"
fi
