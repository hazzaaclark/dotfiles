#!/bin/bash
#
echo
"
#################################
#  COPYRIGHT (C) HARRY CLARK 2023
#  XMONAD AUTO WIFI SCRIPT
#################################
"

SSID="WIFI_NAME"
PASS="PASSWD"

echo 
"
###############################
#  CHECKING FOR PRE-EXISTING
#        WIFI CONFIG
###############################
"

EXISTING_CONNECTION=$(nmcli -t -f ACTIVE,SSID dev wifi list | grep '^yes:' | cut -d: -f2)

if [[ "EXISTING_CONNECTION" == "SSID" ]]; then
	echo
	"
	|||||||||||||||||||||||||||||||||||||
	| ALREADY CONNECTD TO WIFI: $SSID   |
	|||||||||||||||||||||||||||||||||||||
	"

	exit 0

fi

echo
"
###############################
#   NETWORKMANAGER RUNNING
#   	      CHECK
###############################
"

if ! systemctl is-active --quiet NetworkManager; then
	echo 
	"
	|||||||||||||||||||||||||||||||||||||||||||||||||||
	| Network Manager is not running. Initialising NM |
	|||||||||||||||||||||||||||||||||||||||||||||||||||
	"
	sudo systemctl start NetworkManager
fi

echo
"
##########################
# CONNECT TO WIFI NETWORK
##########################
"

if sudo nmcli device wifi connect "$SSID" password "$PASSWORD"; then
	echo
	"
	||||||||||||||||||||||||||||||
	| CONNECTED TO WIFI: $SSID   |
	||||||||||||||||||||||||||||||
	"

fi
