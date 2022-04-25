# Hacking [RTL960x](https://www.google.com/search?q=rtl9601ci+datasheet)
* Hacking V2801F, TWCGPON657 & DFP-34X-2C2 to suite your ISP Fiber
* GPON market is a mess, plus explicit OMCI cause ONU Stick did not work
* [4-port ONU Emulation](#4-port-onu-emulation) Table

# RTL960x Family
| Stick | SoC | NAND |
|-------|-----|------|
| [V2801F](https://www.baudcom.com.cn/epon-gpon-onu-stick-sfp-module-with-mac-inside.html) | `RTL9601CI` | 8MiB (64Mb) |
| [TWCGPON657](https://item.taobao.com/item.htm?spm=a1z09.2.0.0.c0552e8d7UBYLF&id=597031866488) | `RTL9601CI` | 16MiB (128Mb) | 
| [UFiber Instant](https://store.ui.com/collections/operator-ufiber/products/uf-instant) | `RTL9601CI` | 8MiB (64Mb) |
| [DFP-34X-2C2](https://m.tb.cn/h.fJc2RFv?tk=xZ4r2RPCGvj) | `RTL9601D` | 8MiB (64Mb) |

# Where to buy?
## ODI DFP-34X-2C2 <sup>Recommended!</sup>
1. [HSGQ @ Taobao Mall](https://m.tb.cn/h.fJc2RFv?tk=xZ4r2RPCGvj)
2. [Fibershow @ AliExpress](https://www.aliexpress.com/item/1005003515662920.html)
### Feature
* Much cheaper than **VSOL V2801F** & **CarlitoxxPro CPGOS03-0490 v2.0**!
* Using latest SoC **RTL9601D**!
* Support **HEX** PLOAM Password! *<sup>Using [`220304`](https://github.com/Anime4000/RTL9601C1/blob/main/Firmware/DFP-34X-2C2/M114_sfp_ODI_220304.tar) Firmware</sup>*
* Support 2.5GbE via [**HiSGMII** or **2500Base-X**](Docs/FLASH_GETSET_INFO.md#lan_sds_mode-min-1-max-6)! *<sup>See [Compatibility](Docs/2.5Gb.md#device-list), [SpeedTest](https://github.com/Anime4000/RTL960x/issues/17#issuecomment-1100272965)</sup>*
* Using newer SFP Body with intergrated heatsink *<sup>See [Picture](https://github.com/Anime4000/RTL9601C1/issues/17#issuecomment-1077681925)</sup>*
* Very efficient, just **45°C** without fan!
* Automatic/Transparent bridge like VSOL V2801F! *<sup>Using [`220304`](https://github.com/Anime4000/RTL9601C1/blob/main/Firmware/DFP-34X-2C2/M114_sfp_ODI_220304.tar) Firmware</sup>*
* Support 4-port ONU Emulation

# V2801F Alternative
I recommend [TWCGPON657](https://item.taobao.com/item.htm?spm=a1z09.2.0.0.c0552e8d7UBYLF&id=597031866488) with [V2801F Firmware](Firmware/TWCGPON657/README.md) as V2801F substitute

* Limited 2.5GbE Support *<sup>wrong `LAN_SDS_MODE` can lock you out, no auto switch</sup>*
* **HEX** PLOAM Password require modification from [@zry98](https://github.com/zry98/SFP-GPON-ONU#modules-using-rtl8672--rtl9601c-chipset)
* Automatic/Full Transparent
* Support 4-port ONU Emulation
* [Modern WebGUI](WebGui#example)

# Guide, Links, Info
1. [Setup SFP XPON ONU Stick](Docs/Setup_Stick.md)
2. [Flash Get, Flash Set](Docs/FLASH_GETSET_INFO.md)
    * [xPON Model Id](Docs/FLASH_GETSET_INFO.md#pon_vendor_id-4-ascii-character-maximum)
    * [2.5GbE Mode](Docs/FLASH_GETSET_INFO.md#lan_sds_mode-min-1-max-6)
3. [Diagnostic](Docs/DIAG.md)
    * [Hidden Link, Firmware Update](Docs/Useful_Links.md)
    * [OMCI MIB INFO](Docs/OMCI_CLI.md)
    * [OMCI VLAN](Docs/OMCI_VLAN.md)
    * [Wireshark](https://github.com/tdmadam/OMCI-for-SFP-Stick) <sup>OMCI decoding for Wireshark by [@tdmadam](https://github.com/tdmadam)</sup>
    * [UART](Docs/UART.md)
4. [TWCGPON657 × V2801F Firmware](Firmware/TWCGPON657/README.md)
5. [V2801F Auto Reboot](Docs/V2801F.md)
6. [Firmware Emulator](Tools/emulator)


# Triple Play Multiple ISP Problem, 4-port ONU Emulation
* Majority fiber vendor support multiple ISP
* ISP provide Triple Play service (Internet, VoIP & IPTV)
* Vendor supply 4-port ONU for each service or ISP

## 4-port ONU Emulation
Based on [ru-board](http://forum.ru-board.com/topic.cgi?forum=8&topic=80480&start=1360#2) **4-Port Emulation is limited**

If you using 4-port ONU like [Huawei HG8240H5](https://www.google.com/search?q=HG8240H5) and [Nokia G-240G-E](https://www.google.com/search?q=G-240G-E) and Router connected to ONU LAN 2/3/4, you have limited option, I recommend [ODI DFP-34X-2C2](https://www.aliexpress.com/item/1005003515662920.html) with `220304` or newer firmware.

Here list of xPON Stick on the market that support 4-port ONU Emulation:
<table>
    <thead>
        <tr>
            <th rowspan="2">xPON Stick</th>
            <th colspan="5">Huawei HG8240H LAN Port</th>
            <th rowspan="2">Firmware</th>
        </tr>
        <tr>
            <th>Root</th>
            <th>1️⃣</th>
            <th>2️⃣</th>
            <th>3️⃣</th>
            <th>4️⃣</th>
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
            <td>OpenWRT</td>
        </tr>
        <tr>
            <td>Nokia G-010S-A</td>
            <td>✔️</td>
            <td>❌</td>
            <td>❌</td>
            <td>❌</td>
            <td>❌</td>
            <td> </td>
        </tr>
        <tr>
            <td>DFP-34G-2C2 (ZTE)</td>
            <td>✔️</td>
            <td>✔️</td>
            <td>❌</td>
            <td>❌</td>
            <td>❌</td>
            <td> </td>
        </tr>
        <tr>
            <td>DFP-34X-2C2 (ZTE)</td>
            <td>✔️</td>
            <td>✔️</td>
            <td>❌</td>
            <td>❌</td>
            <td>❌</td>
            <td> </td>
        </tr>
        <tr>
            <td>DFP-34X-2C2 (Realtek)</td>
            <td>✔️</td>
            <td>✔️</td>
            <td>✔️</td>
            <td>✔️</td>
            <td>✔️</td>
            <td><code>M114_sfp_ODI_220304.tar</code> or newer</td>
        </tr>
        <tr>
            <td>TWCGPON657</td>
            <td>✔️</td>
            <td>✔️</td>
            <td>✔️</td>
            <td>✔️</td>
            <td>✔️</td>
            <td><code>C00R657V2801F_V1.9.0-220404.tar</code></td>
        </tr>
        <tr>
            <td>V2801F</td>
            <td>✔️</td>
            <td>✔️</td>
            <td>✔️</td>
            <td>✔️</td>
            <td>✔️</td>
            <td> Stock Firmware </td>
        </tr>
    </tbody>
</table>

> ✔️ Port Emulation Support
> 
> ❌ Not Supported
>
> `Root` mean your ONU is All in One where PPPoE/DHCP ended inside ONU (not bridge/route mode)

## Multiple ISP
![HG8240H5](Docs/Images/Ports%20Provisioning%20Multiple%20ISP.png)

## Multiple Service
![HG8240H5](Docs/Images/Ports%20Provisioning%20Multi%20Port%20Service.png)

