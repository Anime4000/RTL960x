#!/bin/sh
# VLAN Tag Fix: Fix VLAN wrong mapping
# By inyourgroove
# Additional VID check if config file is not empty by rajkosto

set -e
configFname='/etc/config/fix_vlan'

while true; do

  for _EntityID in $(omcicli mib get 84 | grep '^EntityID:' | awk '{print $2}'); do

    _FwdOp=$(omcicli mib get 84 ${_EntityID} | grep '^FwdOp:' | awk '{print $2}')

    if [[ ! -z ${_FwdOp} && ${_FwdOp} != '0x02' ]]; then
      if [ -s "$configFname" ]; then #only change FwdOp VIDs specified in the file
        _VlanId=$(omcicli mib get 84 ${_EntityID} | grep -o " VID [0-9]*" | awk '{print $2}')
	if ! grep -o "\b${_VlanId}\b" "$configFname" > /dev/null; then
          continue
        fi
      fi
      
      omcicli mib set 84 ${_EntityID} FwdOp 0x02
    fi

  done

  sleep 30
done
