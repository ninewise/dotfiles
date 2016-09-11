#!/bin/sh

# Reading our private mac
here="$(dirname "$0")"
mac="$(cat "$here/macaddress")"

# Setting the MAC address for our wired
sudo ip link set enp5s0u1u4 down
sudo ip link set enp5s0u1u4 address "$mac"
sudo ip link set enp5s0u1u4 up
