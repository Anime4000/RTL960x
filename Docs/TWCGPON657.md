# Flash
I have been using TWCGPON657 (without fan) for a month and never had an issue, so in this sections, flash V2801F firmware into TWCGPON657 stick and fix auto-reboot issue.

## Steps:
* `flash set PON_MODE 3` this will put stick as Ethernet mode, prevent V2801F from restart
* Downgrade your TWCGPON657 to version B13 or below.
* Flash with `V2801F_V1.9.0-201104.tar` in WebGUI
* Wait
* Update `VS_AUTH_KEY` acording to `ELAN_MAC_ADDR` and `HW_HWVER`
* Reboot
* Enjoy!

# Issue
V2801F might not support most router since it operate at PON Fiber Transceiver. EdgeRouter 12 support V2801F with EEPROM emulator support.

## Mikrotik SFP+
You need do set SFP+ like this

![WinBox](Images/sfpplus1.png)

Stick re-insert is need when stick failed

### Known model having issue
* RB4011
* RB5009
