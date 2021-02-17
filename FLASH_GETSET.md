# Clearing Up
* Original author have **abandoned** DFP-34G-2C2 (ZTE) and moved to Realtek
* Take not that V2801F using Realtek SoC `RTL9601C1`, not `RTL8672`
* `RTL8672` is ADSL Modem, `/proc/cpuinfo` reported wrong.
* `RTL9601C1` consider stable, active development and large user base

# Telnet Command:
## [V2801F](https://www.amazon.com/Universal-Stick-Address-Supported-Attention/dp/B08C818JSQ)
```
Username: admin
Password: stdONU101
```
## [TWCGPON657](https://m.tb.cn/h.4SH0V53?sm=d46315)
Telnet is disabled by default, you need open Enable Link to Enable Telnet
```
http://192.168.1.1/bd/telnet_open.asp
```

You can disable Telnet for added security
```
http://192.168.1.1/bd/telnet_close.asp
```
Login info as below
```
Username: admin
Password: system
```
# Flash Command (default)
```
flash set OMCI_OLT_MODE 0
flash set OMCI_FAKE_OK 0
flash set OMCI_TM_OPT 2
flash set VLAN_CFG_TYPE 0
flash set VLAN_MANU_MODE 0
flash set DIRECT_BRIDGE_MODE 1
flash set PON_MODE 1
flash set PON_VENDOR_ID GPON
flash set GPON_ONU_MODEL IGD
flash set GPON_SN GPONC6FFFFFF
flash set GPON_PLOAM_PASSWD 1234567890
flash set ELAN_MAC_ADDR 6cefc6ffffff
flash set FIBER_MODE 0
flash set DEVICE_TYPE 0
flash set OMCI_VEIP_SLOT_ID 255
reboot
```

## Explaination
### `OMCI_OLT_MODE` (Min 0, Max 3, Default is 0)
Configure how ONT Stick handle OMCI from OLT:
* 0 = Default Mode
* 1 = Huawei OLT Mode
* 2 = ZTE OLT Mode
* 3 = Customized Mode 

### `OMCI_FAKE_OK` (0 = Disable, 1 = Enable, Default is 0)
Some Fiber Vendor/Wholesale/ISP have explicit LAN Port Number provisioning or proprietary OMCI that ONT Stick cant not understand, this will make ONT Stick reply `OK` whatever OMCI OLT throw at!

### `OMCI_TM_OPT` (Min 0, Max 2, Default is 2)
Configure OMCI Traffic Management, not info about these value. 

### `VLAN_CFG_TYPE` (Min 0, Max 1, Default is 0)
VLAN Configuration Type:
* 0 = Auto Detect
* 1 = Manual (which require `VLAN_MANU_MODE` to set)

### `VLAN_MANU_MODE` (Min 0, Max 3, Default is 0)
How ONU Stick handle VLAN from PON to ETH interface
* 0 = Transparent Mode
* 1 = Tagging Mode
* 2 = Remote Access Mode
* 3 = Special Case Mode

### `DIRECT_BRIDGE_MODE` (Min 0, Max 1, Default is 1)
Not sure about this, it seem PON interface bridged to LAN under one `br0` ?

### `PON_MODE` (Min 1, Max 3, Default is 1)
Configure ONT Stick in which mode:
* 1 = GPON
* 2 = EPON
* 3 = Ethernet

### `PON_VENDOR_ID` (4 ASCII character maximum)
Need to set for OLT Authenticate your ONT stick, please read your original ONT Serial Number, either in HEX digit or ASCII, if in HEX digit, you need convert first eight HEX digit to ASCII, for example `48575443` = `HWTC`. Here some popular list if want to fool the OLT: `ALCL`, `CCCC`, `CPGO`, `GPON`, `HWTC`, `UBNT`, `ZTEG`.

### `GPON_ONU_MODEL` (8 ASCII character maximum)
Need to set for OLT Authenticate your ONT stick, enter your original ONT Model, Example: `HG8240H5`

### `GPON_SN` (12 ASCII character maximum)
Need to set for OLT Authenticate your ONT stick, enter your original ONT Serial Number, must be ASCII form `HWTC12345678`, you may need to convert first eight HEX digit serial number to ASCII, just like `PON_VENDOR_ID`

### `GPON_PLOAM_PASSWD` (9 Alphanumeric character maximum?)
Need to set for OLT Authenticate your ONT stick, you can get from original ONT WebGUI.

### `ELAN_MAC_ADDR` (12 Hexadecimal number maximum)
Some OLT have explicit MAC Address can register, you need clone your original ONT MAC Address

### `FIBER_MODE` (Min 1, Max 3, Default is 0)
If `PON_MODE=3` is set, `FIBER_MODE` become available and update `/proc/fiber_mode`.
* 0 = Pre-defined
* 1 = AN 1G
* 2 = Auto
* 3 = Force 1G
* 4 = Force 100M

### `DEVICE_TYPE` (Min 0, Max 2, Default is 0)
* 0 = `bridge`
* 1 = `router`
* 2 = `hybrid` (both)

### `OMCI_VEIP_SLOT_ID` (Integer Value, Default is 255)
Virtual Ethernet Interface Point Slot Id, you may need find VEIP Id from old ONU, try save configuration and find `veip`, for example: [Huawei HG8240H5](https://github.com/Anime4000/Hacking_Huawei_HG8240H5_ONT/blob/master/xml/hw_ctree.xml#L109)

## NOTE:
every `flash set` need `reboot` to take effect!

It's better that you download and save configuration,
edit `config.xml` accordingly, it's better to empty value `""` if not required,
then upload modified `config.xml` back.