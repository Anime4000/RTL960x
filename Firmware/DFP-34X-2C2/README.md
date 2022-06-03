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

# SFU Mode
Switch Fabric Unit, ONU in Bridge Mode, Multiple VLAN, Internet provided by specific LAN Ports
![SFU](../../Docs/Images/xPON%20OMCI%20MIB%20SFU%20Mode.png)
If your ONU only in Bridge Mode, you need to use SFU firmware such as `M114_sfp_ODI_220304.tar`

# IGD Mode
Internet Gateway Device, ONU in Router Mode, ONU is Internet Gateway, having active DHCP, PPPoE Client, etc...
![IGD](../../Docs/Images/xPON%20OMCI%20MIB%20IGD%20Mode.png)
If your ONU has Wi-Fi, Internet, you need to use IGD firmware such as `M114_sfp_ODI_210702.tar`
