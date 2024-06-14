# Firmware

| Firmware | Note |
|----------|----- |
| [`V2801F_V1.9.0-240614.tar`](https://github.com/Anime4000/RTL960x/raw/main/Firmware/V2801F/V2801F_V1.9.0-240614.tar) | Modern WebGUI, 2.5GbE, patched `runlansds.sh`, `tftpd`, ... |

# Upgrading
* Before upgrade to `V1.9.0-240614` firmware, you need to this first via `telnet`
	1. `flash set LAN_SDS_MODE 1`

# 2.5GbE
* `V1.9.0-240614` firmware have ability to run 2.5GbE
* WARNING: Incompatible `LAN_SDS_MODE` may lock you out from accessing! You need UART to change the value...

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
