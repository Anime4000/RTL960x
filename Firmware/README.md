# Firmware Collection
Folder structure arrange for more systematic.

Here collection of device firmware that use Realtek RTL9601C1

| Vendor   | Model | n-Port Emulation |
|----------|-------|------------------|
| ODI      | DFP-34X-2C2 | Not Sure |
| TWC      | TWCGPON657 | NO |
| Ubiquiti | UF-Instant | NO |
| VSOL     | V2801F | YES |

# n-Port Emulation
1. Not all stick support 4-port Emulation, if you using 4-port ONU Bridge, only **VSOL V2801F** support it.
2. No info on **ODI DFP-34X-2C2** 4-port Emulation, however it can manually bridge via `http://192.168.1.1/multi_wan_generic.asp`

# IMPORTANT!
1. ODI has release new **SFP XPON ONU Stick** using Realtek RTL9601C1 by using same model name **DFP-34X-2C2**. If your stick ZTE based, firmware are not compatile!
2. These firmware are not interchangeable each other, current finding **TWCGPON657 Stick** can use **V2801F** firmware.