#!/bin/sh

# Reading our private mac
here="$(dirname "$0")"
mac="$(cat "$here/macaddress")"
link="$(basename /sys/class/net/enp*)"

# Setting the MAC address for our wired
sudo ip link set "$link" down
sudo ip link set "$link" address "$mac"
sudo ip link set "$link" up

# No more wireless
sudo sv stop wpa_supplicant

