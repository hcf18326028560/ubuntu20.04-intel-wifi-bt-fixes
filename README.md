# Ubuntu 20.04 Intel Wi-Fi / Bluetooth Fixes

Fixes and backports for Intel Wi-Fi and Bluetooth on Ubuntu 20.04 with Linux 5.15, validated on a machine with an NVIDIA RTX 5070 Ti, Intel Wi-Fi `8086:272b`, and Intel Bluetooth `8087:0036`.

## What Is Included

- `patches/iwlwifi-bz-glfm-5.15.patch`
  Raw patch exported from the local `iwlwifi-stack-dev` backport tree after the working Wi-Fi bring-up.
- `patches/bluetooth-btusb-8087-0036.patch`
  Linux 5.15 `btusb.c` delta for Intel `8087:0036`.
- `patches/bluetooth-btintel-gale-peak.patch`
  Linux 5.15 `btintel.c` delta for newer Intel TLV hardware variants including `0x1c`.
- `bluetooth-module/`
  Small reproducible external-module workspace for `btusb` / `btintel`.
- `scripts/`
  Build, install, rollback, and verification helpers.
- `docs/`
  Diffstat and short notes.

## Wi-Fi Fix Summary

The Wi-Fi fix set was applied in a local Intel backport tree:

`/home/hcf/YXYL-SLAM-02-12/tmp-backport-iwlwifi/iwlwifi-stack-dev`

Main areas that changed:

- Embedded PNVM plumbing for GL/BZ-era firmware.
- New-station / MLD path fixes so `ADD_STA` uses the correct API path.
- `PHY_CONTEXT_CMD v6` support and newer scan structure support.
- RLC / MAC / LINK / connect-path compatibility fixes.
- `MCC_UPDATE v8` regulatory parsing so scan results and channel exposure recover.
- Temporary TX checksum-offload fallback on GL/BZ to avoid TCP stalls.

The exact tracked diff is exported as `patches/iwlwifi-bz-glfm-5.15.patch`.

## Bluetooth Fix Summary

The Bluetooth fix is packaged as a tiny external module workspace based on Linux `v5.15` driver sources.

Main changes:

- Add explicit Intel `8087:0036` matching in `btusb.c`.
- Move that match ahead of generic Bluetooth interface matches so the Intel path actually wins.
- Extend `btintel.c` TLV-era hardware variant support to include `0x1b`, `0x1c`, `0x1d`, `0x1e`, `0x1f`, and `0x22`.
- Keep the external build Intel-focused by dropping unrelated BCM / RTL / MTK helper paths from this standalone module build.

On the target Ubuntu 20.04 + 5.15 machine, the end result was:

- `btusb` bound to USB device `8087:0036`
- `hci0` appeared and stayed `UP RUNNING`
- `bluetoothctl show` returned a valid default controller

One non-fatal message may remain:

- `Failed to load Intel DDC file intel/ibt-0291-0291.ddc (-2)`

That did not prevent the controller from coming up on the validated machine.

## Quick Start

### Wi-Fi

1. Apply the patch to your own `iwlwifi-stack-dev` tree.
2. Run `scripts/build_iwlwifi.sh /path/to/iwlwifi-stack-dev`
3. Run `scripts/install_iwlwifi.sh /path/to/iwlwifi-stack-dev`
4. Run `scripts/verify_iwlwifi.sh`

### Bluetooth

1. Run `scripts/build_bluetooth.sh`
2. Run `scripts/install_bluetooth.sh`
3. Run `scripts/verify_bluetooth.sh`
4. If needed, run `scripts/rollback_bluetooth.sh`

## Notes

- The Bluetooth module workspace is intentionally narrow and tuned for this Intel controller family.
- The Wi-Fi patch is exported from a working local tree and is not yet split into upstream-quality logical commits.
- This repository is meant to preserve a reproducible working state first.
