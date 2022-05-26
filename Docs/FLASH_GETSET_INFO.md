# Telnet Login:
[List of default login](Setup_Stick.md#default-password)

# Explaination
## `ELAN_MAC_ADDR` (12 Hexadecimal number maximum)
GPON user can skip this because GPON encap inside GEM frame which is don't have MAC Address attached!

## `GPON_PLOAM_PASSWD` (10 Alphanumeric character maximum?)
Need to set for OLT Authenticate your ONT stick, you can get from original ONT WebGUI.

## `GPON_SN` (12 ASCII character maximum)
Need to set for OLT Authenticate your ONT stick, enter your original ONT Serial Number, must be ASCII form `HWTC12345678`, you may need to convert first eight HEX digit serial number to ASCII, just like `PON_VENDOR_ID`

## `GPON_ONU_MODEL` (8 ASCII character maximum)
Need to set for OLT Authenticate your ONT stick, enter your original ONT Model, Example: `HG8240H5`

## `OMCI_OLT_MODE` (Min 0, Max 3, Default is 0)
Configure how ONT Stick handle OMCI from OLT:
| Value | Note | OMCI Information |
|-------|------|------------------|
| `0` | Default Mode | Stock, some value are cannot be change |
| `1` | Huawei OLT Mode | Huawei MA5671a |
| `2` | ZTE OLT Mode | ZTE |
| `3` | Customized Mode | Custom Software/Hardware Version, OMCC, etc... | 

> `0` and `3` behave differenly from V2801F, TWCGPON675 and DFP-34X-2C2, more testing is needed!

## `OMCI_FAKE_OK` (0 = Disable, 1 = Enable, Default is 0)
Some Fiber Vendor/Wholesale/ISP have explicit LAN Port Number provisioning or proprietary OMCI that ONT Stick cant not understand, this will make ONT Stick reply `OK` whatever OMCI OLT throw at!

## `OMCI_TM_OPT` (Min 0, Max 2, Default is 2)
This handle how OLT manage bandwidth, try change these value if you have slow down. <sup>found by [@ccy](https://github.com/ccy)</sup>
| Value | Info |
|-------|------|
| `0` | Priority controlled |
| `1` | Rate controlled |
| `2` | Priority and Rate controlled |

## `PON_VENDOR_ID` (4 ASCII character maximum)
Need to set for OLT Authenticate your ONT stick, please read your original ONT Serial Number, either in HEX digit or ASCII, if in HEX digit, you need convert first eight HEX digit to ASCII, for example `48575443` = `HWTC`.

Here some popular list if want to fool the OLT:
|   ID   | Vendor Name |
|--------|-------------|
| `HWTC` | Huawei      |
| `ZTEG` | ZTE         |
| `ALCL` | Nokia/Alcatel-Lucent |
| `UBNT` | Ubiquiti    |
| `FHTT` | Fiber Home  |
| `RTKG` | Realtek     |
| `TPLG` | TP-Link     |
| `SCOM` | Sercomm     |
| `TMBB` | Technicolor |

## `LAN_SDS_MODE` (Min 1, Max 6)
Configure how stick link negotiation with SFP, some router has specific issue, between PHY or MAC, (Layer 1 and Layer 2 perhaps?)

| Value | `cat /proc/kmsg`                   | Mode     | Behavior         | `ethtool`       | Note |
|-------|------------------------------------|----------|------------------|-----------------|------|
| `0`   | `<4>change mode to 0(GE/FE PHY)`   | `TP`     | 1GbaseT/100baseT | `0x020`         | DFP-34X-2C2 Auto Detect |
| `1`   | `<4>change mode to 1(Fiber 1G)`    | `FIBER`  | 1GbaseX          | `0x20000000000` | V2801F Default |
| `2`   | `<4>change mode to 2(SGMII PHY)`   | `TP MII` | 1Gb PHY          |                 | TWCGPON657 Default |
| `3`   | `<4>change mode to 3(SGMII MAC)`   | `MII`    | 1Gb MAC          |                 | DFP-34X-2C2 Default |
| `4`   | `<4>change mode to 4(HiSGMII PHY)` | `TP MII` | 2.5Gb PHY        |                 |  |
| `5`   | `<4>change mode to 5(HiSGMII MAC)` | `MII`    | 2.5Gb MAC        |                 |  |
| `6`   | `<4>change mode to 6(2500BaseX)`   | `FIBER`  | 2500baseX        | `0x8000`        |  |
| `7`   | `<4>change mode to 7(SGMII Force)` | `TP`?    | 1GbaseT          |                 | DFP-34X-2C2 |

### 2.5Gb Compatibility
See [Device List](2.5Gb.md)

## `DIRECT_BRIDGE_MODE` (Min 0, Max 1, Default is 1)
Not sure about this, it seem PON interface bridged to LAN under one `br0` ?

## `DEVICE_TYPE` (Min 0, Max 2, Default is 0)
| Value | Mode | Default |
|-------|------|---------|
| `0` | `bridge` | V2801F, TWCGPON657, DFP-34X-2C2 (220304 & above) |
| `1` | `router` | DFP-34X-2C2 (210702) |
| `2` | `hybrid` (both) | |

## `VLAN_CFG_TYPE` (Min 0, Max 1, Default is 0)
VLAN Configuration Type:
| Value | Mode |
|-------|------|
| `0` | Auto Detect |
| `1` | Manual (which require `VLAN_MANU_MODE` to set) |

## `VLAN_MANU_MODE` (Min 0, Max 3, Default is 0)
How ONU Stick handle VLAN from PON to ETH interface
| Value | Mode | Note | Explaination |
|-------|------|------|--------------|
| `0` | Transparent Mode | VLAN will mapped as is | Map VLAN without changing original id |
| `1` | Tagging Mode | VLAN Stacking / Q-in-Q | Untag first VLAN layer and bridge as is |
| `2` | Remote Access Mode |  |  |
| `3` | Special Case Mode |  |  |

## `PON_MODE` (Min 1, Max 3, Default is 1)
Configure ONT Stick in which mode:
| Value | Note |
|-------|------|
| `1` | GPON |
| `2` | EPON |
| `3` | Ethernet |

## `FIBER_MODE` (Min 1, Max 3, Default is 0)
If `PON_MODE=3` is set, `FIBER_MODE` become available and update `/proc/fiber_mode`.
| Value | Note |
|-------|------|
| `0` | Pre-defined |
| `1` | AN 1G |
| `2` | Auto |
| `3` | Force 1G |
| `4` | Force 100M |

> Enter `echo 3 > /proc/fiber_mode` can prevent V2801F from auto reboot, giving you time to fix `VS_AUTH_KEY` or firmware update, this will put XPON Stick become Ethernet Mode.

## `OMCI_VEIP_SLOT_ID` (Integer Value, Default is 255)
Virtual Ethernet Interface Point Slot Id, you may need find VEIP Id from old ONU, try save configuration and find `veip`, for example: [Huawei HG8240H5](https://github.com/Anime4000/Hacking_Huawei_HG8240H5_ONT/blob/master/xml/hw_ctree.xml#L109)

## `VS_AUTH_KEY` (32 Hexadecimal number) *V2801F Only!*
Changing `ELAN_MAC_ADDR` or/and `HW_HWVER` value, **must** generate new `VS_AUTH_KEY`. Failed to do so, V2801F stick will in auto reboot forever.

# NOTE:
every `flash set` need `reboot` to take effect!

It's better that you download and save configuration,
edit `config.xml` accordingly, it's better to empty value `""` if not required,
then upload modified `config.xml` back.

# Flash Command (default)
```
flash set OMCI_OLT_MODE 0
flash set OMCI_FAKE_OK 0
flash set OMCI_TM_OPT 2
flash set VLAN_CFG_TYPE 0
flash set VLAN_MANU_MODE 0
flash set DIRECT_BRIDGE_MODE 1
flash set PON_MODE 1
flash set PON_VENDOR_ID GPON
flash set GPON_ONU_MODEL IGD
flash set GPON_SN GPONC6FFFFFF
flash set GPON_PLOAM_PASSWD 1234567890
flash set ELAN_MAC_ADDR 6cefc6ffffff
flash set FIBER_MODE 0
flash set DEVICE_TYPE 0
flash set OMCI_VEIP_SLOT_ID 255
flash set VS_AUTH_KEY 1CAFC40AC99B014BB013849A92942FEB
reboot
```
