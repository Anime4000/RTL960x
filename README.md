# Hacking RTL9601C1
Hacking V2801F & TWCGPON657 to suite your ISP Fiber

# Issue
GPON market is a mess, plus explicit OMCI cause ONU Stick did not work

## With my issue:
* [V2801F](https://www.amazon.com/Universal-Stick-Address-Supported-Attention/dp/B08C818JSQ)
  * Support OMCI explicit provision LAN port on 2/3/4...
  * Support OMCI explicit provision **override** `OMCI_FAKE_OK 1`
  * Good Firmware, support many ISP (Global)
  * Build not strudy
* [TWCGPON657](https://item.taobao.com/item.htm?spm=a1z09.2.0.0.c0552e8d7UBYLF&id=597031866488)
  * Not Working OMCI explicit provision LAN port on 2/3/4...
  * Not Working OMCI explicit provision **override**
  * Bad Firmware, limited ISP support
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

Based on [ru-board](http://forum.ru-board.com/topic.cgi?forum=8&topic=80480&start=1360#2) **4-Port Emulation is limited**, not many xPON Stick can understand, only V2801F do support it, **because my Internet comes at Huawei HG8240H LAN Port 4**

## My Goal Is,
Good Firmware (V2801F) + Good Hardware (TWCGPON657) = Ultimate XPON ONU STICK!

# Flash
I have been using TWCGPON657 (without fan) for a month and never had an issue, so in this sections, flash V2801F firmware into TWCGPON657 stick and fix auto-reboot issue.

## Steps:
* Downgrade your TWCGPON657 to version B13 or below.
* Flash with `V2801F_V1.9.0-201104.tar` and wait.
* Quickly login and execute `echo 3 > /proc/fiber_mode` to avoid auto-reboot (invalid `VS_AUTH_KEY`)
* Disconnect fiber from module to restore telnet
* Update `VS_AUTH_KEY` acording to `ELAN_MAC_ADDR` and `HW_HWVER`
* Reboot (in telnet)
* Reflash again with `V2801F_V1.9.0-201104.tar` (must do after fix `VS_AUTH_KEY`)
* Enjoy!

# Auto Reboot Fix
## V2801F
### Issue
* Invalid `VS_AUTH_KEY`
* Changing MAC Address `ELAN_MAC_ADDR` can cause wrong `VS_AUTH_KEY` value

### Fix
* You need to generate new `VS_AUTH_KEY` when change `ELAN_MAC_ADDR` and `HW_HWVER`
* Apperently, you have few seconds to access Telnet before rebooting
* To prevent auto reboot by entering `echo 3 > /proc/fiber_mode` (XPON Ethernet Mode)

> If you can't type fast enough, use this autoit script `quick_telnet-login.au3`.
>
> Take a look some generated [`VS_AUTH_KEY` here](Docs/VS_AUTH_KEY.md)

### Note
When `echo 3 > /proc/fiber_mode` is set, you lose telnet acccess, you need to unplug fiber to get back

## TWCGPON657
* No such problem, `VS_AUTH_KEY` does not exist.

# Usage
* Please read [FLASH_GETSET_INFO.md](Docs/FLASH_GETSET_INFO.md) for how to configure, login, etc...
* Advance setting like duplicate ONT Info, read [FLASH_GETSET_DEV.md](Docs/FLASH_GETSET_DEV.md)
* For a manual for the built-in Realtek `diag` utility, see: [RTKPONDiagShellUserGuide](Docs/RTKPONDiagShellUserGuideV001.291982779.pdf)
  * Source: https://usermanual.wiki/Pdf/RTKPONDiagShellUserGuideV001.291982779/html

# WAN Mapping
If still no Internet, try access `http://192.168.1.1/multi_wan_generic.asp` and LAN map.

# Downgrade
If V2801F firmware not supported on TWCGPON657, you can downgrade via this url: `http://192.168.1.1/upgrade.asp`

# Modify
You need a Linux PC/VM, Ubuntu as Operating System

## Prerequisite
You need these program installed:
* `tar` (extract tar package)
* `squashfs-tools` (extract/repack rootfs)
* `qemu-user-static` (run MIPS VM)

## Extract firmware
* Extract Firmware package in `tar` format, we need `rootfs` file
* Extract `rootfs` partition
```
unsquashfs rootfs
```

## Repack firmware
* Repack `rootfs`
```
mksquashfs squashfs-root rootfs.new -b 131072 -comp lzma
```
* Rename `rootfs`
```
mv rootfs rootfs.old
mv rootfs.new rootfs
```
* Update `md5sum`
```
md5sum fwu.sh rootfs uImage fwu_ver > md5.txt
```
* tar current folder
```
tar -cvf ../firmware.tar *
```
