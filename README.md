# Hacking [RTL960x](https://www.google.com/search?q=rtl9601ci+datasheet)

## ⚠️ Important Considerations for Using Custom GPON Sticks (SFP ONTs)
When using custom **GPON SFP ONTs** (Small Form-factor Pluggable Optical Network Terminals), it’s important to be aware of potential risks and how they can affect not only your connection but also others on the same network.

### Potential Issues with SFP ONTs
- **Connection Instability**<br><sup>Some users have reported that SFP ONTs may fail to connect properly or might frequently disconnect.</sup>
- **Network Disruptions**<br><sup>In some cases, faulty SFP ONTs can cause major problems, such as taking down the entire GPON (Gigabit Passive Optical Network) by creating signal collisions. This can affect all the users sharing the same network port.</sup>
- **Going Rogue**<br><sup>There have been situations where an SFP ONT "went rogue," causing disruptions for other users on the network. This happens because a single GPON port can serve up to 32 users (or 64 users in certain areas), so one malfunctioning ONT can impact everyone.</sup>

Always monitor for issues, and consider switching to certified models if problems persist to avoid affecting other users.

### Real-World Example
> [!WARNING]
> A technician once encountered an SFP ONT that was causing collisions, which affected the entire network. They had to replace the device with a different model (XGS PON) to restore stability and avoid further issues. While experimenting with custom devices can be fun, it’s essential to understand that you share the network with other customers.
> 
> *tl;dr quote by [@03HemiNorthIL](https://www.reddit.com/r/Metronet/comments/1ftktrr/comment/lpsprs3/) at Reddit*

### What This Means for You
If you’re experimenting with custom GPON sticks, keep the following in mind

1. **Monitor for Connection Issues**<br><sup>If your connection drops frequently or doesn’t work as expected, your SFP ONT might not be fully compatible.</sup>
2. **Consider Network Impact**<br><sup>Be mindful that your actions can affect the other users on the same network port. If your ONT malfunctions, it could bring down the network for everyone.</sup>
3. **Seek Alternatives**<br><sup>If problems persist, you may need to switch to a more stable, certified model, especially if you're sharing the network with many other users.</sup>

### Benefits and Limitations
> [!NOTE]
> Using GPON Sticks can potentially **improve throughput for plans offering 2 Gbps by bypassing the limitations of a typical Gigabit Ethernet ONT.** However, this will not provide any speed boost or "hacking" beyond your subscribed plan.

### Legal Considerations
> [!CAUTION]
> If your ISP detects the use of unauthorized commands or illegal activity, <ins>they have the right to ban your service and impose hefty fines for disrupting the PON network.</ins>

### Disclaimer
> [!IMPORTANT]  
> We are not responsible for any illegal activity that occurs from the use of this hardware. By proceeding, you agree to all the warnings and terms outlined above.

# xPON SFP ONU
<a href="https://github.com/Anime4000/RTL960x/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=Anime4000/RTL960x" />
</a>

Join us in enhancing this RTL960x documentation repository to support the xPON community. Every piece of information, no matter how small, can make a significant impact on others. Got spare knowledge about ONU Box functionalities? Share it by dumping the [information here](Docs/Stock_ONU.md)! Together, let's make xPON more accessible and straightforward!
## RTL960x Family
| Stick | SoC | NAND | Mode | 4-port `EthUni` | 2.5Gb |
|-------|-----|------|------|-----------------|-------|
| VSOL V2801F | `RTL9601CI` | 8MiB | VEIP & PPTP | Forced All | MOD |
| T&W TWCGPON657 | `RTL9601CI` | 16MiB | VEIP & PPTP | [`V1.9.0-240204`](Firmware/TWCGPON657/TWCGPON657_V1.9.0-240204.tar) | MOD |
| Ubiquiti UFiber Instant | `RTL9601CI` | 8MiB | PPTP | LAN 1 | NO |
| ODI DFP-34X-2C2 (UPC) | `RTL9601D` | 8MiB | VEIP & PPTP | Selective All | YES |
| ODI DFP-34X-2C3 (APC) | `RTL9601D` | 8MiB | VEIP & PPTP | Selective All | YES |
| [Nokia G-010S-Q](https://github.com/Anime4000/RTL960x/issues/52#issuecomment-1208424756) | `RTL9601CI` | 16MiB | PPTP | NO | NO |

## Non-RTL960x GPON
| Device              | Mode     | SoC          | NAND | UNI        | 4-port `EthUni` |
|---------------------|----------|--------------|------|------------|-----------------|
| ODI DFP-34X-2C2     | GPON SFP | ZTE          | ?    | PPTP/VEIP | NO, NO OMCI EDIT |
| Huawei MA5671a      | GPON SFP | Lantiq | 16MiB | PPTP/VEIP | LAN 1 |
| Nokia G-010S-P      | GPON SFP | Lantiq | 16MiB | PPTP/VEIP | LAN 1 |
| Nokia G-010S-A      | GPON SFP | Lantiq | 16MiB | PPTP/VEIP | LAN 1 |

## 10G xPON ONU
| Stick               | Mode     | SoC       | NAND | Mode | 4-port `EthUni` |
|---------------------|----------|-----------|------|------|-----------------|
| [Hisense LTF7263-BH+](https://item.taobao.com/item.htm?spm=a230r.1.14.1.5d1b2e4eUxyGfI&id=658650417501) | [10G](https://twitter.com/YuukiJapanTech/status/1581277608729116672)[E/](https://twitter.com/YuukiJapanTech/status/1581127940468678658)[XG/XGS](https://twitter.com/YuukiJapanTech/status/1632025860999090178)PON | Realtek   | ?    | ?    | ? |
| [Hisense LTF7267-BH+](https://item.taobao.com/item.htm?spm=a230r.1.14.1.5d1b2e4eUxyGfI&id=658650417501) | [XG/XGSPON](https://twitter.com/YuukiJapanTech/status/1632025860999090178)   | Realtek   | ?    | ?    | ? |
| PRX126 | XG/XGS PON | Maxlinear PRX126 | ? | VEIP & PPTP | Maybe |
> [!NOTE]
> For **XG/XGS/10GE PON RTL CA series Hacking**, checkout [@YuukiJapanTech](https://github.com/YuukiJapanTech) on [Hacking CA8271x XGS-PON Stick](https://github.com/YuukiJapanTech/CA8271x)<br>
> For **XG/XGS PON MxL PRX series hacking**, cehckout [@up-n-atom](https://github.com/up-n-atom/) on [8311](https://github.com/up-n-atom/8311)

# Guide, Links, Info
1. [Backup `env`, `env2` & `config` partition](https://github.com/Anime4000/RTL960x/discussions/28) <sup>Guide by [@tdmadam](https://github.com/tdmadam)</sup>
1. [Setup XPON ONU SFP Stick](Docs/Setup_Stick.md)
    * [Clone Stock ONU OMCI Info](Docs/Stock_ONU.md)
        * [Fiberhome](https://github.com/Anime4000/RTL960x/issues/131#issuecomment-1885032543) <sup>for who using Fiberhome ONT, high chance under Fiberhome OLT Standard, not Fiberhome OLT Universal</sup>
    * [ISP specific configuration](/Docs/ISP_specific_configuration.md)
    * [Troubleshoot](Docs/TroubleshootSetup.md)
3. [`flash get`, `flash set`](Docs/FLASH_GETSET_INFO.md)
    * [xPON Model Id](Docs/FLASH_GETSET_INFO.md#pon_vendor_id-4-ascii-character-maximum)
    * [LAN SDS Mode](Docs/FLASH_GETSET_INFO.md#lan_sds_mode)
    * [2.5GbE Compatibility](Docs/2.5Gb.md)
4. Health Reporting
    * [Telegram](https://github.com/Anime4000/RTL960x/issues/99#issuecomment-1611726668) <sup>Mikrotik script by [@smnrock](https://github.com/smnrock), sending health report via Telegram Bot</sup>
    * [Telegram via #!/bin/bash](https://github.com/Anime4000/RTL960x/discussions/277) <sup>Linux Bash script by [@chiragkrishna](https://github.com/chiragkrishna), sending health report via Telegram Bot</sup>
    * [Grafana](https://github.com/Anime4000/RTL960x/issues/99#issuecomment-1911530327) <sup>Grafana script by [@Strykar](https://github.com/Strykar), display PON Stats neatly! [Project Repo](https://github.com/Strykar/GPON)</sup>
6. [Diagnostic](Docs/DIAG.md)
    * [Factory Reset](Docs/factory_reset.md)
    * [Switch/Roll back Firmware](Docs/fw_part.md)
    * [`O5` no Internet](Docs/fakeO5.md) <sup>fake ONU Status cause by some OLT</sup>
    * [`OMCI_TM_OPT`](https://github.com/Anime4000/RTL960x/issues/35#issuecomment-1138255401) <sup>stick cause internet speed slow? this look at this, found by [@ccy](https://github.com/ccy)</sup>
    * [OMCI MIB INFO](Docs/OMCI_CLI.md) <sup>check various OMCI, VLAN, OLT</sup>
        * [Forward Operation `FwdOp`](https://github.com/Anime4000/RTL960x/issues/194#issuecomment-1722497606) <sup>discussion about special VLAN (vlan 1) to force bridge</sup>
        * [Forward Operation `FwdOp`](https://github.com/Anime4000/RTL960x/pull/94#issuecomment-1319016018) <sup>`fix_vlan.sh` script for special ISP</sup>
    * [OMCI VLAN](Docs/OMCI_VLAN.md) <sup>list available VLAN that provided by OLT</sup>
    * [SFU/HGU feature bits](https://gist.github.com/rajkosto/79034a1f7b3de3f40edf50ffbd8396b0) <sup>RE done by [@rajkosto](https://github.com/rajkosto) also define 4-port emulation `ignore_conn_uniNode_check` UniG on SFU firmware</sup>
    * [Wireshark](https://github.com/tdmadam/OMCI-for-SFP-Stick) <sup>OMCI decoding for Wireshark by [@tdmadam](https://github.com/tdmadam)</sup>
    * [UART](Docs/UART.md)
7. [TWCGPON657 × V2801F Firmware](Firmware/TWCGPON657/README.md)
8. [V2801F Auto Reboot](Docs/V2801F.md)
9. [Firmware Emulator](Tools/emulator)
10. Keygen
    * [V2801F](https://github.com/Anime4000/RTL960x/blob/main/Docs/VS_AUTH_KEY.md)
    * [DFP-34X-2C2](https://gist.github.com/rajkosto/29c513b96ea6262d2fb1f965a52ce16f)
11. SPI/EEPROM Programming 
    * [SPI Flash & EEPROM](https://github.com/Anime4000/RTL960x/discussions/286)
    * [SFP EEPROM for 2.5G AutoNeg](https://github.com/Anime4000/RTL960x/discussions/250) <sup>Linux host need this for 2.5G mode if not hacking kernel</sup>

For those interested in learning more about the inner workings of PON technology, [**Hack-Gpon.org**](https://hack-gpon.org/) offers extensive resources, tools, and guides for in-depth study. It’s a great resource if you’re ready to dive into the technical details and explore the complexities of GPON—a true rabbit hole of learning!

# Success Story
List of users has successfully ditch stock ONU!
1. [@stich86 2.5GbE Internet](https://github.com/Anime4000/RTL960x/issues/17#issuecomment-1101435506)
2. [My journey connecting fiber internet to my router](https://www.reddit.com/r/HomeNetworking/comments/vd0qm2/my_journey_connecting_fiber_internet_to_my_router/)
3. [Hinet users in TW](https://github.com/Anime4000/RTL960x/pull/44#issue-1281699738)
4. [@izhamsatria: ~2.5Gbps on TM Unifi](https://forum.lowyat.net/index.php?showtopic=4925452&st=500&p=105123186&#entry105123186) <sup>before <a href="https://www.lowyat.net/2022/286244/time-internet-2gbps-price/">TIME announce 2Gbps</a> plan in Malaysia</sup>
5. [Orange Fiber at 2Gbps (MikroTik 10Gbps CCR2004 router & ONT SFP+)](https://lafibre.info/remplacer-livebox/guide-de-connexion-fibre-directement-sur-un-routeur-voire-meme-en-2gbps/) <sup>In <a href="https://translate.google.com/">French</sup>
6. [MagtiCom Fiber in Georgia](https://telegra.ph/Georgia-DFP-34X-2C2-and-MagtiCom-04-23)
7. [T-Mobile Netherlands replacing Huawei ONT](https://providerforum.nl/topics/vervangen-t-mobile-huawei-gpon.95394/page-3#post-1348257) <sup>[English version](https://providerforum-nl.translate.goog/topics/vervangen-t-mobile-huawei-gpon.95394/page-3?_x_tr_sl=auto&_x_tr_tl=en&_x_tr_hl=en&_x_tr_pto=wapp#post-1348257)</sup>
8. [SilkNet Fiber in Georgia](https://telegra.ph/Georgia-DFP-34X-2C2-and-SilkNet-11-07)
9. [Bangladesh: Dot-Internet Dhaka](https://github.com/Anime4000/RTL960x/issues/307)

# Repository Scope and Legal Considerations
Please note that this repository does not contain ISP-specific configurations or sensitive information, both for legal reasons and to ensure responsible use. We aim to provide general guidance without supporting any unauthorized activity.

If you’re looking for a reliable GPON Stick solution that is ready to use with minimal setup, consider checking with resellers in your country. Many resellers offer modified PON Sticks pre-configured for local ISPs, including:

* **Pre-configured serial numbers (S/N) and PLOAM passwords:** <sup>Some resellers can program these credentials before shipping, making installation seamless and avoiding configuration hassle.</sup>
* **Enhanced compatibility:** <sup>In many cases, these units are plug-and-play, tailored for compatibility with specific ISPs.</sup>

> [!NOTE]
> By choosing a pre-configured unit from a reputable source, you can save time and ensure stability without needing to adjust settings manually.

# VEIP vs PPTP
| Code | Full name | Meaning |
|------|-----------|---------|
| PPTP | Physical Path Termination Point | Directly binds to a specific LAN port, with OLT managing VLANs and settings on the ONT. |
| VEIP | Virtual Ethernet Interface Point | Acts like a virtual interface (e.g., `tap0`), allowing ONT firmware to assign to LAN ports, router mode, management, or VoIP. |
> [!NOTE]
> Since a PON SFP Stick has only one interface to the host, its firmware may struggle to manage VLANs from both PPTP and VEIP. Many firmware versions simply bridge all VLANs from both, regardless of configuration, which can lead to issues:
> - If the same VLAN ID is used for different services on PPTP and VEIP, the stick’s firmware might bridge them together without distinction, potentially causing issues with DHCP/IPoE.
> - Most firmware prioritizes PPTP first, using VEIP only if PPTP is unavailable. A few firmware versions allow manual VLAN selection for bridging, independent of PPTP/VEIP.
> 
> Also, note that if your ISP uses **ME 148** (which enforces PPPoE and routing on the ONT), you may not be able to bridge directly to your own router. For bridge mode, it's best to contact your ISP for assistance.

# 4-Port LAN (UNI)
Many ISPs use PPTP to bind specific LAN ports to different service providers, allowing one ONT to support multiple ISPs. For instance, LAN 1 might be configured for ISP 1, LAN 2 for ISP 2, and so forth. This setup is common in areas served by single fiber vendors that host multiple ISPs.

However, this multi-ISP setup can pose issues for PON Sticks, as they might struggle to bridge VLANs on any port other than LAN 1. This limitation occurs because PPTP configurations, along with the Forwarding Operation (FwdOp), are often designed specifically for ONTs and may not be fully recognized by PON sticks. Some advanced setups attempt to resolve this by using an HGU MIB file to "trick" the OLT (Optical Line Terminal) into accepting the ME 84 and ME 171 operations, allowing better compatibility.

# Fake O5 State
Some OLTs from manufacturers like Calix and Nokia, which support Universal ONU, may provide a “false O5” state, which can be misleading. A device might reach the O5 state (the operational stage where data transmission typically begins) even with incorrect Serial Number or PLOAM Password. In this scenario, the OLT might allow the connection to reach O5 but won’t actually push any VLAN configurations (typically ME 84 & ME 171).

To resolve this, double-check all configuration parameters, including the serial number and password. If the connection still doesn’t work after verification, the OLT may be requiring Vendor-Specific Managed Entities (ME) (IDs 350-399) which are sometimes mandated by ISPs for authentication or additional configuration.

# O2-O5 Loop
A device entering an O2-O5 loop (oscillating between states) could indicate a similar issue as the "Fake O5" scenario. Another common reason for this loop is low optical receive power (RX), where the power level drops below the acceptable threshold (e.g., <= -23 dBm). When this happens, the OLT may refuse to allow a stable O5 state to maintain PON performance.

To address an O2-O5 loop caused by low RX power:

* Inspect and clean the fiber connector to ensure there’s no dirt or damage impacting signal strength.
* Check RX readings after cleaning, as improved optical power might stabilize the connection and help maintain a steady O5 state.

# ⚠️
> [!CAUTION]
> If you have attempted all troubleshooting steps and are still unable to establish a connection, it’s recommended to stop further adjustments. Persistent errors or invalid configurations will be flagged by your ISP, and further experimentation can unintentionally disrupt the entire PON network in your area, affecting other users.
>
> Please remember to use these tools responsibly and respect the shared network environment.
>
> Thank you for your consideration and cooperation.

# Community Support
For community support and discussions, consider joining these groups. Please remember to be **respectful** and **mindful** that members are helping in their free time. PON settings can be very complex and difficult to understand, <ins>so avoid pressuring others for help</ins>:

* [XPON SFP ONU](https://t.me/xpon_sfp_onu) — Telegram (RU)
* [RTL960X Discuss](https://discord.gg/JWdAzj9m4F) — Discord (EN)


# Good Luck!
