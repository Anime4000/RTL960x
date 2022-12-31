# Setup
In this guide, how to setup your **SFP XPON ONU Stick** based on your existing ONU and get Authenticated!

Using Huawei ONU `HG8240H` device information for this setup example

# Default Password
| Model | Username | Password |
|-------|----------|----------|
| DFP-34X-2C2 | `admin` | `admin` |
| TWCGPON657  | `admin` | `system` |
| UF-Instant  | `ubnt` | `ubnt` |
| V2801F      | `admin` | `stdONU101` |

## [TWCGPON657](https://item.taobao.com/item.htm?spm=a1z09.2.0.0.c0552e8d7UBYLF&id=597031866488)
If you using **TWCGPON657** you need enable `telnet` by enter this address:
| State     | URL |
|-----------|------------------------------------------|
| `Enable`  | `http://192.168.1.1/bd/telnet_open.asp`  |
| `Disable` | `http://192.168.1.1/bd/telnet_close.asp` |

# OLT & O5
* OLT might have some **restriction** which device that can be used on their fiber network.
* OLT need to know which device are you using before sending proper OMCI even you have `O5`
* OLT can provision specific ONU LAN Port, hance OLT need to know which device.

Here ranking from most important to least
* Authentication
  * PLOAM / LOID
  * Serial Number
  * MAC Address <sub><sup>*[V2801F](#v2801f), [DFP-34X-2C2](#dfp-34x-2c2)</sup></sub>
* OMCI Device Info
  * Hardware Version <sub><sup>*[V2801F](#v2801f)</sup></sub>
  * Manufacture Info
  * Device Model
  * Software Version

It's best to clone ONU information via telnet or webgui config (backup, edit, restore)

# Get Information
You need to login into your old ONU, most ONU will have information page where you can get:
| Information | Flash Set Value | Example |
|-------------|-----------------|---------|
| MAC Address | `ELAN_MAC_ADDR` <sub><sup>*EPON user only, [V2801F](#v2801f), [DFP-34X-2C2](#dfp-34x-2c2)</sup></sub> | `781735000000` |
| Hardware Version | `HW_HWVER` <sub><sup>*[V2801F](#v2801f)</sup></sub> | `BF9.A` | 
| Software Version | `OMCI_SW_VER1`, `OMCI_SW_VER2`, `CUSTOM_OMCI_SW_VER1`, `CUSTOM_OMCI_SW_VER2` | `V3R017C10S100` |
| Serial Number | `GPON_SN` | `HWTC35000000` |
| Manufacture Info | `PON_VENDOR_ID` | `HWTC` |
| Device Model | `GPON_ONU_MODEL` | `HG8240H` |
| OUI | `OUI` | `875773` |
| Device SN | `HW_SERIAL_NO` | `UONHUWH12341234123` |

# ONU Information Page Example
## G-240G-E
![SFU](Images/G-240G-E.png)

## HG8240H
![RGW](Images/HG8240H.png)

## HG8240H5
![RGW](Images/HG8240H5.png)

# Backup Original
You may need to write down your original value
```
flash get PON_VENDOR_ID
flash get HW_CWMP_MANUFACTURER
flash get HW_CWMP_PRODUCTCLASS
flash get HW_HWVER
flash get OMCI_VEIP_SLOT_ID
flash get OMCI_OLT_MODE
flash get OMCI_FAKE_OK
flash get OMCI_SW_VER1
flash get OMCI_SW_VER2
flash get GPON_ONU_MODEL
flash get GPON_SN
flash get GPON_PLOAM_PASSWD
flash get ELAN_MAC_ADDR
flash get VS_AUTH_KEY
flash get MAC_KEY
flash get OUI
flash get HW_SERIAL_NO
```

# Update Stick
Every `flash set` require `reboot` to take effect

# Authentication
* Authenticate your XPON Stick by **PLOAM Password** or **LOID**
* Some OLT use MAC Address as authentication

## PLOAM
Commonly use by GPON network
### HEX
#### DFP-34X-2C2
```
flash set GPON_PLOAM_FORMAT 0
flash set GPON_PLOAM_PASSWD 44454641554C54303132
```
> Firmware version `220304`& above only accept HEX PLOAM Password in the telnet, if you want to set ASCII, do it in WebGUI

### ASCII
#### V2801F, TWCGPON657, UF-Instant, 
```
flash set GPON_PLOAM_PASSWD DEFAULT012
```

## LOID
Commonly use by EPON network
```
flash set LOID 0123456789
flash set LOID_PASSWD 0123456789
```

## ONU Serial Number
```
flash set GPON_SN HWTC12345678
```
*Setting this require to update Vendor ID `PON_VENDOR_ID`*

## MAC Address <sup>[*V2801F](#v2801f), [DFP-34X-2C2](#dfp-34x-2c2)</sup>
```
flash set ELAN_MAC_ADDR 000000111111
```
### Note:
1. GPON encapsulated into a GEM frame which doesn't contain any **MAC information** of PON port.
2. If your internet is Bind MAC Address, then you need change Router WAN MAC Address.
3. EPON might need change MAC Address, use V2801F stick for EPON connection


# OMCI Device Information
* Many OLT only allow **certain** or **valid** " Universal ONU " model can be use
* OLT will not up-stream OMCI provision for invalid/illegal ONU model even you have `O5` Status!
* This section make your XPON Stick become valid!

## Hardware Version <sup>[*V2801F](#v2801f)</sup>
```
flash set HW_HWVER 168D.A
```

## Manufacture Id
OLT need to know which Manufacturer are in whitelist.

Some known Vendor ID:
|   ID   | Vendor Name |
|--------|-------------|
| `HWTC` | Huawei      |
| `ZTEG` | ZTE         |
| `ALCL` | Nokia/Alcatel-Lucent |
| `UBNT` | Ubiquiti    |
| `FHTT` | Fiber Home  |
| `RTKG` | Realtek     |
| `TPLG` | TP-Link     |
| `SCOM` | Sercomm     |

```
flash set PON_VENDOR_ID HWTC
```
> Vendor ID must match with Serial Number
> 
> Some OLT have proprietary ecosystem, you must set this and enter `flash set OMCI_FAKE_OK 1`

## Device Model
```
flash set GPON_ONU_MODEL HG8240H5
```

## Software Version
```
flash set OMCI_SW_VER1 V5R019C00S125
flash set OMCI_SW_VER2 V5R019C00S125
```
> Some Stick disallow changing, if you need correct Software Version to get auth, please enter `flash set OMCI_OLT_MODE 3`
> 

## OUI
```
flash set OUI
```
Organizationally Unique Identifier. Identifies the manufacturer of the device, usually first six digit HEX of MAC Address

## Device Serial Number
```
flash set HW_SERIAL_NO
```
This different from `GPON_SN`, in Universal ONU deployment where mix and match brand. Hardware Serial Number identify which brand and which company make that ONU, so different OLT can use appropriate OMCI setting for that ONU and your fiber subscription

# OMCI Additional
## OMCI Fake `OK`
OLT may send "model specific" OMCI provision that XPON Stick not understand, setting this value making your XPON Stick send `OK` reply on unsupport OMCI
```
flash set OMCI_FAKE_OK 1
```

## OMCI OLT Mode
Make **SFP XPON ONU Stick** universal, some OLT have special OMCI, most common OMCI is Huawei, for example, making **SFP XPON ONU Stick** act like Huawei ONU and understand Huawei OMCI and compatible with Huawei OLT.

Even Nokia OLT, Huawei is most common due to "Universal ONU" deployment.

| OLT    | `OMCI_OLT_MODE` Value | OMCI Information |
|--------|-----------------------|------------------|
| Defaut | `0`  | Default info |
| Huawei | `1`  | Huawei info |
| ZTE    | `2`  | ZTE info |
| Custom | `3`  | Own info |
| Custom | `21` | Force own info by trigger `segmention fault` on **DFP-34X-2C2** default value |

```
flash set OMCI_OLT_MODE 0
```

When set own info, you need provide full custom OMCI Info:
1. `PON_VENDOR_ID`
2. `GPON_ONU_MODEL`
3. `HW_HWVER`
4. `OMCI_SW_VER1`
5. `OMCI_SW_VER2`

---

# CWMP
TR069. You can skip this if you have internet access, this may not required in most cases, some very strict OLT need

## `HW_CWMP_MANUFACTURER`
```
flash set HW_CWMP_MANUFACTURER 'Huawei Technologies Co., Ltd'
```

## `HW_CWMP_PRODUCTCLASS`
```
flash set HW_CWMP_PRODUCTCLASS HGU
```
Value can be:
| Code | Full Name               | Purpose     | Device Example  |
|------|-------------------------|-------------|-----------------|
| IGD  | Internet Gateway Device | Router      |  |
| HGU  | Home Gateway Unit       | Gateway ONT | Huawei HG8240H5, Huawei HG8145V5 |
| SFU  | Switch Fabric Unit      | Bridge ONT  | Huawei EG8010Hv6, Nokia G-240G-E |


# Summary
```
flash set GPON_PLOAM_PASSWD 0123456789
flash set GPON_SN ALCL00000000

flash set GPON_ONU_MODEL G-240G-E
flash set PON_VENDOR_ID ALCL
flash set OMCI_SW_VER1 3FE46606BGCB45
flash set OMCI_SW_VER2 3FE46606BGCB45
flash set CUSTOM_OMCI_SW_VER1 3FE46606BGCB45
flash set CUSTOM_OMCI_SW_VER2 3FE46606BGCB45

flash set HW_HWVER 3FE48153CBAA
flash set ELAN_MAC_ADDR 781735000000
flash set VS_AUTH_KEY EF0FC1A970A27D52DF340835F0561507

flash set OMCI_FAKE_OK 1
flash set OMCI_OLT_MODE 1
```

# `O5` No Internet
Multiple user report that Nokia/Alcatel OLT giving fake `O5` with `02020202` OLT Vendor Id, this making hard to troubleshoot for end-user and vendor...
More information to negate this problem, [read here](fakeO5.md)

# MAC/HW Lock
These stick mainly for commercial deployment where prevent user chaning device Id by having License Key. However, user can use on exting fiber to omit stock ONU or unlock GPON speed to 2.5Gb, for custom deployment, you may change MAC Address but not required on GPON due to Layer 3 transport omit MAC Address...

## DFP-34X-2C2
If you using `V1.0-220304` or newer firmware, changing `ELAN_MAC_ADDR` require to update `MAC_KEY`.
## Syntax
```
echo -n "hsgq1.9aMAC_ADDR_UPPERCASE" | md5sum
```

### Example
Open a Linux Terminal or Stick Telnet and do:
```
echo -n "hsgq1.9aFFFFFF000000" | md5sum
```

Return value look like this:
```
46f4ea2e3f18ba3bc1f2671b5f7e1f62  -
```

Copy and update `MAC_KEY` in telnet:
```
flash set MAC_KEY 46f4ea2e3f18ba3bc1f2671b5f7e1f62
```

## V2801F
When changing `ELAN_MAC_ADDR` and/or `HW_HWVER`, you are required to update `VS_AUTH_KEY` by using `VsAuthKeyGen.exe` in command prompt.

### Syntax:
```
VsAuthKeyGen.exe <mac_address> [HW_HWVER]
```

### Example
Open a Command Prompt where `VsAuthKeyGen.exe` is reside, example:
```
VsAuthKeyGen.exe 000000111111 168D.A
```

Return value look like this:
```
9E7E54597511D721D3A2932B048C0494
```

Copy and update `VS_AUTH_KEY` in telnet:
```
flash set VS_AUTH_KEY 9E7E54597511D721D3A2932B048C0494
```
