#!/usr/bin/env bash
set -euo pipefail
lsusb -t || true
hciconfig -a || true
bluetoothctl show || true
journalctl -k -b | grep -iE "btusb|btintel|Bluetooth|hci0|firmware|ddc" | tail -n 80 || true
