#!/usr/bin/env bash
set -euo pipefail
TREE="${1:?usage: install_iwlwifi.sh /path/to/iwlwifi-stack-dev}"
sudo make -C "${TREE}" install
sudo modprobe -rv iwlmvm iwlwifi || true
sudo modprobe -v iwlwifi
