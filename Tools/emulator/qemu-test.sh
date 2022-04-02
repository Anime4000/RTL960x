#!/bin/bash

# Anime4000 firmware test
# Purpose of this script to let you test before flash into RTL9601C1 (ONU Stick)
# Try merge or play with V2801F and TWCGPON657

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$DIR"

echo "Anime4000 firmware test for RTL9601C1"
echo "-------------------------------------"
echo ""

if [ "$EUID" -ne 0 ]
	then echo "Please run as root!"
	exit 99
fi

echo "Checking Packging: $1"
if [[ ! -f $1 && -z $1 ]]; then
    echo "$1 is not found! example: $0 C00R657V00B15_20201222.tar"
    exit 99
fi

CHDIR="squashfs-root"
FILEPATH=$(realpath $1)
FILENAME=$(basename -- $1)


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

echo "Creating folder: ${FILENAME%.*}"
mkdir ${FILENAME%.*}

echo "Entering folder: ${FILENAME%.*}"
cd ${FILENAME%.*}

echo "Extracting firmware: $FILENAME"
tar -xvf $FILEPATH

echo "Expanding squashfs-root: rootfs"
mv rootfs rootfs.original
unsquashfs rootfs.original

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

echo "RTL9601C1 Emulator is Running!"
chroot "$CHDIR" qemu-mips-static "/bin/sh"
echo "User End QEMU..."

echo "chmod +x /bin folder, prevent stick become brick!"
chmod +x "$CHDIR/bin" -R
chmod +x "$CHDIR/etc/*.sh"
chmod +x "$CHDIR/etc/init.d" -R
chmod +x "$CHDIR/etc/scripts" -R
chown 0:0 "$CHDIR/" -R

echo "Change Version Date!"
if grep -q "-" fwu_ver; then
	STICKVER=`awk -F" " '{print $1}' $CHDIR/etc/version | cut -d - -f 1`
	echo "$STICKVER-$(date +'%y%m%d') -- $(date -u +'%a %b %d %H:%I:%M %Z %Y')" > "$CHDIR/etc/version"
	echo "$STICKVER-$(date +'%y%m%d')" > fwu_ver
else
	STICKVER=`awk -F" " '{print $1}' $CHDIR/etc/version`
	echo "$STICKVER -- $(date -u +'%a %b %d %H:%I:%M %Z %Y')" > "$CHDIR/etc/version"
	echo "$STICKVER" > fwu_ver
fi

echo "Change Default LAN_SDS_MODE"
sed -i 's/<Value Name="LAN_SDS_MODE" Value="5"\/>/<Value Name="LAN_SDS_MODE" Value="1"\/>/g' "$CHDIR/etc/config_default_hs.xml"

echo "Unmounting..."
rm -rf "$CHDIR/usr/bin"

echo "Repacking squashfs-root: rootfs"
mksquashfs squashfs-root rootfs -b 131072 -comp lzma

echo "Regenerate firmware: rtl9601c1_modified.tar"
md5sum fwu.sh > md5.txt
md5sum fwu_ver >> md5.txt
md5sum rootfs >> md5.txt
md5sum uImage >> md5.txt

echo "Repacking firmware: rtl9601c1_modified.tar"
tar -cvf ../rtl9601c1_modified.tar fwu.sh fwu_ver md5.txt rootfs uImage

echo ""
echo "Firmware Repacking Complete!"
echo "Location: $(realpath ../rtl9601c1_modified.tar)"
echo ""
echo "Anime4000 firmware test script, https://github.com/Anime4000/RTL9601C1"
echo ""

exit 0
