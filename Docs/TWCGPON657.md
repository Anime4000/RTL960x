# Flash
I have been using TWCGPON657 (without fan) for a month and never had an issue, so in this sections, flash V2801F firmware into TWCGPON657 stick and fix auto-reboot issue.

## Steps:
* Downgrade your TWCGPON657 to version B13 or below.
* Flash with `V2801F_V1.9.0-201104.tar` and wait.
* Quickly login and execute `echo 3 > /proc/fiber_mode` to avoid auto-reboot (invalid `VS_AUTH_KEY`)
* Disconnect fiber from module to restore telnet
* Update `VS_AUTH_KEY` acording to `ELAN_MAC_ADDR` and `HW_HWVER`
* Reboot (in telnet)
* Reflash again with `V2801F_V1.9.0-201104.tar` (must do after fix `VS_AUTH_KEY`)
* Enjoy!
