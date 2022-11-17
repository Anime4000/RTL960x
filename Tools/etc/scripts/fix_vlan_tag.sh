#!/bin/sh
# VLAN Tag Fix: Fix VLAN wrong mapping
# By inyourgroove

set -e

while true; do

  for _EntityID in $(omcicli mib get 84 | grep '^EntityID:' | awk '{print $2}'); do

    _FwdOp=$(omcicli mib get 84 ${_EntityID} | grep '^FwdOp:' | awk '{print $2}')

    if [[ ! -z ${_FwdOp} && ${_FwdOp} != '0x02' ]]; then
      omcicli mib set 84 ${_EntityID} FwdOp 0x02
    fi

  done

  sleep 30
done
