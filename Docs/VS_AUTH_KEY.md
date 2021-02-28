# Generated
If you want some quick fix your V2801F auto reboot, try these pre-generated value

| Device             | MAC Address    | `VS_AUTH_KEY`                      | `HW_HWVER`     |
|--------------------|----------------|------------------------------------|----------------|
| Xerox              | `000000ABCDEF` | `A73BF734A3348731274ACCADCF9E1E2A` | `RTL960x`      |
| Intel              | `00C2C6012345` | `B905D1A8C43571BA70A66C1B59BE2A86` | `RTL960x`      |
| Twowing TWCGPON657 | `6CEFC6000000` | `00CF646955CCBDB88AB3B68922DB810F` | `RTL960x`      |
| Twowing TWCGPON657 | `6CEFC60000FF` | `00CF646955CCBDB88AB3B68922DB810F` | `RTL960x`      |
| Twowing TWCGPON657 | `6CEFC600AA00` | `2A28776EBDA2AE4533E6E9CC4F8307E9` | `RTL960x`      |
| Twowing TWCGPON657 | `6CEFC600FF00` | `8628A251BA45CF84935891E57DF4CE87` | `RTL960x`      |
| Twowing TWCGPON657 | `6CEFC6DEAD00` | `E325EED11E4EC6505AE483DEF8C4A432` | `RTL960x`      |
| Nokia G-240G-E     | `781735D35DA0` | `4DFD2ADED74CFC990DFE675EF527D815` | `3FE48153CBAA` |
| Huawei HG8240H     | `043389FE8F59` | `4FF78A9422FCBC797A0A3061186F20B7` | `BF9.A`        |
| Huawei HG8240H5    | `D0C65BE047E8` | `F2A45DE3ADFD73916F09D9FAB84CEAE0` | `168D.A`       |

## Set!
This is example of Nokia G-240G-E ONT device information that going to applied on V2801F.

```
flash set PON_VENDOR_ID ALCL
flash set HW_CWMP_MANUFACTURER Nokia
flash set HW_CWMP_PRODUCTCLASS SFU
flash set HW_HWVER 3FE48153CBAA
flash set ELAN_MAC_ADDR 781735D35DA0
flash set VS_AUTH_KEY 4DFD2ADED74CFC990DFE675EF527D815

flash set OMCI_FAKE_OK 1
flash set OMCI_SW_VER1 3FE46606BGCB45
flash set OMCI_SW_VER2 3FE46606BGCB45
flash set GPON_ONU_MODEL G-240G-E
flash set GPON_SN ALCLFBCFD831
flash set GPON_PLOAM_PASSWD 1234567890

reboot
```

# Requests
If your Fibre provider/ISP accept only certian ONT, MAC Address & Version, you can contact me to generate new `VS_AUTH_KEY`
