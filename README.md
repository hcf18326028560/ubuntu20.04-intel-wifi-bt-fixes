# Ubuntu 20.04 Intel Wi-Fi / Bluetooth Fixes

Fixes and backports for Intel Wi-Fi and Bluetooth on Ubuntu 20.04 with Linux 5.15, validated on a machine with an NVIDIA RTX 5070 Ti, Intel Wi-Fi `8086:272b`, and Intel Bluetooth `8087:0036`.

## Validated Target

- OS: Ubuntu 20.04
- Kernel: `5.15.0-139-generic`
- GPU: NVIDIA RTX 5070 Ti
- Wi-Fi PCI ID: `8086:272b`
- Bluetooth USB ID: `8087:0036`

## Repository Layout

- `patches/iwlwifi-bz-glfm-5.15.patch`
  Full raw Wi-Fi patch exported from the working local `iwlwifi-stack-dev` tree.
- `patches/iwlwifi-split/`
  Same Wi-Fi fix set split into smaller reviewable groups.
- `patches/bluetooth-btusb-8087-0036.patch`
  Linux 5.15 `btusb.c` delta for Intel `8087:0036`.
- `patches/bluetooth-btintel-gale-peak.patch`
  Linux 5.15 `btintel.c` delta for newer Intel TLV-era hardware variants.
- `bluetooth-module/`
  Small external-module workspace for `btusb` / `btintel`.
- `scripts/`
  Build, install, rollback, apply, and verification helpers.
- `docs/`
  Platform notes, FAQ, diffstat, and split-patch summary.

## Wi-Fi Summary

The Wi-Fi fix set was developed in this local Intel backport tree:

`/home/hcf/YXYL-SLAM-02-12/tmp-backport-iwlwifi/iwlwifi-stack-dev`

Main fix buckets:

- Embedded PNVM plumbing for GL/BZ-era firmware.
- New-station / MLD startup fixes so `ADD_STA` uses the correct API path.
- `PHY_CONTEXT_CMD v6` and newer scan structure support.
- Connect-path compatibility fixes for RLC / MAC / LINK handling.
- `MCC_UPDATE v8` regulatory parsing so scan results and channel exposure recover.
- Temporary TX checksum-offload fallback on GL/BZ to avoid TCP stalls.

## Bluetooth Summary

The Bluetooth fix is packaged as a tiny external module workspace based on Linux `v5.15` driver sources.

Main changes:

- Add explicit Intel `8087:0036` matching in `btusb.c`.
- Move that match ahead of generic Bluetooth interface matches so the Intel path actually wins.
- Extend `btintel.c` TLV-era hardware variant support to include `0x1b`, `0x1c`, `0x1d`, `0x1e`, `0x1f`, and `0x22`.
- Keep the external build Intel-focused by dropping unrelated BCM / RTL / MTK helper paths from this standalone module build.

Observed final working state on the validated machine:

- `btusb` bound to USB device `8087:0036`
- `hci0` appeared and stayed `UP RUNNING`
- `bluetoothctl show` returned a valid default controller

One non-fatal message may remain:

- `Failed to load Intel DDC file intel/ibt-0291-0291.ddc (-2)`

That did not prevent the controller from coming up on the validated machine.

## Quick Start

### Wi-Fi

1. Apply either the raw patch or the split patch series to your own `iwlwifi-stack-dev` tree.
2. Run `scripts/build_iwlwifi.sh /path/to/iwlwifi-stack-dev`
3. Run `scripts/install_iwlwifi.sh /path/to/iwlwifi-stack-dev`
4. Run `scripts/verify_iwlwifi.sh`

### Bluetooth

1. Run `scripts/build_bluetooth.sh`
2. Run `scripts/install_bluetooth.sh`
3. Run `scripts/verify_bluetooth.sh`
4. If needed, run `scripts/rollback_bluetooth.sh`

## Rollback

### Wi-Fi

Reinstall your previous `iwlwifi` build or restore your previous module package, then reload `iwlwifi` / `iwlmvm`.

### Bluetooth

Run:

```bash
scripts/rollback_bluetooth.sh
```

## Known Limitations

- The Wi-Fi patch was exported from a known-good local tree and is not yet split into upstream-quality commits.
- The Bluetooth workspace is intentionally narrow and tuned for this Intel controller family.
- The repository is optimized first for reproducibility and field recovery, not for upstream submission.

## Extra Docs

- `docs/hardware-matrix.md`
- `docs/faq.md`
- `docs/iwlwifi-split-summary.md`
- `docs/wifi-summary.md`
- `docs/bluetooth-summary.md`
