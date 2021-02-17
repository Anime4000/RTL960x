#!/bin/sh
chmod +x ./omci_app
./omci_app -s HWTC93995D9F -f off -m disable -d high -t bridge -p 0005816552 -iot_vt 0 -iot_vm 255 -iot_vid 65535 -iot_pri 255 -slot_veip 3585
