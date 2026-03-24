# FAQ

## Why keep both a raw Wi-Fi patch and a split patch series?

The raw patch preserves the exact known-good working tree. The split series makes it easier to review or cherry-pick pieces.

## Why is the Bluetooth module packaged as external source files?

The Bluetooth fix was narrow enough to reproduce cleanly as an external module build against Ubuntu 20.04 / Linux 5.15.

## Why not upstream-quality commits yet?

The original goal was to recover a broken machine and keep a reproducible working state. Upstream cleanup can happen later.

## Why is there still a missing DDC warning for Bluetooth?

The validated machine still brought up a usable controller without the matching DDC file. The warning was non-fatal in this environment.

## What should I apply first for Wi-Fi?

If you want the least thinking, start from `patches/iwlwifi-bz-glfm-5.15.patch`. If you want easier review, apply the split series in order.
