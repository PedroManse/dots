#! /usr/bin/env bash
# to be ran as root

status=$(systemctl is-active openvpn-office.service)
if [ "$status" = "active" ] ; then
  systemctl stop openvpn-office.service
else
  systemctl start openvpn-office.service
fi
