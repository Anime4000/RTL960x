## TP-Link Debug/Beta Firmware Terms

The TP-Link firmware included here unlocks advanced GPON Stick features like HiSGMII and 2.5G Base-X, allowing users on 2Gbps plans to experience improved performance. By using this firmware, you automatically accept TP-Link's [terms and conditions](https://community.tp-link.com/en/home/forum/topic/275506) for debug and beta releases.

# TP-Link Community Support
This folder contains an Debug Firmware & EEPROM for a GPON Stick that has been modified to support HiSGMII/2500Base-X, based on the Linux Kernel modifications in [`drivers/net/phy/sfp-bus.c`](https://github.com/torvalds/linux/blob/cf1182944c7cc9f1c21a8a44e0d29abe12527412/drivers/net/phy/sfp-bus.c#L327).

## TP-Link Archer GE800 - Enabling 2.5G Mode
To enable 2.5G (HiSGMII PHY) on your TP-Link Archer GE800, follow these steps:

1. **Update Debug Firmware:**
   - Ensure you have the latest debug-enabled firmware installed. Refer to the firmware repository for the appropriate version. <br>*Take note that if your router come with latest version than this, downgrading is not possible, high probably the latest firmware already support it.*

2. **Reboot:**
   - Reboot your router to apply the updated firmware.

3. **Login to WebGUI:**
   - Access the router's Web Graphical User Interface (WebGUI) by navigating to `http://192.168.0.1`.

4. **Access Debug Page:**
   - Navigate to `http://192.168.0.1/webpages/debug.html` within the WebGUI.

5. **Enter Commands:**
   - Enter the following commands to enable 2.5G (HiSGMII PHY):
      ```plaintext
      combo_debug stop
      combo_debug set plus
      combo_debug ipg_set combo10g 1_192bit
      ```

   - To revert back to 1Gbps, use the following command:
      ```plaintext
      combo_debug ipg_set combo10g 1
      ```
6. **Wait and it will auto-negotiate**
![Untitled-1](https://github.com/user-attachments/assets/2ff2c643-8b5a-4e14-970c-0cdcd50c27b2)
*if you set WAN to Static to `192.168.1.2/24` to access GPON WebGUI from your LAN via NAT, you can view GPON WebGUI.*

### Note:
   - The 2.5G mode activation is not persistent across power loss or router reboots. You will need to re-enter the commands after each occurrence.
   - Exercise caution when using debug features and refer to the router's documentation for additional guidance on the commands and their implications.

### Troubleshoot
![GE800_PORT](https://github.com/user-attachments/assets/4deae770-32ad-432b-b28d-df707fc654ee)

Before using GPON Stick, make sure use old ONT in bridge mode then setup GE800 the usual way
once you have internet, unplug the ONT Ethernet cable and plug GPON Stick then switch combo to SFP,
once have internet via GPON Stick at 1000Mbps, proceed to debug command and enter the command above to set 2500Mbps HiSGMII

## EEPROM Configuration Overview
Based on the SFF-8024, SFF-8431, and SFF-8472 standards, there is **no officially** defined transceiver code for 1310nm/1550nm 2500Base-X. Therefore, **Byte 6** is set to `0x00` to indicate that no specific transceiver type is defined, and **Byte 12** is set to `0x1F` to signal a nominal bit rate of 2500 Mbps, supporting 2500Base-X.

The provided EEPROM binary example allows for the detection of a GPON Stick with HiSGMII (SGMII+), commonly used for GPON ONT applications.

### Key EEPROM Fields

To confirm that the GPON Stick supports HiSGMII (SGMII+), refer to the following key EEPROM fields:

| Offset | Value | Description                                         |
|--------|-------|-----------------------------------------------------|
| 0x06   | 0x00  | Transceiver code undefined (not limited to 1G Ethernet) |
| 0x0C   | 0x1F  | [Nominal bit rate set to 2500 Mbps](https://github.com/Anime4000/RTL960x/discussions/250#discussion-6288339) (supporting 2500Base-X) |

These settings ensure compatibility with 2500Base-X and allow the GPON Stick to be detected and configured correctly in network environments using HiSGMII (SGMII+).

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
This configuration has been tested and confirmed to work on various OpenWRT-supported devices and other networking hardware.

## Conclusion
The modified EEPROM enhances compatibility with higher-speed networking interfaces, ensuring optimal performance across a wide range of devices.
