#! /usr/bin/env bash

source "/home/manse/dots/bash/bashrc"
set -ex
sink=$(_pwa_find_real_output)
pactl set-sink-volume "$sink" "$@"
volume=$(pactl get-sink-volume "$sink" | awk '{print $5}')
hyprctl dismissnotify 
hyprctl notify -1 3000 'rgb(000000)' "Current sink volume: $volume"
