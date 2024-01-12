# Troubleshooting
If you've executed all the necessary `flash set` commands and are still experiencing connection issues, along with a misconfigured VLAN mapping, consider the following community-discovered fixes:

## `O5` No Internet
Multiple user report that Nokia/Alcatel OLT giving fake `O5` with `02020202` OLT Vendor Id, this making hard to troubleshoot for end-user and vendor...
More information to negate this problem, [read here](fakeO5.md)

## `O2`-`O5` Looping
Some OLT (Fiberhome OLT) cause GPON Stick can't get `O5`, instead of looping between `O2` to `O5`. [See issue #131](https://github.com/Anime4000/RTL960x/issues/131#issuecomment-1885032543) of the Fix

## SFU Firmware wrong VLAN
Many ISP map VLAN differently from PON Interface and ETH Interface (example: VLAN `100` > `10`). [See issue #229](https://github.com/Anime4000/RTL960x/issues/229#issuecomment-1885908940) of the fix
