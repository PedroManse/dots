#! /usr/bin/env bash

source "/home/manse/.shenv.bash"
source "/home/manse/dots/bash/bashrc"
sink=$(pwa.desktop.rotate_current_link "$1")
set -e
hyprctl dismissnotify
hyprctl notify -1 3000 'rgb(000000)' "Current audio sink:
\"$(pwa.pretty_name_of "$sink")\""

