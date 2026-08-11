#! /usr/bin/env bash

source "/home/manse/.shenv.bash"
source "/home/manse/dots/bash/bashrc"
found_knob_kb=$(lsusb | grep "c0f4:0201")

set -e
if [ -z "$found_knob_kb" ] ; then
  volume_diff=$1
else
  volume_diff=$2
fi

sink=$(pwa.find_real_output)
pactl set-sink-volume "$sink" "$volume_diff"
volume=$(pactl get-sink-volume "$sink" | awk '{print $5}')
hyprctl dismissnotify
hyprctl notify -1 1500 'rgb(000000)' "Current volume: $volume"
