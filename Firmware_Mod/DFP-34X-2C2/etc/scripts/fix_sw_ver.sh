#!/bin/sh
# Software Version: Allow user to use custom Software Version when using ODI Stick
# By stich86, Anime4000

OLT_MODE=$(flash get OMCI_OLT_MODE | awk -F'=' '{print $2}')
SWVER0=$(/bin/nv getenv sw_custom_version0 | awk -F'=' '{print $2}')
SWVER1=$(/bin/nv getenv sw_custom_version1 | awk -F'=' '{print $2}')

# Check if custom nv value is exist
if [ -z "$SWVER0" ]; then
	SWVER0=$(/bin/nv getenv sw_version0 | awk -F'=' '{print $2}')
fi
if [ -z "$SWVER1" ]; then
	SWVER1=$(/bin/nv getenv sw_version1 | awk -F'=' '{print $2}')
fi

# Apply custom Software Version when using OMCI_OLT_MODE 3
if [ "$OLT_MODE" == "3" ]; then
	flash set OMCI_SW_VER1 $SWVER0
	flash set OMCI_SW_VER2 $SWVER1
fi
