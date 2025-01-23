#!/bin/bash

# Anime4000 firmware test
# Purpose of this script to let you test before flash into RTL960x (ONU Stick)
# Try merge or play with V2801F and TWCGPON657

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$DIR"

echo "Anime4000 firmware test for RTL960x"
echo "-----------------------------------"
echo ""

if [ "$EUID" -ne 0 ]; then
	echo "Please run as root!"
	exit 99
fi

if [ $# -eq 0 ]; then
	echo "Usage"
	echo "       $0 <firmware> <sw_ver>"
	echo ""
	echo "Options:"
	echo "  firmware           rtl960x firmware file in .tar format"
	echo "  sw_ver             optional, use custom software version, to use current date time as version put 0, space will truncated"
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

echo "Checking Install: binwalk"
(binwalk --help) < /dev/null > /dev/null 2>&1 || {
	echo "binwalk not installed on /usr/sbin"
	echo ""
	echo "To install, run:"
	echo "apt install binwalk"
	exit 2
}

echo "Creating folder: ${FILENAME%.*}"
mkdir ${FILENAME%.*}

echo "Entering folder: ${FILENAME%.*}"
cd "$DIR/${FILENAME%.*}"

echo "Extracting firmware: $FILENAME"
tar -xvf "$FILEPATH"

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

echo "RTL960x Emulator is Running!"
chroot "$CHDIR" qemu-mips-static "/bin/sh"
# chroot "$CHDIR" qemu-aarch64-static "/bin/sh"
echo "User End QEMU..."

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

date +'%y%m%d' > $CHDIR/home/httpd/web/get_rel.html

if [ -d "$DIR/custom" ]; then
	echo "Injecting custom or fix scripts"
	echo "--- From $DIR/custom -to- $CHDIR"
	rsync -avhL --info=progress2 "$DIR/custom/" "$CHDIR"
fi

if [ -f "$DIR/custom.sh" ]; then
    echo "Execute custom.sh from outside CHROOT"
    /bin/bash "$DIR/custom.sh" "$DIR/${FILENAME%.*}/$CHDIR"
fi

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
chown 0:0 "$CHDIR/" -R
chmod +x "$CHDIR/bin/" -R
chmod +x "$CHDIR/etc/init.d/" -R
find "$CHDIR/etc/" -type f -name "*.sh" -exec chmod +x {} \;

echo "chmod +x /etc/scripts_mod folder, allow your own script to run!"
if [[ -d "$CHDIR/etc/scripts_mod" ]]; then
	chmod -R +x "$CHDIR/etc/scripts_mod/"
fi

echo "Unmounting..."
rm -rf "$CHDIR/usr/bin"

# Extract compression and blocksize values using grep with regex
compression=$(binwalk rootfs.original | grep -oP "compression:\K[^,]+")
blocksize=$(binwalk rootfs.original | grep -oP "blocksize:\K[^,]+" | awk '{print $1}')

echo "Repacking squashfs-root: rootfs"
mksquashfs squashfs-root rootfs -comp $compression -b $blocksize

echo "Regenerate firmware package!"
> md5.txt

for file in *; do
    if [[ "$file" == *.original || "$file" == md5.txt || -d "$file" && "$file" == squashfs-root ]]; then
        echo "Skip $file as not wanted in firmware package!"
        continue
    fi

    md5sum "$file" >> md5.txt
done

echo "Repacking firmware: rtl960x_modified.tar"
tar -cvf ../${FILENAME%.*}_rel$(date +'%y%m%d').tar --exclude='*.original' --exclude='squashfs-root' *

echo ""
echo "Firmware Repacking Complete!"
echo "Location: $(realpath ../${FILENAME%.*}-rel$(date +'%y%m%d').tar)"
echo ""
echo "Anime4000 firmware test script, https://github.com/Anime4000/RTL9601C1"
echo ""

exit 0
