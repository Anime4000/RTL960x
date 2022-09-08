# RTL960x Emulator
This script allow you to modify and reverse engineering RTL9601C1 based firmware.

# Prerequisite
You need these program installed:
* `tar` (extract tar package)
* `squashfs-tools` (extract/repack rootfs)
* `qemu-user-static` (run MIPS VM)

> Most Ubuntu based distro have `tar` and `squashfs-tools` installed!

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
RTL960x Emulator is Running!


BusyBox v1.12.4 (2020-10-26 08:35:57 CST) built-in shell (ash)
Enter 'help' for a list of built-in commands.

# 

```

During this screen, you can start modify the firmware, look into `"firmware_file"` folder.

# Customise
You can customise the firmware by creating `custom` folder along side `qemu-test.sh`

## Folder Structure
```
─┐
 ├ [custom]
 │    ├ router.png
 │    ├ topbar.png
 │    └ [etc]
 │         ├ [init.d]
 │              └ rc*
 │         └ [scripts]
 │              └ *.sh
 └ qemu-test.sh
```

File `/etc/scripts/fix_sw_ver.sh` is special, it will injected automatically after **LINE** `/etc/insdrv.sh`

To add custom run script, please use `init.d/rc35` file

## Picture
You can change to your own image, sample project file located at `WebGui/Project Files`

### topbar.png
![topbar.png](https://github.com/Anime4000/RTL960x/raw/main/WebGui/Project%20Files/topbar.png)
### router.png
![router.png](https://github.com/Anime4000/RTL960x/raw/main/WebGui/Project%20Files/router.png)
