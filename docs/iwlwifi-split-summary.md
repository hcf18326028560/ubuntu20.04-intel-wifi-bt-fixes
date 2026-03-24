# Split Wi-Fi Patch Set

The raw Wi-Fi patch is also split into smaller reviewable groups.

| Patch | Files | Approx. lines |
| --- | ---: | ---: |
| `patches/iwlwifi-split/0001-pnvm-and-core-plumbing.patch` | 11 | 392 |
| `patches/iwlwifi-split/0002-mld-startup-phy-and-connect.patch` | 16 | 1361 |
| `patches/iwlwifi-split/0003-scan-and-regulatory.patch` | 7 | 948 |
| `patches/iwlwifi-split/0004-bz-transport-and-debug.patch` | 9 | 642 |

## Grouping Rationale

- `0001`: embedded PNVM and core GL/BZ plumbing.
- `0002`: MLD startup, PHY context, connect path, and TX checksum fallback.
- `0003`: scan and regulatory / MCC response handling.
- `0004`: BZ-specific transport and debug-path bring-up helpers.
