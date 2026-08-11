#! /usr/bin/env bash

source "/home/manse/.shenv.bash"
source "/home/manse/dots/bash/bashrc"
pwa.rotate_real_output_sinks "$1"
set -e
hyprctl dismissnotify
hyprctl notify -1 3000 'rgb(000000)' "Current audio sink:
\"$(pwa.find_real_named_output)\""

