# RTL9601C1 Emulator
This script allow you to modify and reverse engineering RTL9601C1 based firmware.

# Prerequisite
You need these program installed:
* `tar` (extract tar package)
* `squashfs-tools` (extract/repack rootfs)
* `qemu-user-static` (run MIPS VM)

> Most Ubuntu based distor have `tar` and `squashfs-tools` installed!

# Install
* [Download](https://github.com/Anime4000/RTL9601C1/raw/main/Tools/emulator/qemu-test.sh) `qemu-test.sh`
* Make executable `chmod +x qemu-test.sh`

# Syntax
Pretty simple to do, script do everything, you simply play with it

```
.\qemu-test.sh firmware_file.tar
```

# Ready
After you run, Terminal Emulator will land busybox just like telnet:
```
Installing: chroot QEMU MIPS
RTL9601C1 Emulator is Running!


BusyBox v1.12.4 (2020-10-26 08:35:57 CST) built-in shell (ash)
Enter 'help' for a list of built-in commands.

# 

```

During this screen, you can start modify the firmware,

## V2801F 2.5GbE
There is way to make V2801F run 2.5GbE since RTL9601C1 SoC are supported, by copying `/etc/runlansds.sh` from TWCGPON657 to V2801F. Probably also need to copy `/bin/sfpapp`

### TWCGPON657 B15 `/etc/runlansds.sh`
```sh
#!/bin/sh

lan_sds_mode=`flash get LAN_SDS_MODE | sed 's/LAN_SDS_MODE=//g'`
echo $lan_sds_mode > proc/lan_sds/lan_sds_cfg
echo 1 > proc/lan_sds/sfp_app
sfpapp &
```
