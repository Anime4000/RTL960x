# TP-Link Debug/Beta Firmware Terms

The TP-Link firmware included here unlocks advanced GPON Stick features like HiSGMII and 2.5G Base-X, allowing users on 2Gbps plans to experience improved performance. By using this firmware, you automatically accept TP-Link's [terms and conditions](https://community.tp-link.com/en/home/forum/topic/275506) for debug and beta releases.


# TP-Link Archer BE900 (Ver: V1) - Enabling 2.5G Mode
This firmware is provided by [@d5aqoep](https://github.com/d5aqoep) via TP-Link Support. 

Link to original post issue [#235](https://github.com/Anime4000/RTL960x/issues/235)

**Download provided by [@d5aqoep](https://github.com/d5aqoep):**

https://www.mediafire.com/file/8x1gbe6tped9mjs/BE900v1_1.1.3_240104_SFP_beta.zip/file

![Screenshot 2024-01-04 155704](https://github.com/Anime4000/RTL960x/assets/28061422/f62f5083-d5df-420b-9377-5e6082434ff5)

To enable 2.5G (HiSGMII PHY) on your TP-Link Archer BE900, follow these steps:

1. **Update Debug Firmware:**
   - Ensure you have the latest debug-enabled firmware installed. Refer to the firmware repository for the appropriate version.

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

6. **Wait and it will auto-negotiate**


## Note:

   - The 2.5G mode activation is not persistent across power loss or router reboots. You will need to re-enter the commands after each occurrence.
   - Exercise caution when using debug features and refer to the router's documentation for additional guidance on the commands and their implications.
