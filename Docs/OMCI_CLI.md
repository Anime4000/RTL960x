# OMCI MIB (Management Information Base)
Enter these command in telnet, `omcicli` is a binary file (`/bin/omcicli`) to check or set MIB

# Print All
Make sure you set your putty or Terminal to save output log, copy these and paste it
```
for ME in 00002 00005 00006 00007 00011 00024 00045 00047 00049 00050 00052 00078 00079 00083 00084 00089 00130 00131 \
00133 00134 00136 00137 00148 00157 00158 00171 00240 00244 00245 00248 00249 00250 00253 00255 00256 00257 00262 00263 \
00264 00266 00267 00268 00272 00273 00274 00277 00278 00280 00281 00284 00287 00296 00298 00307 00308 00309 00310 00311 \
00312 00321 00322 00329 00330 00334 00340 00341 65282 65294 65408 65527 65528 65529 65530 65531 74; do echo -e "\n\nMIB:" \
$ME"\n\n";omcicli mib get $ME; done;
```

# Important
## Verify Circuit Pack
`omcicli mib get 6`

## Verify software version
`omcicli mib get 7`

## Ethernet Provisioning
`omcicli mib get 11`
> also define as `4-port Emulation` set Administrative State (`AdminState`) to 0 to prevent OLT disable LAN ports

## Verify VLAN Tag Filter
`omcicli mib get 84`
> This allow to see PON VLAN and ETH VLAN

## Verify OLT vendor ID
`omcicli mib get 131`

## Extended VLAN config
`omcicli mib get 171`
> This allow to see VLAN mapping either 1:1 or 1:any

## Verify ONT attributes part 1
`omcicli mib get 256`

## Verify ONT attributes part 2
`omcicli mib get 257`

## Check T-CONT
`omcicli mib get 262`

## Unig ? (VEIP)
`omcicli mib get 264`

## Check Priority Queues
`omcicli mib get 277`

## McastOperProf
`omcicli mib get 309`
> You can find VLANs used for IPTV multicast traffic here

## VEIP
`omcicli mib get 329`
