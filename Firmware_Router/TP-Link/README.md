```
BusyBox v1.19.4 (2023-12-05 15:52:32 CST) built-in shell (ash)
Enter 'help' for a list of built-in commands.

     MM           NM                    MMMMMMM          M       M
   $MMMMM        MMMMM                MMMMMMMMMMM      MMM     MMM
  MMMMMMMM     MM MMMMM.              MMMMM:MMMMMM:   MMMM   MMMMM
MMMM= MMMMMM  MMM   MMMM       MMMMM   MMMM  MMMMMM   MMMM  MMMMM'
MMMM=  MMMMM MMMM    MM       MMMMM    MMMM    MMMM   MMMMNMMMMM
MMMM=   MMMM  MMMMM          MMMMM     MMMM    MMMM   MMMMMMMM
MMMM=   MMMM   MMMMMM       MMMMM      MMMM    MMMM   MMMMMMMMM
MMMM=   MMMM     MMMMM,    NMMMMMMMM   MMMM    MMMM   MMMMMMMMMMM
MMMM=   MMMM      MMMMMM   MMMMMMMM    MMMM    MMMM   MMMM  MMMMMM
MMMM=   MMMM   MM    MMMM    MMMM      MMMM    MMMM   MMMM    MMMM
MMMM$ ,MMMMM  MMMMM  MMMM    MMM       MMMM   MMMMM   MMMM    MMMM
  MMMMMMM:      MMMMMMM     M         MMMMMMMMMMMM  MMMMMMM MMMMMMM
    MMMMMM       MMMMN     M           MMMMMMMMM      MMMM    MMMM
     MMMM          M                    MMMMMMM        M       M
       M
 ---------------------------------------------------------------
   For those about to rock... (Attitude Adjustment, unknown)
 ---------------------------------------------------------------
```

# TP-Link Firmware Modifications

The majority of the firmware included in this section is enhanced with Debug Mode, a feature absent in standard firmware versions.

## Debug Page Access

The debug page is not readily accessible but can be reached by following these steps based on your router's LAN subnet:

- Navigate to `http://192.168.0.1/webpages/debug.html`

On the debug page, you have the ability to input commands that enable the 2.5G mode. It's important to note that this activation is temporary, and if the router is rebooted, the process will need to be repeated.

### Instructions for Debug Mode Activation

1. Access the debug page using the provided URL.
2. Input the relevant command to enable 2.5G mode.
3. Keep in mind that this activation is not persistent across reboots, necessitating a repeat of the process after each restart.

Please exercise caution when using debug features and refer to the user documentation for additional guidance on the commands and their implications.
