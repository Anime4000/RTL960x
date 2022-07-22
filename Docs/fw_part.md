# Firmware Partition
Most GPON ONU has 2 firmware partition, it can be same version or different or isp version, xPON standard require any xPON ONU to have 2 firmware partition that can be switch by OLT

# RTL960x
Realtek ONU SFP also have 2 parition which is can be switch between version or roll back previous firmware

When you update a firmware, new firmware will be updated on inactive partition, for example:
* Current active partiton id `0`
* Update firmware at partition id `1`
* 
or
* Current active partiton id `1`
* Update firmware at partition id `0`

Firmware update never replace active patition!

# Command
Login into `telnet`

## Check Active Partition Id
```
nv getenv sw_commit
```
* If `sw_commit` return `0`, [click here](#sw_commit0)
* If `sw_commit` return `1`, [click here](#sw_commit1)

## `sw_commit=0`
Do this to switch back:
```
nv setenv sw_commit 1
nv setenv sw_active 1
reboot
```

## `sw_commit=1`
```
nv setenv sw_commit 0
nv setenv sw_active 0
reboot
```
