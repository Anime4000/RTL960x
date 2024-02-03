#!/bin/sh

# RTL9601CI 2.5G bug fix:
# In order to 2.5G mode to work, it must execute default mode first, then
# 2.5G HiSGMII can be work after, it will apply flow id: "flow_id=128"
echo "=========================="
echo "Anime4000 2.5G HiSGMII Fix"
echo "=========================="
echo "Pause for few seconds to allow boot sequence to complete!"

sleep 45

lan_sds_mode=`flash get LAN_SDS_MODE | sed 's/LAN_SDS_MODE=//g'`

case "$lan_sds_mode" in
	[1-3])
		echo "$lan_sds_mode" > /proc/lan_sds/lan_sds_cfg
		;;
	4|6)
		echo 4 > /proc/lan_sds/lan_sds_cfg
		;;
	5)
		echo 5 > /proc/lan_sds/lan_sds_cfg
		;;
	*)
		echo 1 > /proc/lan_sds/lan_sds_cfg
		;;
esac

echo "=========================="
echo "Anime4000 2.5G HiSGMII Fix"
echo "=========================="
echo "2.5G HiSGMII Fix has been executed! Enjoy!"
