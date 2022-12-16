# Hacking [RTL960x](https://www.google.com/search?q=rtl9601ci+datasheet)
* Hacking V2801F, TWCGPON657 & DFP-34X-2C2 to suite your ISP Fiber
* GPON market is a mess, plus explicit OMCI cause ONU Stick did not work
* [4-port ONU Emulation](#4-port-onu-emulation) Table

# xPON SFP ONU
## RTL960x Family
| Stick | SoC | NAND | Mode | 4-port `EthUni` |
|-------|-----|------|------|-----------------|
| [VSOL V2801F](https://www.baudcom.com.cn/epon-gpon-onu-stick-sfp-module-with-mac-inside.html) | `RTL9601CI` | 8MiB (64Mb) | VEIP, PPTP | YES |
| [T&W TWCGPON657](https://item.taobao.com/item.htm?spm=a1z09.2.0.0.c0552e8d7UBYLF&id=597031866488) | `RTL9601CI` | 16MiB (128Mb) | VEIP, PPTP | YES, fw: [`C00R657V2801F`](Firmware/TWCGPON657/C00R657V2801F_V1.9.0-220404.tar) |
| [Ubiquiti UFiber Instant](https://store.ui.com/collections/operator-ufiber/products/uf-instant) | `RTL9601CI` | 8MiB (64Mb) | VEIP, PPTP | NO |
| [ODI DFP-34X-2C2](https://m.tb.cn/h.fJc2RFv?tk=xZ4r2RPCGvj) | `RTL9601D` | 8MiB (64Mb) | VEIP, PPTP | YES, fw: [`220304`](https://github.com/Anime4000/RTL960x/blob/main/Firmware/DFP-34X-2C2/M114_sfp_ODI_220304.tar) & [`220414`](https://github.com/Anime4000/RTL960x/blob/main/Firmware/DFP-34X-2C2/M114_sfp_ODI_Vlan_220414.tar) |
| [Nokia G-010S-Q](https://github.com/Anime4000/RTL960x/issues/52#issuecomment-1208424756) | `RTL9601CI` | 16MiB (128Mb) | ? | ? |

## Other
| Stick | SoC | NAND | Mode | 4-port `EthUni` |
|-------|-----|------|------|-----------------|
| ODI DFP-34X-2C2 | ZTE | ? | PPTP | NO |
| Huawei MA5671a     | Intel | ? | PPTP | NO |
| Nokia G-010S-P    | Intel | ? | PPTP | NO |
| Nokia G-010S-A    | Intel | ? | PPTP | NO |

# VEIP vs PPTP
| Code | Full name | Meaning |
|------|-----------|---------|
| PPTP | Physical Path Termination Point | OLT directly sends VLAN data to each physical interface of ONU |
| VEIP | Virtual Ethernet Interface Point | Virtualizes the total interface of an ONU, ONU LAN port provisioning |

# Guide, Links, Info
1. [Backup `env`, `env2` & `config` partition](https://github.com/Anime4000/RTL960x/discussions/28) <sup>Guide by [@tdmadam](https://github.com/tdmadam)</sup>
1. [Setup XPON ONU SFP Stick](Docs/Setup_Stick.md)
    * [Clone Stock ONU OMCI Info](https://github.com/Anime4000/RTL960x/blob/main/Docs/Stock_ONU.md)
3. [`flash get`, `flash set`](Docs/FLASH_GETSET_INFO.md)
    * [xPON Model Id](Docs/FLASH_GETSET_INFO.md#pon_vendor_id-4-ascii-character-maximum)
    * [LAN SDS Mode](Docs/FLASH_GETSET_INFO.md#lan_sds_mode)
    * [2.5GbE Compatibility](Docs/2.5Gb.md)
4. [Diagnostic](Docs/DIAG.md)
    * [Factory Reset via Telnet](Docs/factory_reset.md)
    * [Switch/Roll back Firmware](Docs/fw_part.md)
    * [`O5` no Internet](Docs/fakeO5.md) <sup>fake ONU Status cause by some OLT</sup>
    * [`OMCI_TM_OPT`](https://github.com/Anime4000/RTL960x/issues/35#issuecomment-1138255401) <sup>stick cause internet speed slow? this look at this, found by [@ccy](https://github.com/ccy)</sup>
    * [OMCI MIB INFO](Docs/OMCI_CLI.md) <sup>check various OMCI, VLAN, OLT</sup>
    * [OMCI VLAN](Docs/OMCI_VLAN.md) <sup>list available VLAN that provided by OLT</sup>
    * [SFU/HGU feature bits](https://gist.github.com/rajkosto/79034a1f7b3de3f40edf50ffbd8396b0) <sup>RE done by [@rajkosto](https://github.com/rajkosto) also define 4-port emulation `ignore_conn_uniNode_check` UniG on SFU firmware</sup>
    * [Forward Operation `FwdOp`](https://github.com/Anime4000/RTL960x/pull/94#issuecomment-1319016018)
    * [Wireshark](https://github.com/tdmadam/OMCI-for-SFP-Stick) <sup>OMCI decoding for Wireshark by [@tdmadam](https://github.com/tdmadam)</sup>
    * [UART](Docs/UART.md)
5. [TWCGPON657 × V2801F Firmware](Firmware/TWCGPON657/README.md)
6. [V2801F Auto Reboot](Docs/V2801F.md)
7. [Firmware Emulator](Tools/emulator)
8. Keygen
    * [V2801F](https://github.com/Anime4000/RTL960x/blob/main/Docs/VS_AUTH_KEY.md)
    * [DFP-34X-2C2](https://gist.github.com/rajkosto/29c513b96ea6262d2fb1f965a52ce16f)

# Sucess Story
List of users has successfully ditch stock ONU!
1. [@stich86 2.5GbE Internet](https://github.com/Anime4000/RTL960x/issues/17#issuecomment-1101435506)
2. [My journey connecting fiber internet to my router](https://www.reddit.com/r/HomeNetworking/comments/vd0qm2/my_journey_connecting_fiber_internet_to_my_router/)
3. [Hinet users in TW](https://github.com/Anime4000/RTL960x/pull/44#issue-1281699738)

# Where to buy?
## ODI DFP-34X-2C2 <sup>Recommended!</sup>
1. [HSGQ @ Taobao Mall](https://m.tb.cn/h.fJc2RFv?tk=xZ4r2RPCGvj)
2. [Fibershow @ AliExpress](https://www.aliexpress.com/item/1005003515662920.html) (Choose XPON)
### Feature
* Much cheaper than **VSOL V2801F** & **CarlitoxxPro CPGOS03-0490 v2.0**!
* Using latest SoC **RTL9601D**!
* Support **HEX** PLOAM Password! *<sup>Using [`220304`](https://github.com/Anime4000/RTL9601C1/blob/main/Firmware/DFP-34X-2C2/M114_sfp_ODI_220304.tar) Firmware</sup>*
* Support 2.5GbE via [**HiSGMII** or **2500Base-X**](Docs/FLASH_GETSET_INFO.md#lan_sds_mode-min-1-max-6)! *<sup>See [Compatibility](Docs/2.5Gb.md#device-list), [SpeedTest](https://github.com/Anime4000/RTL960x/issues/17#issuecomment-1100272965)</sup>*
* Using newer SFP Body with intergrated heatsink *<sup>See [Picture](https://github.com/Anime4000/RTL9601C1/issues/17#issuecomment-1077681925)</sup>*
* Very efficient, just **45°C** without fan!
* Automatic/Transparent bridge like VSOL V2801F! *<sup>Using [`220304`](https://github.com/Anime4000/RTL9601C1/blob/main/Firmware/DFP-34X-2C2/M114_sfp_ODI_220304.tar) Firmware</sup>*
* Support 4-port ONU Emulation

## V2801F Alternative
1. [TWCGPON657](https://item.taobao.com/item.htm?spm=a1z09.2.0.0.c0552e8d7UBYLF&id=597031866488) with [V2801F Firmware](Firmware/TWCGPON657/README.md) as V2801F substitute
2. Opton GP801R <sup>Found by [@AreYouLoco](https://github.com/AreYouLoco)</sup>
### Feature
* Limited 2.5GbE Support *<sup>wrong `LAN_SDS_MODE` can lock you out, no auto switch</sup>*
* **HEX** PLOAM Password require modification from [@zry98](https://github.com/zry98/SFP-GPON-ONU#modules-using-rtl8672--rtl9601c-chipset)
* Automatic/Full Transparent
* Support 4-port ONU Emulation
* [Modern WebGUI](WebGui#example)

# Triple Play Multiple ISP Problem, 4-port ONU Emulation
* Majority fiber vendor support multiple ISP
* ISP provide Triple Play service (Internet, VoIP & IPTV)
* Vendor supply 4-port ONU for each service or ISP

## 4-port ONU Emulation
Based on [ru-board](http://forum.ru-board.com/topic.cgi?forum=8&topic=80480&start=1360#2), xPON Stick with **4-Port Emulation** support is limited!

### ONU LAN Port Binding example
If you using 4-port ONU like [Huawei HG8240H5](https://www.google.com/search?q=HG8240H5), [Nokia G-240G-E](https://www.google.com/search?q=G-240G-E) and Router connected to ONU LAN 2/3/4, you have limited option, I recommend [ODI DFP-34X-2C2](https://www.aliexpress.com/item/1005003515662920.html) with `220304` or newer firmware.

### Table 4-port ONU Emulation
Here list of xPON Stick on the market that support 4-port ONU Emulation:
<table>
    <thead>
        <tr>
            <th rowspan="2">xPON Stick</th>
            <th colspan="6">Huawei HG8240H LAN Port</th>
            <th rowspan="2">Firmware</th>
        </tr>
        <tr>
            <th>Root</th>
            <th>1️⃣</th>
            <th>2️⃣</th>
            <th>3️⃣</th>
            <th>4️⃣</th>
            <th>PVID</th>
        </tr>
    </thead>
    <tbody>
       <tr>
            <td>Huawei MA5671a</td>
            <td>✔️</td>
            <td>❌</td>
            <td>❌</td>
            <td>❌</td>
            <td>❌</td>
            <td>✔️</td>
            <td>OpenWRT</td>
        </tr>
        <tr>
            <td>Nokia G-010S-P</td>
            <td>✔️</td>
            <td>❌</td>
            <td>❌</td>
            <td>❌</td>
            <td>❌</td>
            <td>✔️</td>
            <td>OpenWRT</td>
        </tr>
        <tr>
            <td>ODI DFP-34X-2C2</td>
            <td>✔️</td>
            <td>✔️</td>
            <td>❌</td>
            <td>❌</td>
            <td>❌</td>
            <td>❌</td>
            <td><code>210702</code>, <code>220527</code></td>
        </tr>
        <tr>
            <td>ODI DFP-34X-2C2</td>
            <td>✔️</td>
            <td>✔️</td>
            <td>✔️</td>
            <td>✔️</td>
            <td>✔️</td>
            <td>❓</td>
            <td><code>220304</code>, <code>220414</code></td>
        </tr>
        <tr>
            <td>TWCGPON657</td>
            <td>✔️</td>
            <td>✔️</td>
            <td>✔️</td>
            <td>✔️</td>
            <td>✔️</td>
            <td>❌</td>
            <td><code>C00R657V2801F_V1.9.0-220404.tar</code></td>
        </tr>
        <tr>
            <td>V-SOL V2801F</td>
            <td>✔️</td>
            <td>✔️</td>
            <td>✔️</td>
            <td>✔️</td>
            <td>✔️</td>
            <td>❌</td>
            <td> Stock Firmware </td>
        </tr>
    </tbody>
</table>

> ✔️ Port Emulation Support
> 
> ❌ Not Supported
>
> `Root` mean your ONU is All in One where PPPoE/DHCP ended inside ONU (not bridge/route mode)
>
> **PVID** is VLAN untagging, at router side, WAN connected without VLAN, useful consumer router such as TL-XDR5480 without VLAN support

## Multiple ISP
![HG8240H5](Docs/Images/Ports%20Provisioning%20Multiple%20ISP.png)

## Multiple Service
![HG8240H5](Docs/Images/Ports%20Provisioning%20Multi%20Port%20Service.png)

