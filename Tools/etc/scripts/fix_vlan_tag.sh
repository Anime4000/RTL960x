#!/bin/sh
# VLAN Tag Fix: Fix VLAN wrong mapping
# By inyourgroove

set -e

while true; do
	omcicli mib get 84 > /tmp/84.tmp

	size=$(ls -la /tmp/ | grep 84.tmp | awk '{ print $5 }')

	if [[ "$size" -lt "88" ]]; then
		# Looks like the table is not populated yet
		sleep 30
		continue
	fi

	one_mode=$(awk '/0x1102/{nr[NR]; nr[NR+2]}; NR in nr' /tmp/84.tmp | grep FwdOp | awk '{ print $2 }')
	two_mode=$(awk '/0x110b/{nr[NR]; nr[NR+2]}; NR in nr' /tmp/84.tmp | grep FwdOp | awk '{ print $2 }')

	rm /tmp/84.tmp

	[[ $one_mode != "0x02" ]] && omcicli mib set 84 4354 FwdOp 0x02
	[[ $two_mode != "0x02" ]] && omcicli mib set 84 4363 FwdOp 0x02
	sleep 30
done;