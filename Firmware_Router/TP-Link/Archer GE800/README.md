# TP-Link Community Support

This folder contains an EEPROM for a GPON Stick that has been modified to support HiSGMII/2500Base-X, based on the Linux Kernel modifications in [`drivers/net/phy/sfp-bus.c`](https://github.com/torvalds/linux/blob/cf1182944c7cc9f1c21a8a44e0d29abe12527412/drivers/net/phy/sfp-bus.c#L327).

## EEPROM Overview
The provided EEPROM configuration allows detection of the GPON Stick with HiSGMII (SGMII+), making it compatible with devices that support higher bandwidth interfaces like 2500Base-X.

### Key EEPROM Fields
To verify that the GPON Stick supports HiSGMII (SGMII+), you can refer to the following key EEPROM fields:

| Offset | Value | Description                                         |
|--------|-------|-----------------------------------------------------|
| 0x06   | 0x00  | Indicates the stick is not defined as 1G-F/C/S/L/TX |
| 0x0c   | 0x1F  | Nominal Bit Rate set to 3100 Mbps                   |

### The offset value has been follow this `sfp-bus.c`:
```c
	/* If we haven't discovered any modes that this module supports, try
	 * the bitrate to determine supported modes. Some BiDi modules (eg,
	 * 1310nm/1550nm) are not 1000BASE-BX compliant due to the differing
	 * wavelengths, so do not set any transceiver bits.
	 *
	 * Do the same for modules supporting 2500BASE-X. Note that some
	 * modules use 2500Mbaud rather than 3100 or 3200Mbaud for
	 * 2500BASE-X, so we allow some slack here.
	 */
	if (linkmode_empty(modes) && br_nom) {
		if (br_min <= 1300 && br_max >= 1200) {
			phylink_set(modes, 1000baseX_Full);
			__set_bit(PHY_INTERFACE_MODE_1000BASEX, interfaces);
		}
		if (br_min <= 3200 && br_max >= 2500) {
			phylink_set(modes, 2500baseX_Full);
			__set_bit(PHY_INTERFACE_MODE_2500BASEX, interfaces);
		}
	}
```

## Compatibility Testing
This configuration has been tested and confirmed to work on various OpenWRT-supported devices and other networking hardware, including:

- **OpenWRT Router Boards:**
  - Banana Pi BPI-R3 with OpenWRT 23.05.2
- **Mikrotik Devices:**
  - RB5009UG+S+IN
  - RB5009UPr+S+IN
  - CCR2004-1G-12S+2XS
  - CCR2116-12G-4S+
  - CRS305-1G-4S+IN
- **ASUS Routers:**
  - ASUS RT-BE88U
- **Managed Switches:**
  - Devices using RTL8221B and RTL8372 chipsets

## Conclusion
The modified EEPROM enhances compatibility with higher-speed networking interfaces, ensuring optimal performance across a wide range of devices.
