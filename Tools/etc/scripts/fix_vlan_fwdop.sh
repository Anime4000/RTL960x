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

# Time to apply new FwdOp
process_fwdop() {
	entid="$1"
	fwdop="$2"
	active_id=$(omcicli mib get 84 | grep '$entid' | awk '{print $2}')
	active_op=$(omcicli mib get 84 ${$entid} | grep '^FwdOp:' | awk '{print $2}')

	# Check if user given value is exist or not
	if [ -z "$active_id" ]; then
		return 1
	fi
	
	# Check FwdOp is same
	if [[ $((fwdop)) -eq $((active_op)) ]]; then
		return 0
	fi

	# Run when user value is matched with the system
	if [[ $((entid)) == $((active_id)) ]]; then
		omcicli mib set 84 "${entid}" FwdOp "${fwdop}"
	fi
}

# Function to process a pair
process_pair() {
	pair="$1"
	# If the pair doesn't contain ':', add ':0x02'
	if ! echo "$pair" | grep -q ":"; then
		pair="$pair:0x02"
	fi
	
	IFS=':' read -ra parts <<< "$pair"
	process_fwdop "${parts[0]}" "${parts[1]}"
}

# Get the FwdOp fix from unused flash property: RTK_DEVINFO_SPECVER
fix_vlan_fwdop=$(flash get RTK_DEVINFO_SPECVER | cut -d'=' -f2)

# If fix_vlan_fwdop is not set, exit
if [ -z "$fix_vlan_fwdop" ]; then
	exit 1
fi

# Split the pairs by comma and process each pair
IFS=',' read -ra pairs <<< "$fix_vlan_fwdop"
for pair in "${pairs[@]}"; do
	process_pair "$pair"
done

exit 0
