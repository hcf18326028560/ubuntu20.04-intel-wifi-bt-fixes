# Wi-Fi Notes

Validated target:

- Ubuntu 20.04
- Linux `5.15.0-139-generic`
- Intel Wi-Fi `8086:272b`
- Local tree: `iwlwifi-stack-dev`

Main fix buckets:

- Embedded PNVM support and GL/BZ init alignment.
- New-station / MLD startup path fixes.
- `PHY_CONTEXT_CMD v6` support.
- Newer scan and regulatory response handling.
- GL/BZ data-path compatibility and TX checksum fallback.

The raw tracked diff is exported as `patches/iwlwifi-bz-glfm-5.15.patch`.
