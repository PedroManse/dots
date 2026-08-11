#! /usr/bin/env bash

function pwa.startup_audio {
	# "desktop audio" for all programs to send audio to
	pactl load-module module-null-sink media.class=Audio/Sink sink_name=desktop-audio-sink channel_map=stereo

	# Real microphone's audio
	pactl load-module module-null-sink media.class=Audio/Source/Virtual sink_name=realmic channel_map=stereo

	# Real Microphone + "desktop audio"
	pactl load-module module-null-sink media.class=Audio/Source/Virtual sink_name=record-audio-sink channel_map=stereo

	# set "desktop audio" as system's default sink
	pactl set-default-sink desktop-audio-sink

	# set "real mic" as system's default source
	pactl set-default-source realmic

	# send "desktop" audio to "record sink"
	pw-link desktop-audio-sink:monitor_FL record-audio-sink:input_FL
	pw-link desktop-audio-sink:monitor_FR record-audio-sink:input_FR

	# send "real mic" to "record sink"
	real_mic=$(pactl list sources short | grep input | grep analog | awk ' { print $2 } ')
	pw-link "$real_mic:capture_FL" realmic:input_FL
	pw-link "$real_mic:capture_FR" realmic:input_FR
	pw-link "realmic:capture_FL" record-audio-sink:input_FL
	pw-link "realmic:capture_FR" record-audio-sink:input_FR
}

function pwa.link_real_mic {
	#pw-link desktop-audio-sink:monitor_FL record-audio-sink:input_FL
	#pw-link desktop-audio-sink:monitor_FR record-audio-sink:input_FR
	real_mic=$(pactl list sources short | grep input | grep analog | awk ' { print $2 } ')
	pw-link "$real_mic:capture_FL" realmic:input_FL
	pw-link "$real_mic:capture_FR" realmic:input_FR
	#pw-link "realmic:capture_FL" record-audio-sink:input_FL
	#pw-link "realmic:capture_FR" record-audio-sink:input_FR
}

function pwa.stop_audio {
	pactl unload-module module-null-sink
}

function pwa.set_audio_real_output {
	pw-link desktop-audio-sink:monitor_FL "$1:playback_FL"
	pw-link desktop-audio-sink:monitor_FR "$1:playback_FR"
}

function pwa.find_real_outputs {
	pactl list sinks short | filte -"desktop-audio-sink" | awk ' { print $2 } '
}

function pwa.rotate_real_output_sinks {
	old_sink=$(pwa.find_current_output)
	# don't send audio to a desktop-audio-sink
	if [ "$1" = "prev" ] ; then
		real_sinks=$(pwa.find_real_outputs | tac)
	else
		real_sinks=$(pwa.find_real_outputs)
	fi
	# _cyclic_find_next_item from ./bashrc
	new_sink=$( _cyclic_find_next_item "$old_sink" "$real_sinks"  )

	pwa.set_audio_real_output "$new_sink"
	if [ -n "$old_sink" ] ; then
		pwa.remove_link_from_desktop "$old_sink"
	fi
}

function pwa.find_current_output {
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


function pwa.remove_link_from_desktop {
	pw-link -d "desktop-audio-sink:monitor_FL" "$1:playback_FL"
	pw-link -d "desktop-audio-sink:monitor_FR" "$1:playback_FR"
}

function pwa.find_real_named_output {
	local names="
alsa_output.pci-0000_0d_00.4.analog-stereo headphone
alsa_output.pci-0000_0b_00.1.hdmi-stereo-extra3 alto-falante
bluez_output.E8_EE_CC_6F_35_FE.1 bluetooth-headphone
	"

	sink=$(pwa.find_current_output)
	sink_name=$(convert "$names" "$sink" "optional")
	if [ -z "$sink_name" ] ; then
		echo "$1"
	else
		echo "$sink_name"
	fi
}

function pwa.find_icon {
	local names="
alsa_output.pci-0000_0d_00.4.analog-stereo 
alsa_output.pci-0000_0b_00.1.hdmi-stereo-extra3 󰓃
bluez_output.E8_EE_CC_6F_35_FE.1 
"

	sink=$(pwa.find_current_output)
	sink_name=$(convert "$names" "$sink" "optional")
	if [ -z "$sink_name" ] ; then
		echo "$1"
	else
		echo "$sink_name"
	fi
}

function pwa.get_current_audio {
	sink=$(pwa.find_current_output)
	pactl get-sink-volume "$sink" | head -n1 | awk ' { print $5 } '
}
