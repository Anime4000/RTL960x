#!/bin/bash

# RTL Firmware QEMU Test Script
# Author: Anime4000
#
# This script provides a QEMU-based test environment for Realtek-based
# embedded firmware before deployment to physical devices.
#
# It automatically detects the target CPU architecture from the firmware
# BusyBox binary and selects the appropriate QEMU static emulator
# (MIPS, ARM, or ARM64).
#
# Supported targets include various RTL960x-based devices such as:
#  - xPON ONU SFP modules
#  - GPON/EPON ONT standalone units
#  - ONR integrated router devices
#
# This environment allows safe testing of modified firmware images,
# rootfs changes, and experimental builds prior to flashing.
#
# Typical usage:
#   1. Extract firmware root filesystem
#   2. Run this script to start the emulation environment
#   3. Verify functionality and boot behavior
#   4. Flash only after successful validation
#
# Intended for firmware development and debugging.

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$DIR"

# SquashFS builder configuration
#
# Prefer bundled mksquashfs for best compression compatibility.
# Falls back to system mksquashfs if not available.

MKSQ="../../mksquashfs"

if [ ! -x "$MKSQ" ]; then
	MKSQ=$(command -v mksquashfs) || {
		echo "Error: mksquashfs not found"
		exit 2
	}
fi

echo "RTL960x Firmware QEMU Test Environment"
echo "Anime4000 Firmware Lab"
echo "--------------------------------------"
echo ""

if [ "$EUID" -ne 0 ]; then
	echo "Please run as root!"
	exit 99
fi

if [ $# -eq 0 ]; then
	echo "Usage"
	echo "       $0<firmware> [<sw_ver>|-e]"
	echo ""
	echo "Options:"
	echo "  firmware           rtl960x firmware file in .tar format"
	echo "  sw_ver             optional, use custom software version, to use current date time as version put 0, space will truncated"
	echo "  -d                 dry run (no repack)"
	exit 99
fi

echo "Checking Packging: $1"
if [[ -z "$1" || ! -f "$1" ]]; then
	echo "Firmware file not found!"
	echo "Example:"
	echo "  $0 firmware.tar"
	exit 99
fi

CHDIR="squashfs-root"
FILEPATH=$(realpath $1)
FILENAME=$(basename -- $1)

check_tool() {
	echo "Checking tool: $1"
	command -v "$1" >/dev/null 2>&1 || {
		echo "Missing dependency: $1"
		exit 2
	}
}

check_tool binwalk
check_tool unsquashfs
check_tool file
check_tool md5sum
check_tool tar
check_tool qemu-mips-static
check_tool chroot

echo "Creating folder: ${FILENAME%.*}"
mkdir -p ${FILENAME%.*}

echo "Entering folder: ${FILENAME%.*}"
cd "$DIR/${FILENAME%.*}"

echo "Extracting firmware: $FILENAME"
tar -xvf "$FILEPATH"
echo ""

echo "Expanding squashfs-root: rootfs"
mv rootfs rootfs.original
unsquashfs rootfs.original

if [ "$2" == "-d" ]; then
	echo "rootfs has been extracted, manual packing is required if plan to flash."
	exit 0
fi

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

ARCH=""
BUSYBOX_INFO=$(file "$CHDIR/bin/busybox")

if echo "$BUSYBOX_INFO" | grep -q "aarch64"; then
	echo "Detected architecture: ARM64"
	QEMU_ARCH="qemu-aarch64-static"
	ARCH="arm64"

elif echo "$BUSYBOX_INFO" | grep -q "ARM"; then
	echo "Detected architecture: ARM"
	QEMU_ARCH="qemu-arm-static"
	ARCH="arm"

elif echo "$BUSYBOX_INFO" | grep -q "MIPS"; then
	echo "Detected architecture: MIPS"
	QEMU_ARCH="qemu-mips-static"
	ARCH="mips"

else
	echo "Error: Unable to determine firmware CPU architecture"
	echo "$BUSYBOX_INFO"
	exit 3
fi

echo "Checking: chroot QEMU"
if [ ! -f "$CHDIR/usr/bin/$QEMU_ARCH" ]; then
	echo "Installing: chroot QEMU MIPS"
	cp $(which $QEMU_ARCH) "$CHDIR/usr/bin/"
fi

echo "RTL960x Emulator is Running!"
chroot "$CHDIR" $QEMU_ARCH "/bin/sh"
echo "User End QEMU..."
trap 'rm -f "$CHDIR/usr/bin/$QEMU_ARCH"' EXIT

echo "Clean-up"
rm -f "$CHDIR/custom.sh"
rm -f "$CHDIR/home/httpd/web/.htaccess"
rm -f "$CHDIR/home/httpd/web/graphics/sagemlogo1.gif"
rm -f "$CHDIR/home/httpd/web/graphics/sagemlogo2.gif"
rm -f "$CHDIR/home/httpd/web/graphics/technxt logo.jpg"
rm -f "$CHDIR/home/httpd/web/admin/graphics/sagemlogo1.gif"
rm -f "$CHDIR/home/httpd/web/admin/graphics/sagemlogo2.gif"
rm -f "$CHDIR/home/httpd/web/admin/graphics/technxt logo.jpg"

if [ -f "$DIR/custom/topbar.png" ]; then
	echo "Custom Logo is found, patching..."
	rm "$CHDIR/home/httpd/web/graphics/topbar.gif"
	cp "$DIR/custom/topbar.png" "$CHDIR/home/httpd/web/graphics/topbar.gif"
	chmod 644 "$CHDIR/home/httpd/web/graphics/topbar.gif"
fi

if [ -f "$DIR/custom/router.png" ]; then
	echo "Custom Banner is found, patching..."
	rm "$CHDIR/home/httpd/web/graphics/router.gif"
	cp "$DIR/custom/router.png" "$CHDIR/home/httpd/web/graphics/router.gif"
	chmod 644 "$CHDIR/home/httpd/web/graphics/router.gif"
fi

echo "Symlinks same file, save space"
rm "$CHDIR/home/httpd/web/admin/graphics/router.gif"
rm "$CHDIR/home/httpd/web/admin/graphics/topbar.gif"
cd "$CHDIR/home/httpd/web/admin/graphics"
ln -s "../../graphics/topbar.gif" "topbar.gif"
ln -s "../../graphics/router.gif" "router.gif"
cd "$DIR/${FILENAME%.*}"

echo "Change Default LAN_SDS_MODE"
sed -i 's/<Value Name="LAN_SDS_MODE" Value="5"\/>/<Value Name="LAN_SDS_MODE" Value="1"\/>/g' "$CHDIR/etc/config_default_hs.xml"
sed -i 's/<title>BroadBand Device Webserver<\/title>/<title>xPON ONU BRIDGE<\/title>/g' "$CHDIR/home/httpd/web/index.html"

echo "Change Version..."
if [ -z "$2" ]; then
	echo "No custom version string is set..."
elif [ "$2" == "0" ]; then
	echo "Using current date time as version..."
	if grep -q "-" fwu_ver; then
		STICKVER=`awk -F" " '{print $1}' $CHDIR/etc/version | cut -d - -f 1`
		echo "$STICKVER-$(date +'%y%m%d') -- $(date -u +'%a %b %d %H:%I:%M %Z %Y')" > "$CHDIR/etc/version"
		echo "$STICKVER-$(date +'%y%m%d')" > fwu_ver

	else
		STICKVER=`awk -F" " '{print $1}' $CHDIR/etc/version`
		echo "$STICKVER -- $(date -u +'%a %b %d %H:%I:%M %Z %Y')" > "$CHDIR/etc/version"
		echo "$STICKVER" > fwu_ver
	fi
else
	echo "Using custom version string..."
	echo "$2 -- $(date -u +'%a %b %d %H:%I:%M %Z %Y')" > "$CHDIR/etc/version"
	echo "$2" > fwu_ver
fi

if [ -f "$DIR/custom.sh" ]; then
	echo "Execute custom.sh from outside CHROOT"
	/bin/bash "$DIR/custom.sh" "$DIR/${FILENAME%.*}/$CHDIR"
fi

if [ -d "$DIR/custom" ]; then
	echo "Injecting custom or fix scripts"
	echo "--- From $DIR/custom -to- $CHDIR"
	rsync -avhL --info=progress2 "$DIR/custom/" "$CHDIR"
fi

date +'%y%m%d' > $CHDIR/home/httpd/web/get_rel.html

if [[ ! -d "$DIR/custom" ]] || [[ ! -d "$DIR/custom1" ]]; then
	echo "Fix HTML Syntax"
	find "$CHDIR/home/httpd/web" -type f -exec sed -i 's/<BODY/<body style="font-family: Arial,Tahoma,Helvetica,sans-serif;" /g' {} +
	find "$CHDIR/home/httpd/web" -type f -exec sed -i 's/<! Copyright/<!-- Copyright/g' {} +
	find "$CHDIR/home/httpd/web" -type f -exec sed -i 's/Reserved. ->/Reserved. -->/g' {} +
fi

if [ -f "$CHDIR/etc/scripts/fix_sw_ver.sh" ]; then
	echo "Injecting software version fix scripts"
	find "$CHDIR/etc/init.d" -type f -exec sed -i 's/\/etc\/insdrv.sh/\/etc\/insdrv.sh\n\/etc\/scripts\/fix_sw_ver.sh/g' {} +
fi

echo "chmod +x /bin folder, prevent stick become brick!"
chown -R 0:0 "$CHDIR"
find "$CHDIR/bin" -type f -exec chmod +x {} +
find "$CHDIR/etc/init.d" -type f -exec chmod +x {} +
find "$CHDIR/etc/scripts" -type f -exec chmod +x {} +

if [ -d "$CHDIR/etc" ]; then
	find "$CHDIR/etc" -type f -name '*.sh' -exec chmod +x {} +
fi

if [ -d "$CHDIR/opt" ]; then
	find "$CHDIR/opt" -type f -name '*.sh' -exec chmod +x {} +
fi

echo "Unmounting..."
if [ -n "$CHDIR" ] && [ -d "$CHDIR/usr/bin" ]; then
	rm -rf "$CHDIR/usr/bin"
fi

# Extract compression and blocksize values using grep with regex
compression=$(binwalk rootfs.original | grep -oP "compression:\K[^,]+")
blocksize=$(binwalk rootfs.original | grep -oP "blocksize:\K[^,]+" | awk '{print $1}')

echo "Repacking squashfs-root: rootfs"
$MKSQ squashfs-root rootfs -comp $compression -b $blocksize -always-use-fragments -no-xattrs -noappend -no-sparse -all-root -nopad -processors 1

echo "Regenerate firmware package!"
> md5.txt

for file in *; do
	if [[ "$file" == *.original || "$file" == md5.txt || -d "$file" && "$file" == squashfs-root ]]; then
		echo "Skip $file as not wanted in firmware package!"
		continue
	fi

	md5sum "$file" >> md5.txt
done

FILENAME_FW="${FILENAME%.*}-rel$(date +'%y%m%d').tar"
if [ -f ../filename.txt ]; then
	FILENAME_FW="$(<../filename.txt)-rel$(date +'%y%m%d').image"
fi

echo "Repacking firmware: rtl960x_modified.tar"
tar -cvf ../${FILENAME_FW} --exclude='*.original' --exclude='squashfs-root' *

echo ""
echo "Firmware Repacking Complete!"
echo ""
echo " Architecture: $ARCH"
echo "  Compression: $compression"
echo "    Blocksize: $blocksize"
echo "     Firmware: $FILENAME_FW"
echo ""
echo "Anime4000 SDK, https://github.com/Anime4000"
echo ""

exit 0
