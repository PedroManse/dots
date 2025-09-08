#! /usr/bin/env bash

status=$(systemctl is-active openvpn-office.service)
vpn_name="Office"

gen_json() {
	text="$1"
	alt="$2"
	class="$3"
	tooltip="$4"
	echo '{ "text": "'"$text"'", "alt": "'"$alt"'", "class": "'"$class"'", "tooltip": "'"$tooltip"'" }'
}

gather() {
	if [ "$status" = "active" ] ; then
		gen_json "󰖂  Office" "$vpn_name VPN Active" "" "$vpn_name VPN"
	else
		gen_json "󰖂  inactive" "$vpn_name VPN Inactive" "" "$vpn_name VPN"
	fi
}

if [[ "$1" == "--details" ]]; then
	systemctl status openvpn-office.service
else
	gather
fi

