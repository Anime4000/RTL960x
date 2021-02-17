# Clone ONU Info
Some ISP have restriction how ONU get authenticated, in this guide, how to get old ONU Info and update to ONU Stick

# Get Info
You need to login into old ONU, most ONU will have information page where you can get:
* Software Version
* Hardware Version
* Serial Number (SN)
* Manufacture Info
* Device Type

## Example
### G-240G-E
![SFU](Images/G-240G-E.png)

### HG8240H
![RGW](Images/HG8240H.png)

### HG8240H5
![RGW](Images/HG8240H5.png)

## Update
After you get required info, you can start run `flash set`, example:
```
flash set PON_VENDOR_ID ALCL
flash set HW_CWMP_MANUFACTURER Nokia
flash set HW_CWMP_PRODUCTCLASS SFU
flash set HW_HWVER 3FE48153CBAA

flash set OMCI_VEIP_SLOT_ID 255
flash set OMCI_OLT_MODE 1
flash set OMCI_FAKE_OK 1
flash set OMCI_SW_VER1 3FE46606BGCB45
flash set OMCI_SW_VER2 3FE46606BGCB45
flash set GPON_ONU_MODEL G-240G-E
flash set GPON_SN ALCL00000000
flash set GPON_PLOAM_PASSWD 1234567890

flash set ELAN_MAC_ADDR 781735000000
```

## Original
You may need to write down your original value:
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
```
