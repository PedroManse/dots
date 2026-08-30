#! /usr/bin/env bash

# (analog mic) -> "mic" -> "record-audio-sink" <- "desktop-audio-sink" <- (all programs)

# PipeWireAction

function pwa.start {
	# Create PWA :: Desktop
	pactl load-module module-null-sink media.class=Audio/Sink sink_name=desktop-audio-sink channel_map=stereo

	# Create PWA :: Mic
	pactl load-module module-null-sink media.class=Audio/Source/Virtual sink_name=mic channel_map=stereo

	# Create PWA :: Record
	pactl load-module module-null-sink media.class=Audio/Source/Virtual sink_name=record-audio-sink channel_map=stereo

	# set Desktop Audio as system's default sink
	pactl set-default-sink desktop-audio-sink

	# set Mic as system's default source
	pactl set-default-source mic

	# send Desktop Audio and Mic audio to "record sink"
	pw-link "desktop-audio-sink" "record-audio-sink"
	pw-link "mic" "record-audio-sink"

	# try link analog mic -> Mic
	pwa.mic.autofix

	mkdir -p "/tmp/pwa"
	pwa.awake change-volume change-sink
}

# wait for any changes on files in /tmp/pwa (needs zawait)
function pwa.await {
	# shellcheck disable=2046
	zawait $(for f in "$@" ; do
		echo -n "/tmp/pwa/$f "
	done)
}

# use zawake to alert files watched by zawait
function pwa.awake {
	# shellcheck disable=2046
	zawake $(for f in "$@" ; do
		echo -n "/tmp/pwa/$f "
	done)
}

function pwa.stop { pactl unload-module module-null-sink ; }

# PWA :: Mic

function pwa.mic.link { pw-link "$1" mic ; }
function pwa.mic.unlink { pw-link -d "$1" mic ; }
function pwa.mic.autofix {
	pwa.mic.link "$(pw.find_analog_input)"
}

# PWA :: Desktop

function pwa.desktop.unlink { pw-link -d "desktop-audio-sink" "$1" ; }
function pwa.desktop.link { pw-link "desktop-audio-sink" "$1" ; }

# Get all possible hardware outputs
function pwa.desktop.find_possible_links {
	pactl list sinks short | filte -"desktop-audio-sink" | awk ' { print $2 } '
}

# Get current hardware output
function pwa.desktop.get_current_link {
	on_desktop_audio=""
	IFS=$'\n' links=$(pw-link -l '' 'desktop-audio-sink')
	for link in $links ; do
		header=$(echo "$link" | filte 'i^ ')
		is_send=$(echo "$link" | filte '^  |->' | awk ' { print $2 } ')

		if [ -n "$header" ] ; then
			: # on header
			if [[ "$link" =~ "desktop-audio-sink" ]] ; then
				: # on desktop audio header
				on_desktop_audio=$link
			else
				on_desktop_audio=""
			fi
		else
			if
				[ -n "$on_desktop_audio" ] &&
				[ -n "$is_send" ] &&
				[[ ! "$is_send" =~ record-audio-sink ]] &&
				[[ ! "$is_send" =~ Pulse ]] ;
			then
				echo "$is_send" | cut -d':' -f1
				break
			fi
		fi
	done
}

# Use next hardware output (wraps)
# If $1 is "prev" use previous hardware output instead of next
function pwa.desktop.rotate_current_link {
	old_sink=$(pwa.desktop.get_current_link)
	if [ "$1" = "prev" ] ; then
		real_sinks=$(pwa.desktop.find_possible_links | tac)
	else
		real_sinks=$(pwa.desktop.find_possible_links)
	fi

	# cyclic_find_next_item from ./utils.bash
	new_sink=$( cyclic_find_next_item "$old_sink" "$real_sinks"  )

	pwa.desktop.link "$new_sink"
	if [ -n "$old_sink" ] ; then
		pwa.desktop.unlink "$old_sink"
	fi

	echo "$new_sink"
}

# $1 device name
# $2 default name
function pwa.pretty_name_of {
	local names="
alsa_output.pci-0000_0d_00.4.analog-stereo      headphone
alsa_output.pci-0000_0b_00.1.hdmi-stereo-extra3 alto-falante
bluez_output.E8_EE_CC_6F_35_FE.1                bluetooth-headphone
"

	sink_name=$(convert "$names" "$1" "optional")
	echo "${sink_name:-$2}"
}

# $1 device name
# $2 default icon
function pwa.pretty_icon_of {
	local names="
alsa_output.pci-0000_0d_00.4.analog-stereo      
alsa_output.pci-0000_0b_00.1.hdmi-stereo-extra3 󰓃
bluez_output.E8_EE_CC_6F_35_FE.1                
"

	sink_icon=$(convert "$names" "$1" "optional")
	echo "${sink_icon:-$2}"
}

# Generic PipeWire functions

function pw.get_volume_by_name {
	pactl get-sink-volume "$1" | cut -w -f5 | head -n1
}

function pw.find_analog_input {
	pactl list sources short | grep input | grep analog | awk ' { print $2 } '
}
