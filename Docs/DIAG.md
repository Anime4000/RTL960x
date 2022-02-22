# Diag
Realtek RTL9601C1 has xPON Utility called `diag`, problably can modify OMCI bandwidth control

# Known Command
Here list know useful command to troubleshoot, after entering telnet, type `diag` to enter

## View Version
```
# cat /etc/version
C00R657V00B12 --  Thu Nov 21 14:52:46 CST 2019

# diag
RTK.0> gpon show onu-info
Vendor ID   : GPON
Model ID    : G657
Gpon MAC    : 6cefc6000000
Hardware    : V1.0
Software    : C00R657V00B13
```

## L2 Table
### `l2-table get entry address valid`
This command show your valid VLAN entry wich stick going to bridge **AS IS**! If your internet come without VLAN, high chance that your OLT provision `tag to untag`, this time you need to find which VLAN is your internet access.
```
RTK.0> l2-table get entry address valid

LUT address: 0x000c (1K LUT)
L2 Unicast table:
MACAddress        Spa Fid Age Vid  State  Ext  Hash
00:00:00:01:00:02 3   0   1   0    Static 0    SVL
CtagIf Auth DaBlock SaBlock Arp
Dis    Dis  Dis     Dis     Dis

LUT address: 0x0020 (1K LUT)
L2 Unicast table:
MACAddress        Spa Fid Age Vid  State  Ext  Hash
00:00:5E:00:01:57 2   0   7   629  Auto   0    SVL
CtagIf Auth DaBlock SaBlock Arp
En     Dis  Dis     Dis     Dis

LUT address: 0x0244 (1K LUT)
L2 Unicast table:
MACAddress        Spa Fid Age Vid  State  Ext  Hash
B0:95:75:BB:BB:BB 0   0   6   822  Auto   0    SVL
CtagIf Auth DaBlock SaBlock Arp
En     Dis  Dis     Dis     Dis

LUT address: 0x0264 (1K LUT)
L2 Unicast table:
MACAddress        Spa Fid Age Vid  State  Ext  Hash
00:15:5D:C0:FF:EE 0   0   7   621  Auto   0    SVL
CtagIf Auth DaBlock SaBlock Arp
En     Dis  Dis     Dis     Dis

LUT address: 0x029c (1K LUT)
L2 Unicast table:
MACAddress        Spa Fid Age Vid  State  Ext  Hash
F0:1C:2D:22:87:C3 2   0   7   600  Auto   0    SVL
CtagIf Auth DaBlock SaBlock Arp
En     Dis  Dis     Dis     Dis

LUT address: 0x0384 (1K LUT)
L2 Unicast table:
MACAddress        Spa Fid Age Vid  State  Ext  Hash
00:00:5E:00:01:BE 2   0   6   500  Auto   0    SVL
CtagIf Auth DaBlock SaBlock Arp
En     Dis  Dis     Dis     Dis

LUT address: 0x03a8 (1K LUT)
L2 Unicast table:
MACAddress        Spa Fid Age Vid  State  Ext  Hash
00:00:5E:00:01:B5 2   0   7   621  Auto   0    SVL
CtagIf Auth DaBlock SaBlock Arp
En     Dis  Dis     Dis     Dis

LUT address: 0x03e4 (1K LUT)
L2 Unicast table:
MACAddress        Spa Fid Age Vid  State  Ext  Hash
6C:EF:C6:FF:FF:FF 3   0   1   0    Static 0    SVL
CtagIf Auth DaBlock SaBlock Arp
Dis    Dis  Dis     Dis     Dis
```

### `l2-table get vid-unmatch port all`
```
RTK.0> l2-table get vid-unmatch port all

Port 0 Action: Forward
Port 2 Action: Forward
```

## GPON Flow
### `gpon show us-flow`
```
RTK.0> gpon show us-flow
============================================================
    GPON ONU MAC U/S Flow Status
Flow ID | GEM Port | Type | TCont
      0 |      263 |  ETH |     0
      1 |      264 |  ETH |     1
      2 |      267 |  ETH |     1
      3 |      272 |  ETH |     2
     64 |        2 | OMCI |    16
============================================================
```
### `gpon show ds-flow`
```
RTK.0> gpon show ds-flow
============================================================
     GPON ONU MAC D/S Flow Status
Flow ID | GEM Port | Type | Multicast | AES
      0 |     2047 |  ETH |         * |
      1 |      263 |  ETH |           |   *
      2 |     2046 |  ETH |           |
      3 |      264 |  ETH |           |   *
      4 |      267 |  ETH |           |   *
      5 |      272 |  ETH |           |   *
     64 |        2 | OMCI |           |   *
============================================================

```
## Bandwidth
### `bandwidth get egress port all`
```
RTK.0> bandwidth get egress port all
port: 0  rate:1048568
         queue: 0  apr-index: 0
         queue: 1  apr-index: 0
         queue: 2  apr-index: 0
         queue: 3  apr-index: 0
         queue: 4  apr-index: 0
         queue: 5  apr-index: 0
         queue: 6  apr-index: 0
         queue: 7  apr-index: 0
port: 2  rate:4194296
         queue: 0  apr-index: 0
         queue: 1  apr-index: 0
         queue: 2  apr-index: 0
         queue: 3  apr-index: 0
         queue: 4  apr-index: 0
         queue: 5  apr-index: 0
         queue: 6  apr-index: 0
         queue: 7  apr-index: 0
```
### `bandwidth get ingress port all`
```
RTK.0> bandwidth get ingress port all
port: 0 rate:1048568
port: 2 rate:4194296
```

## Port
### `port get status port all`
```
RTK.0> port get status port all
Port Status Speed    Duplex TX_FC RX_FC
---- ------ -----    ------ ----- -----
0    Up     1000M    Full   Dis   Dis
2    Up     1000M    Full   Dis   Dis
```
