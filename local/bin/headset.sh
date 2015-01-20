#!/bin/bash
cat <(echo "connect 00:11:67:11:18:9B") <(echo "quit") | bluetoothctl

