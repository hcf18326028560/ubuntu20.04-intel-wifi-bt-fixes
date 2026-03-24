# Hardware Matrix

## Validated Working Combination

| Component | Value |
| --- | --- |
| OS | Ubuntu 20.04 |
| Kernel | `5.15.0-139-generic` |
| GPU | NVIDIA RTX 5070 Ti |
| Wi-Fi | Intel `8086:272b` |
| Bluetooth | Intel `8087:0036` |
| Wi-Fi stack source | local `iwlwifi-stack-dev` backport tree |
| Bluetooth source base | upstream Linux `v5.15` Bluetooth drivers |

## Observed Wi-Fi End State

- Interface associates successfully.
- Scan results recover beyond previously remembered SSIDs.
- DNS and TCP traffic recover on the validated machine.

## Observed Bluetooth End State

- `btusb` binds to the Intel USB device.
- `hci0` appears and remains available.
- `bluetoothctl show` reports a valid controller.
