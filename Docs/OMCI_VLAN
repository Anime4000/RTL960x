# OMCI VLAN
To find out which VLAN that Stick received, have 2 option:


# Using `omcicli`

In telnet, type this:
```
omcicli mib get 84
```

Output example:
```
XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
VlanTagFilterData
XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
=================================
EntityID: 0x1202
FilterTbl[0]: PRI 0,CFI 0, VID 621
FwdOp:  0x10
NumOfEntries: 1
=================================
=================================
EntityID: 0x1203
FilterTbl[0]: PRI 0,CFI 0, VID 821
FwdOp:  0x10
NumOfEntries: 1
=================================
=================================
EntityID: 0x1204
FilterTbl[0]: PRI 0,CFI 0, VID 822
FwdOp:  0x10
NumOfEntries: 1
=================================
=================================
EntityID: 0x120b
FilterTbl[0]: PRI 0,CFI 0, VID 621
FilterTbl[2]: PRI 0,CFI 0, VID 821
FilterTbl[4]: PRI 0,CFI 0, VID 822
FwdOp:  0x10
NumOfEntries: 3
=================================
=================================
EntityID: 0xe102
FilterTbl[0]: PRI 0,CFI 0, VID 209
FwdOp:  0x10
NumOfEntries: 1
=================================
=================================
EntityID: 0xe10b
FilterTbl[0]: PRI 0,CFI 0, VID 209
FwdOp:  0x10
NumOfEntries: 1
=================================
```

# Using `diag`

In telnet, enter `diag` utility:
```
diag
```

Then type:
```
l2-table get entry address valid
```

Output example:
```
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

## DFP-34X-2C2 in Router Mode
`valid` parameter is not availe on in `DFP-34X-2C2` you need run this script inside telnet:

```sh
#!/bin/sh
# author: anime4000
# filename: /bin/get-l2
i=0
max=2047
while [ $i -lt $max ]
do
    if diag l2-table get entry address $i | grep -q "LUT"; then
        diag l2-table get entry address $i
    fi
    true $(( i++ ))
done
echo "DONE! L2 Table Print Valid"
```
