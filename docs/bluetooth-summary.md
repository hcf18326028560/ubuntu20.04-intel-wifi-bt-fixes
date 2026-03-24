# Bluetooth Notes

Validated target:

- Ubuntu 20.04
- Linux `5.15.0-139-generic`
- Intel USB Bluetooth `8087:0036`

Observed final working state:

- `lsusb -t` showed both Bluetooth interfaces bound to `btusb`
- `hciconfig -a` showed `hci0` as `UP RUNNING`
- `bluetoothctl show` returned a valid controller
- `modprobe -v btusb` loaded override modules from `/lib/modules/5.15.0-139-generic/updates/drivers/bluetooth/`

Key code changes:

- `btusb.c`
  Add `8087:0036` and ensure it matches before generic Bluetooth interface rules.
- `btintel.c`
  Accept newer TLV-era Intel hardware variants, including `0x1c`.
