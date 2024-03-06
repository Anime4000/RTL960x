# Preface

ISP specific configuration known to work with the SFP GPON sticks. These are
are **not** definitive and serve only as a starting point for your specific
configuration. **Do not blindly copy and paste the configuration stanzas.**

See [FLASH_GETSET_INFO](/Docs/FLASH_GETSET_INFO.md) for more info about these
config variables.

See [stick setup](/Docs/Setup_Stick.md) to get your specific ONT values.

# PLDT

Country: Philippines

## Equipment info

* Unit: DFP-34X-2C2, Realtek variant
* Firmware: [M110_sfp_ODI_220923F](https://github.com/rajkosto/RTL960x/blob/main/Firmware/DFP-34X-2C2/M110_sfp_ODI_220923F.tar) (the FS variant _might_ work)
* Mode: IGD/HGU
* Account is officially bridged with PLDT

Use of SFU firmware will cause an `O2`->`O5` loop, cause is unknown so far.

## Configuration

Configure with telnet or SSH. Substitute with values of your stock ONT.

```
flash set HW_SERIAL_NO <sfp serial>
flash set HW_CWMP_MANUFACTURER fiberhome
flash set OUI <OUI>
flash set GPON_SN <SN>
flash set HW_HWVER <HWVER>
flash set PON_VENDOR_ID FHTT
flash set OMCI_OLT_MODE 3
flash set OMCI_SW_VER1 RP2841
flash set OMCI_SW_VER2 RP2841
flash set GPON_ONU_MODEL HG6245D
flash set LOID <LOID>
flash set LOID_PASSWD <LOID_PASSWORD>
flash set ELAN_MAC_ADDR <ONU mac addr>
flash set MAC_KEY <see docs>
flash set WAN_PHY_PORT 0
```

Typically `LOID_PASSWD` is the same value as `LOID` for them.

[PON WAN](http://192.168.1.1/multi_wan_generic.asp) **must not** have any links
configured. Delete all PON WAN interfaces available.

Data VLAN is untagged by default, other VLANs like voice are tagged. This can be
verified by connecting the stick directly to your computer and running `tcpdump`
or Wireshark.
