#!/usr/bin/env bash
set -euo pipefail
IFACE="${1:-wlp130s0f0}"
iw dev || true
nmcli device status || true
nmcli device wifi list ifname "${IFACE}" || true
journalctl -k -b | grep -iE "iwlwifi|iwlmvm|Microcode SW error|FW error|INIT_COMPLETE|PNVM|SCAN_REQ_UMAC|MCC" | tail -n 120 || true
