#!/bin/sh

# This script will run once, require to run inside scripts_mod (unified global infinite loop)
# to systematically loop at proper pace and reduce MIPS cpu usage

# VLAN Tag Fix: Fix VLAN wrong mapping
# By inyourgroove
# Additional configuration options added by rajkosto
# Further modification by Anime4000, moving to unified modded scripts

# perhaps use unused flash get (example: RTK_DEVINFO_SPECVER) to allow
# edit via WebGUI

set -e

# Get the FwdOp fix from unused flash property: RTK_DEVINFO_SPECVER
fix_vlan_fwdop=$(flash get RTK_DEVINFO_SPECVER | awk -F'=' '{print $2}')

# If fix_vlan_fwdop is not set, exit
if [ -z "$fix_vlan_fwdop" ]; then
    exit 1
fi

# Split the pairs by comma and process each pair
echo "$fix_vlan_fwdop" | awk -F',' '{for(i=1;i<=NF;i++) print $i}' | while read -r pair; do

    # If the pair doesn't contain ':', add ':0x02'
    if ! echo "$pair" | grep -q ":"; then
        pair="$pair:0x02"
    fi

    # Split the pair
    entid=$(echo "$pair" | awk -F':' '{print $1}')
    fwdop=$(echo "$pair" | awk -F':' '{print $2}')

    # Get current
	active_id=$(omcicli mib get 84 | grep $entid | awk '{print $2}')
	active_op=$(omcicli mib get 84 $entid | grep '^FwdOp:' | awk '{print $2}')

    echo "[Inputs] EntityID: $entid, FwdOp: $fwdop"
    echo "[Active] EntityID: $active_id, FwdOp: $active_op"

    # Check if user given value is exist or not
    if [ -z "$active_id" ]; then
        echo "[Status] Given user EntityID ($active_id) is not found!"
        continue
    fi

    # Check FwdOp is same
    if [[ $((fwdop)) == $((active_op)) ]]; then
        echo "[Status] Given user input and active is equal!"
        continue
    fi

    echo "[Status] Overriding $entid with FwdOp $fwdop"
    omcicli mib set 84 $entid FwdOp $fwdop
done

exit 0
