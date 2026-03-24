#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
KVER="${1:-$(uname -r)}"
make -C "/lib/modules/${KVER}/build" M="${ROOT}/bluetooth-module" clean modules
