# Hacking_RTL9601C1
Hacking V2801F & TWCGPON657 to suite your ISP Fiber

# Issue
GPON market is a mess, plus explicit OMCI cause ONU Stick did not work

With my issue:
* V2801F build quality is bad, died from overheating, firmware is good, manage to have an internet connection
* TWCGPON657 build quality is good, firmware is bad, when GPON Password is set, stick hang and CPU usage become 100%

Since we dont have source code, try mix and match binary between V2801F and TWCGPON657

> Update:
> V2801F firmware can be used on TWCGPON657 stick. However, XPON Stick will keep rebooting due to invalid `VS_AUTH_KEY`, you have few seconds telnet access to update `VS_AUTH_KEY` or `echo 3 > /proc/fiber_mode` to prevent auto reboot.

# Auto Reboot
## V2801F
* XPON Stick will keep rebooting because invalid `VS_AUTH_KEY`
* Changing MAC Address `ELAN_MAC_ADDR` can cause invalid `VS_AUTH_KEY`
* You have few seconds to access telnet.
* To prevent auto reboot, enter: `echo 3 > /proc/fiber_mode` (*When set. you need disconnect fiber to get access*)

##TWCGPON657
* No such problem, `VS_AUTH_KEY` does not exist.

# Usage
* Please read [FLASH_GETSET_INFO.md](Docs/FLASH_GETSET_INFO.md) for how to configure, login, etc...
* Advance setting like duplicate ONT Info, read [FLASH_GETSET_DEV.md](Docs/FLASH_GETSET_DEV.md)

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