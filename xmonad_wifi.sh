#!/bin/bash

# Set your Wi-Fi SSID and password
SSID="WIFI_NAME"
PASS="PASSWD"

cat <<EOF
#################################
#  COPYRIGHT (C) HARRY CLARK 2023
#  XMONAD AUTO WIFI SCRIPT
#################################

###############################
#  CHECKING FOR PRE-EXISTING
#        WIFI CONFIG
###############################

EOF

EXISTING_CONNECTION=$(nmcli -t -f ACTIVE,SSID dev wifi list | grep '^yes:' | cut -d: -f2)

if [[ "$EXISTING_CONNECTION" == "$SSID" ]]; then
	cat <<EOF
	|||||||||||||||||||||||||||||||||||||
	| ALREADY CONNECTED TO WIFI: $SSID   |
	|||||||||||||||||||||||||||||||||||||
	EOF

	exit 0
fi

cat <<EOF
###############################
#   NETWORKMANAGER RUNNING
#          CHECK
###############################

EOF

if ! systemctl is-active --quiet NetworkManager; then
	cat <<EOF
	|||||||||||||||||||||||||||||||||||||||||||||||||||
	| Network Manager is not running. Initializing NM |
	|||||||||||||||||||||||||||||||||||||||||||||||||||
	EOF
	sudo systemctl start NetworkManager
fi

cat <<EOF
##########################
# CONNECT TO WIFI NETWORK
##########################

EOF

if sudo nmcli device wifi connect "$SSID" password "$PASS"; then
	cat <<EOF
	||||||||||||||||||||||||||||||
	| CONNECTED TO WIFI: $SSID   |
	||||||||||||||||||||||||||||||
	EOF
fi
