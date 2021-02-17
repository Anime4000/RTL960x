#!/bin/bash

# Anime4000 firmware test
# Purpose of this script to let you test before flash into RTL9601C1 (ONU Stick)
# Try merge or play with V2801F and TWCGPON657

echo "Anime4000 firmware test for RTL9601C1"
echo "-------------------------------------"
echo ""

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
CHDIR="squashfs-root"

cd "$DIR"

if [ "$EUID" -ne 0 ]
	then echo "Please run as root"
	exit 99
fi


echo "Checking Install: QEMU User Static"
(qemu-mips-static --version) < /dev/null > /dev/null 2>&1 || {
	echo "QEMU MIPS not installed on /usr/bin"
	echo ""
	echo "To install, run:"
	echo "apt install qemu-user-static"
	exit 1
}

echo "Checking Install: chroot"
(chroot --version) < /dev/null > /dev/null 2>&1 || {
	echo "chroot not installed on /usr/sbin"
	echo ""
	echo "To install, run:"
	echo "apt install schroot"
	exit 2
}

echo "Checking Folder: squashfs-root"
if [ ! -d "$CHDIR" ]; then
	echo "$CHDIR not found"
	echo ""
	echo "To have $CHDIR (extracted rootfs), run:"
	echo "unsquashfs rootfs"
	exit 3
fi

echo "Checking: chroot /usr/bin"
if [ ! -d "$CHDIR/usr/bin" ]; then
	echo "Creating: chroot /usr/bin"
    mkdir "$CHDIR/usr/bin"
fi

echo "Checking: chroot QEMU MIPS"
if [ ! -f "$CHDIR/usr/bin/qemu-mips-static" ]; then
	echo "Installing: chroot QEMU MIPS"
	cp $(which qemu-mips-static) "$CHDIR/usr/bin/"
fi

echo "Running..."
chroot "$CHDIR" qemu-mips-static "/bin/sh"
echo "User end QEMU..."

echo "Unmounting..."
rm -rf "$CHDIR/usr/bin"

exit 0
