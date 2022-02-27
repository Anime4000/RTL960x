# Hacking RTL9601C1
Hacking V2801F & TWCGPON657 to suite your ISP Fiber

> GPON market is a mess, plus explicit OMCI cause ONU Stick did not work

# Guide, Links, Info
1. [Setup SFP XPON ONU Stick](Docs/Setup_Stick.md)
2. [Flash Get, Flash Set](Docs/FLASH_GETSET_INFO.md)
3. [Diagnostic Commands](Docs/DIAG.md)
4. [Hidden Link, Firmware Update](Docs/Useful_Links.md)
5. [TWCGPON657 with V2801F firmware](Docs/TWCGPON657.md)
6. [V2801F Auto Reboot](Docs/V2801F.md)
7. [Modify Firmware](Docs/Modify_Firmware.md)

## With my issue:
* [V2801F](https://www.amazon.com/Universal-Stick-Address-Supported-Attention/dp/B08C818JSQ)
  * Support n-Port ONU Emulation
  * Support OMCI explicit provision **override** `OMCI_FAKE_OK 1`
  * Good Firmware, support many ISP (Global)
  * Build not strudy
* [TWCGPON657](https://item.taobao.com/item.htm?spm=a1z09.2.0.0.c0552e8d7UBYLF&id=597031866488)
  * **Not Support** n-Port ONU Emulation
  * **Not Support** OMCI explicit provision **override**
  * Bad Firmware, limited ISP
  * Silm & Tight build

## Triple Play Multiple ISP Problem, 4-port ONU Emulation
* Majority fiber vendor support multiple ISP
* ISP provide Triple Play service (Internet, VoIP & IPTV)
* Vendor supply 4-port ONU for each service or ISP

In this table, list of xPON Stick that support 4-port ONU Emulation
<table>
    <thead>
        <tr>
            <th></th>
            <th colspan="4">Huawei HG8240H LAN Port</th>
        </tr>
        <tr>
            <th>xPON Stick</th>
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
            <td>❌</td>
            <td>❌</td>
            <td>❌</td>
        </tr>
        <tr>
            <td>DFP-34X-2C2 (ZTE)</td>
            <td>✔️</td>
            <td>❌</td>
            <td>❌</td>
            <td>❌</td>
        </tr>
        <tr>
            <td>TWCGPON657</td>
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
        </tr>
    </tbody>
</table>

> ✔️ Port Emulation Support |
> ❌ No Support

Based on [ru-board](http://forum.ru-board.com/topic.cgi?forum=8&topic=80480&start=1360#2) **4-Port Emulation is limited**, not many xPON Stick can understand, only V2801F do support it, **because my Internet comes at Huawei HG8240H LAN Port 2** (LAN 1 for Main ISP, LAN 2 for 3rd party ISP)

> I strongly recommend to get V2801F or CarlitoxxPro (Realtek), these xPON Stick support 4-port Emulation!

## Same Chipset, Different Vendor
* There are many RTL9601C1 out there, not all firmware are interchangable
* V2801F cannot use TWCGPON657 firmware
* DFP-34X-2C2 (Realtek) cannot use V2801F firmware
* TWCGPON657 **can use** V2801F firmware
