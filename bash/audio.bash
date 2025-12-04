#! /usr/bin/env bash

function _pwa_startup_audio {
	# create "desktop audio" for all apps
	pactl load-module module-null-sink media.class=Audio/Sink sink_name=desktop-audio-sink channel_map=stereo

	# microphone with all app's audio + real microphone's audio
	pactl load-module module-null-sink media.class=Audio/Source/Virtual sink_name=virtualmic channel_map=front-left,front-right

	# set "desktop" sink as default
	pactl set-default-sink desktop-audio-sink

	# send "desktop" audio to virt mic
	pw-link desktop-audio-sink:monitor_FL virtualmic:input_FL
	pw-link desktop-audio-sink:monitor_FR virtualmic:input_FR

	# send real mic to virt mic
	real_mic=$(pactl list sources | grep Name | grep input | awk ' { print $2 } ')
	pw-link "$real_mic:capture_FL" virtualmic:input_FL
	pw-link "$real_mic:capture_FR" virtualmic:input_FR
}

function _pwa_set_audio_real_output {
	pw-link desktop-audio-sink:monitor_FL "$1:playback_FL"
	pw-link desktop-audio-sink:monitor_FR "$1:playback_FR"
}

function _pwa_rotate_real_output_sinks {
	old_sink=$(_pwa_find_real_output)
	_pwa_remove_link_from_desktop "$old_sink"

	# don't send audio to a real audio sink
	real_sinks=$(pactl list sinks | grep 'Name: alsa_output' | awk ' { print $2 } ')
	for sink in $real_sinks ; do
		if [ ! "$sink" = "$old_sink" ] ; then
			_pwa_set_audio_real_output "$sink"
			break
		fi
	done
}

function _pwa_find_real_output {
	on_desktop_audio=""
	IFS=$'\n' links=$(pw-link -l)
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
			if [ -n "$on_desktop_audio" ] && [ -n "$is_send" ] && [[ ! "$is_send" =~ virtualmic ]] ; then
				echo "$is_send" | cut -d':' -f1
				break
			fi
		fi
	done
}

function _pwa_remove_link_from_desktop {
	pw-link -d "desktop-audio-sink:monitor_FL" "$1:playback_FL"
	pw-link -d "desktop-audio-sink:monitor_FR" "$1:playback_FR"
}

