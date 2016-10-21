#!/bin/sh

# Reading our private mac
here="$(dirname "$0")"
mac="$(cat "$here/macaddress")"
link="$(ip link | grep enp | tr -d ' ' | cut -d: -f2)"

# Setting the MAC address for our wired
sudo ip link set "$link" down
sudo ip link set "$link" address "$mac"
sudo ip link set "$link" up
