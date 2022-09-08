#!/bin/sh
# HiSGMII Speed: Fix upload speed when using HiSGMII mode
# By stich86

SPEED=$(flash get LAN_SDS_MODE | awk -F'=' '{print $2}')

if [ "$SPEED" == "4" ] || [ "$SPEED" == "5" ] || [ "$SPEED" == "6" ]; then
	/bin/diag bandwidth set egress port all rate 4194296
	/bin/diag bandwidth set ingress port all rate 4194296
fi