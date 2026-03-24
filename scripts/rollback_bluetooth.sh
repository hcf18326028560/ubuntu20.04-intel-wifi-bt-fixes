#!/usr/bin/env bash
set -euo pipefail
KVER="${1:-$(uname -r)}"
MODDIR="/lib/modules/${KVER}/updates/drivers/bluetooth"
sudo rm -f "${MODDIR}/btintel.ko" "${MODDIR}/btusb.ko"
sudo depmod -a "${KVER}"
sudo modprobe -rv btusb btintel || true
sudo modprobe -v btusb || true
