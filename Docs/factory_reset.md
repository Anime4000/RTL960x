# Factory Reset
## WARNING
This guide mainly for `RTL9601CI` and `RTL9601D` where `config` partition located at `/dev/mtd3`. Improper procedure can lead to brick, blank image, everything is at your own RISK!

# Backup
## Whole System
[Follow This Guide](https://github.com/Anime4000/RTL960x/discussions/28#discussion-4043058)

## Quick
1. `ELAN_MAC_ADDR`
2. License Key
    * ODI DFP-34X-2C2 `MAC_KEY`
    * VSOL V2801F `VS_AUTH_KEY`

# Reset
Login into `telnet` then do:
```
flash_eraseall /dev/mtd3
reboot
```
After reset, Stick will use default (hardcoded software) MAC Address, wrong `key` will not Authenticated to OLT!
