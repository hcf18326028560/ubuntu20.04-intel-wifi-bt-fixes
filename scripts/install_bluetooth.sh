#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
KVER="${1:-$(uname -r)}"
MODDIR="/lib/modules/${KVER}/updates/drivers/bluetooth"
sudo install -d "${MODDIR}"
sudo install -m 0644 "${ROOT}/bluetooth-module/btintel.ko" "${MODDIR}/btintel.ko"
sudo install -m 0644 "${ROOT}/bluetooth-module/btusb.ko" "${MODDIR}/btusb.ko"
sudo depmod -a "${KVER}"
sudo modprobe -rv btusb btintel || true
sudo modprobe -v btusb
