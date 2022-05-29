# ODI DFP-34X-2C2
1. This for stick using Realtek `RTL9601D` SoC only!
2. If your stick using ZTE chipset, this firmware are not compatible!

# 4-port Emulation
| Firmware                         | Mode | 4-port Emulation |
|----------------------------------|------|------------------|
| `M114_sfp_ODI_210702.tar`        | IGD  | ❌ |
| `M114_sfp_ODI_220304.tar`        | SFU  | ✔️ |
| `M114_sfp_ODI_Vlan_220414.tar`   | SFU  | ✔️ |
| `M114_sfp_ODI_hybrid_220527.tar` | IGD  | ❌ |

Note:
1. IGD
   * Internet Gateway Device, ONU in Router Mode, DHCP, PPPoE Client
2. SFU
   * Switch Fabric Unit, ONU in Bridge Mode

# This firmware cannot be used on `V2801F` and `TWCGPON657`!
