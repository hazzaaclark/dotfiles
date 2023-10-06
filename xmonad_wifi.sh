#!/bin/bash

#################################
#  COPYRIGHT (C) HARRY CLARK 2023
#  XMONAD AUTO WIFI SCRIPT
#################################

# Set your Wi-Fi SSID and password
SSID="WIFI_NAME"
PASS="PASSWD"

echo "#################################"
echo "#  COPYRIGHT (C) HARRY CLARK 2023"
echo "#  XMONAD AUTO WIFI SCRIPT"
echo "#################################"
echo

echo "###############################"
echo "#  CHECKING FOR PRE-EXISTING"
echo "#        WIFI CONFIG"
echo "###############################"
echo

EXISTING_CONNECTION=$(nmcli -t -f ACTIVE,SSID dev wifi list | grep '^yes:' | cut -d: -f2)

if [[ "$EXISTING_CONNECTION" == "$SSID" ]]; then
	echo "|||||||||||||||||||||||||||||||||||||"
	echo "| ALREADY CONNECTED TO WIFI: $SSID   |"
	echo "|||||||||||||||||||||||||||||||||||||"

	exit 0
fi

echo "###############################"
echo "#   NETWORKMANAGER RUNNING"
echo "#          CHECK"
echo "###############################"
echo

if ! systemctl is-active --quiet NetworkManager; then
	echo "|||||||||||||||||||||||||||||||||||||||||||||||||||"
	echo "| Network Manager is not running. Initializing NM |"
	echo "|||||||||||||||||||||||||||||||||||||||||||||||||||"
	sudo systemctl start NetworkManager
fi

echo "##########################"
echo "# CONNECT TO WIFI NETWORK"
echo "##########################"
echo

if sudo nmcli device wifi connect "$SSID" password "$PASS"; then
	echo "||||||||||||||||||||||||||||||"
	echo "| CONNECTED TO WIFI: $SSID   |"
	echo "||||||||||||||||||||||||||||||"
fi
