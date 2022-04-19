# Firmware

| Firmware | Note |
|----------|----- |
| `C00R657V00B12_20191121.tar` | `B12` @ 2019-11-21 |
| `C00R657V00B13_20191024.tar` | `B13` @ 2019-10-24 |
| `C00R657V00B13_20191205.tar` | `B13` @ 2019-12-05 |
| `C00R657V00B13_20200507.tar` | `B13` @ 2020-05-07 |
| `C00R657V00B15_20201222.tar` | `B15` @ 2020-12-22 |
| [`C00R657V2801F_V1.9.0-220404.tar`](https://github.com/Anime4000/RTL960x/raw/main/Firmware/TWCGPON657/C00R657V2801F_V1.9.0-220404.tar) | V2801F for TWCGPON657 |

# Using V2801F on TWCGPON657
* Before flash V2801F firmware you need to this first via `telnet`
	1. `flash set LAN_SDS_MODE 1`
	2. `flash set PON_MODE 3`

* Then you can update V2801F firmware via webgui
* Once firmware update finish, do this to prevent invalid key reboot:
	1. `flash set ELAN_MAC_ADDR 6CEFC6000000`
	2. `flash set HW_HWVER RTL960x`
	3. `flash set VS_AUTH_KEY 00CF646955CCBDB88AB3B68922DB810F`

* Set `PON_MODE` back to `1` GPON or `2` EPON

# Change MAC Address
If you plan to change MAC Address and/or Hardware Version, you need generate new `VS_AUTH_KEY`

You can get `VS_AUTH_KEY` keygen here:
https://drive.google.com/drive/folders/19kkrr8aHL1I5W_Poq_Y8Zd5hCpYU6H1Q

## Syntax is:
```
VsAuthKeyGen.exe <mac_address> [HW_HWVER]
```

## Example
```
VsAuthKeyGen.exe 781735000000 3FE48153CBAA
```
