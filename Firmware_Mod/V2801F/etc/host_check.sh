#!/bin/sh
# taken from http://forum.ru-board.com/topic.cgi?forum=8&topic=80480&start=1740#19
# todo: revert LAN_SDS_MODE 1

sleep 120
while true; do
    SFP_REBOOT=$(ping -c 1 -W 1 -q 192.168.1.2 | grep -c '0 packets received')
    if [[ $SFP_REBOOT -eq 1 ]] ; then
        SFP_REBOOT=$(ping -c 3 -W 1 -i 10 -q 192.168.1.2 | grep -c '0 packets received')
        if [[ $SFP_REBOOT -eq 1 ]] ; then
            break
        fi
    fi
    sleep 180
done
reboot -d 60 
