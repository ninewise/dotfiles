#!/bin/sh

# Reading our private mac
here="$(dirname "$0")"
mac="${1:-$(cat "$here/macaddress")}"
enp="$(basename /sys/class/net/enp*)"
wlp="$(basename /sys/class/net/wlp*)"

# Setting the MAC address for our wired
sudo ip link set "$enp" down
sudo ip link set "$enp" address "$mac"
sudo ip link set "$enp" up

# No more wireless
if [ -e /var/service/iwd ]; then
	sudo sv stop /var/service/iwd
	sudo ip link set "$wlp" down
fi

# Restart tor on network change
sudo sv restart tor

