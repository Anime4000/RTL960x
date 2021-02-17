# Hacking_RTL9601C1
Hacking V2801F & TWCGPON657 to suite your ISP Fiber

# Issue
GPON market is a mess, plus explicit OMCI cause ONU Stick did not work

With my issue:
* V2801F build quality is bad, firmware is good, manage to have an internet connection
* TWCGPON657 build quality is good, firmware is bad, when GPON Password is set, stick hang and CPU usage become 100%

Since we dont have source code, try mix and match binary between V2801F and TWCGPON657

# Access
V2801F and TWCGPON657 has different login credentials:

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
* tar current folder