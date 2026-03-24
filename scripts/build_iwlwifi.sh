#!/usr/bin/env bash
set -euo pipefail
TREE="${1:?usage: build_iwlwifi.sh /path/to/iwlwifi-stack-dev}"
make -C "${TREE}" -j"$(nproc)" M=drivers/net/wireless/intel/iwlwifi modules
