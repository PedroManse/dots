#! /usr/bin/env bash

source "/home/manse/.shenv.bash"
source "/home/manse/dots/bash/bashrc"
_pwa_rotate_real_output_sinks
set -e
hyprctl dismissnotify
hyprctl notify -1 3000 'rgb(000000)' "Current audio sink:
\"$(_pwa_find_real_named_output)\""

