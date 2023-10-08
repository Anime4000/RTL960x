#!/bin/sh
# VLAN Tag Fix: Fix VLAN wrong mapping
# By inyourgroove
# Additional configuration options added by rajkosto

set -e

VLANS=""
ENTITIES=""
FWDOP=0x02
# Allow overriding above variables from config file
if [ -s /etc/config/fix_vlan ]; then
    . /etc/config/fix_vlan
fi

FIX_ALL=0
if [ -z "$VLANS" ] && [ -z "$ENTITIES" ]; then FIX_ALL=1; fi

while true; do

  for _EntityID in $(omcicli mib get 84 | grep '^EntityID:' | awk '{print $2}'); do

    _FwdOp=$(omcicli mib get 84 ${_EntityID} | grep '^FwdOp:' | awk '{print $2}')
    if [[ $((_FwdOp)) == $((FWDOP)) ]]; then continue; fi

    _FixMe=$FIX_ALL
    if [[ ${_FixMe} -eq 0 ]]; then
        if echo "${ENTITIES}" | grep -q -o "\b${_EntityID}\b"; then
            _FixMe=1
        else
            _VlanID=$(omcicli mib get 84 ${_EntityID} | grep -o " VID [0-9]*" | awk '{print $2}')
            if echo "${VLANS}" | grep -q -o "\b${_VlanID}\b"; then
                _FixMe=1
            fi
        fi
    fi

    if [[ ${_FixMe} -eq 0 ]]; then
        continue
    fi

    omcicli mib set 84 ${_EntityID} FwdOp ${FWDOP}

  done

  sleep 30
done
