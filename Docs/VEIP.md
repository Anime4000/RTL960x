# `flash set OMCI_VEIP_SLOT_ID` Configuration

Reference: [GitHub Issue Comment by rajkosto](https://github.com/Anime4000/RTL960x/issues/107#issuecomment-1352368166)

## Overview

The `flash set OMCI_VEIP_SLOT_ID` command controls the Virtual Ethernet Interface Point (VEIP) Slot ID within the Optical Network Unit (ONU) configuration. While your initial description provides a starting point, the GitHub user has contributed additional insights to enhance the understanding and usage of this command.

## Parameters

- **VEIP EntityID Calculation:** The value for `OMCI_VEIP_SLOT_ID` should be set to the Most Significant Bit (MSB) of the desired VEIP EntityID. For example, if the VEIP EntityID is `0x0e01`, set `OMCI_VEIP_SLOT_ID` to `0x0e` or `14` (decimal).

## Enabling Customized VEIP Slot ID

The GitHub user emphasizes that the feature to apply the custom VEIP Slot ID is not enabled by default. To activate this feature, follow these steps:

1. Set bit `0x100` in `OMCI_CUSTOM_ME` to enable the `cf_apply_customized_veip_slot_id` feature.
2. The default value in SFU firmwares for `OMCI_CUSTOM_ME` is `65536`. Set it to `65792` to enable the feature.

## Before Configuration Example:

```bash
# omcicli mib get 329
XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
VEIP
XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
=================================
EntityId: 0x0601
AdminState: 1
OperState: 1
InterDomainName: 0x00000000000000000000000000000000000000000000000000
TcpUdpPtr: 0x0000
IansAssignPort: 0
CustomizedSlotId: 0xff
=================================
```

## After Configuration Example:

```bash
# omcicli mib get 329
XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
VEIP
XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
=================================
EntityId: 0x0e01
AdminState: 1
OperState: 1
InterDomainName: 0x00000000000000000000000000000000000000000000000000
TcpUdpPtr: 0x0000
IansAssignPort: 0
CustomizedSlotId: 0x0e
=================================
```

Take note on `EntityId` and `CustomizedSlotId`

---

# Understanding the Transformation: `65536` to `65792`

In the context of configuring the Optical Network Unit (ONU) using the `flash set OMCI_VEIP_SLOT_ID` command, there is a specific parameter called `OMCI_CUSTOM_ME` that plays a crucial role. The GitHub user [@rajkosto](https://github.com/rajkosto) recommends setting a bit, specifically bit `0x100`, in the `OMCI_CUSTOM_ME` to enable a particular feature (`cf_apply_customized_veip_slot_id`).

## Initial Value of `OMCI_CUSTOM_ME`: `65536`

The default value for `OMCI_CUSTOM_ME` in SFU firmwares is given as `65536`. This value is represented in hexadecimal as `0x10000`.

## Adding `0x100` to Enable the Feature

To enable the `cf_apply_customized_veip_slot_id` feature, it is necessary to set bit `0x100` in `OMCI_CUSTOM_ME`. Adding `0x100` to the initial value transforms it as follows:

```plaintext
  Initial Value: 0x10000 (65536 in decimal)
+  Bit Addition: 0x00100
  _______________________
  Result:        0x10100 (65792 in decimal)
```

## Final Value of `OMCI_CUSTOM_ME`: `65792`

Therefore, by adding `0x100` to the default value of `OMCI_CUSTOM_ME`, the final value becomes `65792`. This modified value activates the feature, allowing the `cf_apply_customized_veip_slot_id` functionality in the ONU configuration.

Understanding this transformation is crucial for users who wish to customize and enable specific features related to the VEIP Slot ID configuration.

More ME feature bits can [get here](https://gist.github.com/rajkosto/79034a1f7b3de3f40edf50ffbd8396b0)

---

> This has been processed by ChatGPT for more easy to understand, you need to understand Hexadecimal first.
