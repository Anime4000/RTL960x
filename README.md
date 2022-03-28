# Hacking RTL9601C1
Hacking V2801F, TWCGPON657 & DFP-34X-2C2 to suite your ISP Fiber

> GPON market is a mess, plus explicit OMCI cause ONU Stick did not work


# RTL960x Family
| Stick | SoC | NAND |
|-------|-----|------|
| [V2801F](https://www.baudcom.com.cn/epon-gpon-onu-stick-sfp-module-with-mac-inside.html) | RTL9601C1 | 8MB (64Mb) |
| [TWCGPON657](https://item.taobao.com/item.htm?spm=a1z09.2.0.0.c0552e8d7UBYLF&id=597031866488) | RTL9601C1 | 16MB (128Mb) | 
| [UFiber Instant](https://store.ui.com/collections/operator-ufiber/products/uf-instant) | RTL9601C1 | 8MB (64Mb) |
| [DFP-34X-2C2](https://www.aliexpress.com/item/4000086970977.html) | RTL9601D | 8MB (64Mb) |

Firmware might interchangable each other, flash it at your own RISK!

# Guide, Links, Info
1. [Setup SFP XPON ONU Stick](Docs/Setup_Stick.md)
2. [Flash Get, Flash Set](Docs/FLASH_GETSET_INFO.md)
    * [xPON Model Id](Docs/FLASH_GETSET_INFO.md#pon_vendor_id-4-ascii-character-maximum)
    * [2.5GbE Mode](Docs/FLASH_GETSET_INFO.md#lan_sds_mode-min-1-max-5)
4. [Diagnostic Commands](Docs/DIAG.md)
5. [Hidden Link, Firmware Update](Docs/Useful_Links.md)
6. [TWCGPON657 with V2801F firmware](Docs/TWCGPON657.md)
7. [V2801F Auto Reboot](Docs/V2801F.md)
8. [Firmware Emulator](Tools/emulator)

# Triple Play Multiple ISP Problem, 4-port ONU Emulation
* Majority fiber vendor support multiple ISP
* ISP provide Triple Play service (Internet, VoIP & IPTV)
* Vendor supply 4-port ONU for each service or ISP

## Multiple ISP
![HG8240H5](Docs/Images/Ports%20Provisioning%20Multiple%20ISP.png)

## Multiple Service
![HG8240H5](Docs/Images/Ports%20Provisioning%20Multi%20Port%20Service.png)

Based on [ru-board](http://forum.ru-board.com/topic.cgi?forum=8&topic=80480&start=1360#2) **4-Port Emulation is limited**, not many xPON Stick can understand, only V2801F do support it, **because my Internet comes at Huawei HG8240H LAN Port 2** (LAN 1 for Main ISP, LAN 2 for 3rd party ISP)

In this table, list of xPON Stick that support 4-port ONU Emulation
<table>
    <thead>
        <tr>
            <th></th>
            <th colspan="5">Huawei HG8240H LAN Port</th>
        </tr>
        <tr>
            <th>xPON Stick</th>
            <th>Root</th>
            <th>1️⃣</th>
            <th>2️⃣</th>
            <th>3️⃣</th>
            <th>4️⃣</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>DFP-34G-2C2 (ZTE)</td>
            <td>✔️</td>
            <td>✔️</td>
            <td>❌</td>
            <td>❌</td>
            <td>❌</td>
        </tr>
        <tr>
            <td>DFP-34X-2C2 (ZTE)</td>
            <td>✔️</td>
            <td>✔️</td>
            <td>❌</td>
            <td>❌</td>
            <td>❌</td>
        </tr>
        <tr>
            <td>DFP-34X-2C2 (Realtek)</td>
            <td>✔️</td>
            <td>❌</td>
            <td>❌</td>
            <td>❌</td>
            <td>❌</td>
        </tr>
        <tr>
            <td>TWCGPON657</td>
            <td>✔️</td>
            <td>✔️</td>
            <td>❌</td>
            <td>❌</td>
            <td>❌</td>
        </tr>
        <tr>
            <td>V2801F</td>
            <td>✔️</td>
            <td>✔️</td>
            <td>✔️</td>
            <td>✔️</td>
            <td>✔️</td>
        </tr>
    </tbody>
</table>

> ✔️ Port Emulation Support |
> ❌ Not Supported

> `Root` mean your ONU is All in One where PPPoE/DHCP ended inside ONU (not bridge/route mode)

> I strongly recommend to get V2801F or CarlitoxxPro (Realtek), these xPON Stick support 4-port Emulation!

---
