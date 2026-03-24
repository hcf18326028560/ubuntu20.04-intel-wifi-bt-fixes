#!/usr/bin/env bash
set -euo pipefail
TREE="${1:?usage: apply_iwlwifi_split.sh /path/to/iwlwifi-stack-dev}"
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
while read -r patch; do
    [ -n "$patch" ] || continue
    git -C "$TREE" apply "$ROOT/patches/iwlwifi-split/$patch"
done < "$ROOT/patches/iwlwifi-split/series.txt"
