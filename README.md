# Hacking [RTL960x](https://www.google.com/search?q=rtl9601ci+datasheet)
* Hacking Realtek based xPON solution to suite your Universal OLT
* GPON market is a mess, plus explicit OMCI cause ONU Stick did not work
* [4-port ONU Emulation](#4-port-onu-emulation) Table (ME UNI Point)

> [!WARNING]
> This guide is intended for advanced users who are willing to **accept associated risks.** If you are unsure, it is strongly advised not to proceed. **Incorrect settings may result in your OLT (Optical Line Terminal) banning you from accessing their network and the internet.**

> [!WARNING]
> I'm just letting you know that even internally, we try not to use SFP onts as we have issues with them not connecting at all or it would connect, but then constantly lose connection. I have also **seen them go rogue and take down entire pons** back when I was a commercial tech. As an nft, I've only seen one customer try to use an sfp ont, but it was **causing collision issues which took down the pon.** The dude was super cool about it. If I remember correctly I think I just told the noc that the guys gpon ont went rogue and we need to swap it with an xgs model that way he could get at least have 10gig ports even if he couldn't get a direct connection. Just remember, it's not just you on that pon port. There are up to 32 customers per port, 64 customers if you live in West Lafayette, so please take that into consideration when you're experimenting.
> 
> Quote by [@03HemiNorthIL](https://www.reddit.com/r/Metronet/comments/1ftktrr/comment/lpsprs3/) at Reddit

# xPON SFP ONU
<a href="https://github.com/Anime4000/RTL960x/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=Anime4000/RTL960x" />
</a>

Join us in enhancing this RTL960x documentation repository to support the xPON community. Every piece of information, no matter how small, can make a significant impact on others. Got spare knowledge about ONU Box functionalities? Share it by dumping the [information here](Docs/Stock_ONU.md)! Together, let's make xPON more accessible and straightforward!
## RTL960x Family
| Stick | SoC | NAND | Mode | 4-port `EthUni` | 2.5Gb |
|-------|-----|------|------|-----------------|-------|
| [VSOL V2801F](https://www.amazon.com/Universal-Stick-Address-Supported-Attention/dp/B08C818JSQ) | `RTL9601CI` | 8MiB (64Mb) | VEIP, PPTP | YES | MOD |
| T&W TWCGPON657 | `RTL9601CI` | 16MiB (128Mb) | VEIP, PPTP | [`V1.9.0-240204`](Firmware/TWCGPON657/TWCGPON657_V1.9.0-240204.tar) | MOD |
| [Ubiquiti UFiber Instant](https://store.ui.com/collections/operator-ufiber/products/uf-instant) | `RTL9601CI` | 8MiB (64Mb) | VEIP, PPTP | NO | NO |
| ODI DFP-34X-2C2 | `RTL9601D` | 8MiB (64Mb) | VEIP, PPTP | YES | YES |
| ODI DFP-34X-2C3 (APC) | `RTL9601D` | 8MiB (64Mb) | VEIP, PPTP | YES | YES |
| [Nokia G-010S-Q](https://github.com/Anime4000/RTL960x/issues/52#issuecomment-1208424756) | `RTL9601CI` | 16MiB (128Mb) | PPTP | NO | NO |

## Other
| Stick               | Mode     | SoC       | NAND | Mode       | 4-port `EthUni` |
|---------------------|----------|-----------|------|------------|-----------------|
| ODI DFP-34X-2C2     | E/GPON   | ZTE       | ?    | PPTP, VEIP | NO, NO OMCI EDIT |
| Huawei MA5671a      | E/GPON   | Intel     | ?    | PPTP, VEIP | NO |
| Nokia G-010S-P      | E/GPON   | Intel     | ?    | PPTP, VEIP | NO |
| Nokia G-010S-A      | E/GPON   | Intel     | ?    | PPTP, VEIP | NO |

# 10G xPON ONU
| Stick               | Mode     | SoC       | NAND | Mode | 4-port `EthUni` |
|---------------------|----------|-----------|------|------|-----------------|
| [Hisense LTF7263-BH+](https://item.taobao.com/item.htm?spm=a230r.1.14.1.5d1b2e4eUxyGfI&id=658650417501) | [10G](https://twitter.com/YuukiJapanTech/status/1581277608729116672)[-EPON](https://twitter.com/YuukiJapanTech/status/1581127940468678658)/[Multi Mode](https://twitter.com/YuukiJapanTech/status/1632025860999090178) | Realtek   | ?    | ?    | ? |
| [Hisense LTF7267-BH+](https://item.taobao.com/item.htm?spm=a230r.1.14.1.5d1b2e4eUxyGfI&id=658650417501) | [XGSPON Multi Mode](https://twitter.com/YuukiJapanTech/status/1632025860999090178)   | Realtek   | ?    | ?    | ? |
> [!TIP]
> Hisense 10G xPON was checked by [@YuukiJapanTech](https://twitter.com/YuukiJapanTech), frimware 'might' that support multiple PON mode...
> 
> For **XG/XGS/10G-E PON Hacking**, checkout [@YuukiJapanTech](https://github.com/YuukiJapanTech) on [Hacking CA8271x XGS-PON Stick](https://github.com/YuukiJapanTech/CA8271x)

# VEIP vs PPTP
| Code | Full name | Meaning |
|------|-----------|---------|
| PPTP | Physical Path Termination Point | OLT is responsible to provision of VLAN and LAN Port |
| VEIP | Virtual Ethernet Interface Point | Allows multiple Ethernet services to be carried over a single PON link |

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
13. [Contributors](#rtl960x-hacking-contributors)
14. [Hack-Gpon.org - Worldwide wiki on how to access, change and edit ONTs](https://hack-gpon.org/) <sup>⚠️ Advanced user only, study how xPON work</sup>

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

# xPON ONU SFP
## DFP-34X-2C2 <sup>Recommended!</sup>
### Feature
* Much cheaper than **VSOL V2801F** & **CarlitoxxPro CPGOS03-0490 v2.0**!
* Using latest SoC **RTL9601D**!
* Support **HEX** PLOAM Password! *<sup>Using [`220304`](https://github.com/Anime4000/RTL9601C1/blob/main/Firmware/DFP-34X-2C2/M114_sfp_ODI_220304.tar) Firmware</sup>*
* Support 2.5GbE via [**HiSGMII** or **2500Base-X**](Docs/FLASH_GETSET_INFO.md#lan_sds_mode-min-1-max-6)! *<sup>See [Compatibility](Docs/2.5Gb.md#device-list), [SpeedTest](https://github.com/Anime4000/RTL960x/issues/17#issuecomment-1100272965)</sup>*
* Using newer SFP Body with intergrated heatsink *<sup>See [Picture](https://github.com/Anime4000/RTL9601C1/issues/17#issuecomment-1077681925)</sup>*
* Very efficient, just **45°C** without fan!
* Automatic/Transparent bridge like VSOL V2801F! *<sup>Using [`220304`](https://github.com/Anime4000/RTL9601C1/blob/main/Firmware/DFP-34X-2C2/M114_sfp_ODI_220304.tar) Firmware</sup>*
* Support 4-port ONU Emulation

## V2801F
### Feature
* Limited 2.5GbE Support *<sup>wrong `LAN_SDS_MODE` can lock you out, no auto switch</sup>*
* **HEX** PLOAM Password require modification from [@zry98](https://github.com/zry98/SFP-GPON-ONU#modules-using-rtl8672--rtl9601c-chipset)
* Automatic/Full Transparent
* Support 4-port ONU Emulation
* [Modern WebGUI](WebGui#example)

# Triple Play Multiple ISP Problem, 4-port ONU Emulation
* Majority fiber vendor support multiple ISP
* ISP provide Triple Play service (Internet, VoIP & IPTV)
* Vendor supply 4-port ONU for each service or ISP

## 4-port ONU Emulation
Based on [ru-board](http://forum.ru-board.com/topic.cgi?forum=8&topic=80480&start=1360#2), xPON Stick with **4-Port Emulation** support is limited!

### ONU LAN Port Binding example
If you using 4-port ONU like [Huawei HG8240H5](https://www.google.com/search?q=HG8240H5), [Nokia G-240G-E](https://www.google.com/search?q=G-240G-E) and Router connected to ONU LAN 2/3/4, you have limited option, I recommend [ODI DFP-34X-2C2](https://www.aliexpress.com/item/1005003515662920.html) with `220304` or newer firmware.

### Table 4-port ONU Emulation
Here list of xPON Stick on the market that support 4-port ONU Emulation:
<table>
    <thead>
        <tr>
            <th rowspan="2">xPON Stick</th>
            <th colspan="6">Huawei HG8240H LAN Port</th>
            <th rowspan="2">Firmware</th>
        </tr>
        <tr>
            <th>Root</th>
            <th>1️⃣</th>
            <th>2️⃣</th>
            <th>3️⃣</th>
            <th>4️⃣</th>
            <th>PVID</th>
        </tr>
    </thead>
    <tbody>
       <tr>
            <td>Huawei MA5671a</td>
            <td>✔️</td>
            <td>✔️</td>
            <td>❌</td>
            <td>❌</td>
            <td>❌</td>
            <td>✔️</td>
            <td>OpenWRT</td>
        </tr>
        <tr>
            <td>Nokia G-010S-P</td>
            <td>✔️</td>
            <td>✔️</td>
            <td>❌</td>
            <td>❌</td>
            <td>❌</td>
            <td>✔️</td>
            <td>OpenWRT</td>
        </tr>
        <tr>
            <td>ODI DFP-34X-2C2</td>
            <td>✔️</td>
            <td>✔️</td>
            <td>❌</td>
            <td>❌</td>
            <td>❌</td>
            <td>❌</td>
            <td><code>210702</code>, <code>220527</code></td>
        </tr>
        <tr>
            <td>ODI DFP-34X-2C2</td>
            <td>✔️</td>
            <td>✔️</td>
            <td>✔️</td>
            <td>✔️</td>
            <td>✔️</td>
            <td>❓</td>
            <td><code>220304</code>, <code>220414</code></td>
        </tr>
        <tr>
            <td>TWCGPON657</td>
            <td>✔️</td>
            <td>✔️</td>
            <td>✔️</td>
            <td>✔️</td>
            <td>✔️</td>
            <td>❌</td>
            <td><code>C00R657V2801F_V1.9.0-220404.tar</code></td>
        </tr>
        <tr>
            <td>V-SOL V2801F</td>
            <td>✔️</td>
            <td>✔️</td>
            <td>✔️</td>
            <td>✔️</td>
            <td>✔️</td>
            <td>❌</td>
            <td> Stock Firmware </td>
        </tr>
    </tbody>
</table>

## Good Luck!
