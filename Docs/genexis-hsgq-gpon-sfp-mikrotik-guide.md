# Replacing Excitel Genexis ONT with HSGQ GPON SFP Stick on MikroTik hEX S

Reference: https://github.com/Anime4000/RTL960x/issues/478

This guide documents the full process used to replace a Genexis GPON ONT with an HSGQ/DFP-style GPON SFP stick on a MikroTik RB760iGS / hEX S.

The important outcome from the original troubleshooting thread is that the stock ONT configuration showed Internet VLAN `100`, while live OMCI provisioning showed VLAN `331` in `ME 171`. In this setup, both VLAN `100` and VLAN `331` were observed to work, depending on how VLAN handling was configured between the SFP stick and the router.

## Hardware

* Stock ONT: Genexis T2122A (T21 Pro)
* Replacement ONT: HSGQ GPON SFP stick
* Router: MikroTik RB760iGS / hEX S
* RouterOS: 7.23.1
* SFP management IP: `192.168.1.80`
* Router LAN IP: `192.168.88.1/24`
* Router SFP management IP: `192.168.1.1/24`

The SFP stick reported this CPU information:

```text
system type : RTL8672
processor   : 0
cpu model   : 56322
BogoMIPS    : 299.00
```

## Safety

GPON networks are shared infrastructure. Incorrect ONU identity, bad OMCI behavior, or unstable optical levels can affect other subscribers on the same PON segment.

Do not blindly copy values from another user's ONT. Clone only your own stock ONT values, and stop if the device repeatedly fails registration or behaves unpredictably.

## Values to Extract From the Stock ONT

From the Genexis ONT web UI and/or its configuration dump, I collected these values:

```text
Manufacturer
ProductClass
SerialNumber / GPON SN / XPON SN
Hardware version
Software version
ONU MAC
WAN MAC
OUI
PLOAM password, if used
LOID and LOID password, if used
PPPoE username and password
Internet WAN VLAN
```

In the original case, the stock ONT exposed values similar to:

```text
Manufacturer: GENEXIS
ProductClass: 3f1e00
SerialNumber: GNXS93901379
HWVer: C40-210
SWVer: T21PRO-V1.14EU
ONU MAC: 20:0C:86:3F:1E:02
GPON MAC: 20:0C:86:3F:1E:00
OUI: 200c86
xponsn: GNXS93901379
```

## Stock ONT romfile.cfg Context

The stock Genexis ONT configuration dump contained useful OMCI and WAN information. Relevant fields included:

```xml
<ONU Version="RP0201"
     VendorId="4899"
     SerialNumber="<stock GPON serial>"
     Password="<stock password>"
     EquipmentId="GENEXIS"
     OMCCVersion="A0" />
```

The Internet WAN service in the stock configuration showed VLAN `100`:

```xml
<PVC0 VLANID="100" VLANMode="TAG" GPONEnable="Yes">
<Entry0 ServiceList="INTERNET"
        WanMode="Bridge"
        BridgeMode="IP_Bridged"
        VLANMode="TAG"
        VLANID="100" />
```

This is important, but it is not the whole picture. `romfile.cfg` is the local saved configuration of the stock ONT/router. The OLT can still push live VLAN rules through OMCI that do not look identical to the locally saved WAN VLAN.

## Configure the SFP Stick Identity

Clone the stock ONT identity into the SFP stick. Exact variable names depend on firmware, but the values usually map to these fields:

```sh
flash set GPON_SN <stock GPON serial>
flash set PON_VENDOR_ID <stock vendor id>
flash set HW_CWMP_MANUFACTURER GENEXIS
flash set HW_HWVER <stock hardware version>
flash set GPON_ONU_MODEL <stock model or product class>
flash set ELAN_MAC_ADDR <stock ONU or WAN MAC, depending on firmware expectation>
flash set MAC_KEY <generated MAC_KEY>
```

Generate `MAC_KEY` using the keygen linked from the RTL960x README:

```text
https://gist.github.com/rajkosto/29c513b96ea6262d2fb1f965a52ce16f
```

Without the correct `MAC_KEY`, the stick may stay at `O0`/`O3`, fail to reach a usable `O5`, or show invalid authentication state.

In the issue thread, the maintainer's first question was whether the correct `MAC_KEY` had been entered. After generating and applying the correct key, the stick reached a state where OMCI data could be inspected and PPPoE/VLAN handling became the remaining problem.

## PON State Progression

During troubleshooting, the stick showed states like:

```text
ONU State: O0
ONU ID: 255
LOID Status: WRONG
```

Then later:

```text
ONU State: O3
ONU ID: 255
LOID Status: WRONG
```

At one point it briefly showed:

```text
ONU State: O5
ONU ID: 127
LOID Status: WRONG
```

The final useful target is:

```text
ONU State: O5
```

`LOID Status: WRONG` may not be fatal if the ISP does not actually use LOID authentication for Internet service, but this depends on the OLT and ISP.

## Inspect OMCI MIBs

After the stick reaches `O5`, telnet or SSH into the SFP stick and inspect these OMCI managed entities:

```sh
omcicli mib get 11
omcicli mib get 84
omcicli mib get 131
omcicli mib get 171
omcicli mib get 329
```

In the original case:

* `ME 11` showed Ethernet UNI information.
* `ME 84` was empty.
* `ME 131` showed OLT information.
* `ME 171` showed extended VLAN operation data.
* `ME 329` showed VEIP information.

The relevant `ME 171` output was:

```text
ExtVlanTagOperCfgData
=================================
EntityId: 0x101
AssociationType: 2
InputTPID: 0x8100
OutputTPID: 0x8100
DsMode: 0
ReceivedFrameVlanTaggingOperTable
INDEX 0
Filter Outer      : PRI 15,VID 4096, TPID 0
Filter Inner      : PRI 15,VID 4096, TPID 0, EthType 0x00
Treatment Outer   : PRI 15,VID 4096, TPID 0, RemoveTags 0
Treatment Inner   : PRI 0,VID 331, TPID 4
AssociatedMePoint : 0x101
```

The line below is the key clue:

```text
Treatment Inner   : PRI 0,VID 331, TPID 4
```

`ME 171` means OMCI Managed Entity 171, Extended VLAN Tagging Operation Configuration Data. It tells the ONT/SFP how the OLT wants frames filtered, tagged, untagged, or translated on the Ethernet side.

## Why romfile.cfg Showed VLAN 100 But ME 171 Showed VLAN 331

The stock ONT `romfile.cfg` showed Internet VLAN `100` because that was the WAN service configuration inside the Genexis ONT.

The live OMCI MIB showed VLAN `331` because the OLT provisioned an extended VLAN tagging operation involving VLAN `331`.

These can differ for several reasons:

* The stock ONT may translate VLANs internally.
* The stock ONT may expose a service VLAN like `100` in the web UI while handling another OMCI-provisioned VLAN internally.
* The SFP stick may bridge OMCI-provisioned VLANs differently from the original ONT box.
* `romfile.cfg` is static local configuration, while `ME 171` is live OLT provisioning.

In this specific setup, both VLAN `100` and VLAN `331` were tested and worked. That means neither value should be treated as universally correct without checking the selected SFP VLAN mode and the router-side VLAN configuration.

## SFP Web UI VLAN Modes

The SFP web UI appears to have at least two practical VLAN handling modes.

## Manual

### Transparent

In this mode, the SFP stick mostly forwards Ethernet frames to the router. VLAN tagging or untagging is done on the router.

This is the preferred mode for this setup because the router has more CPU, RAM, tooling, and visibility than the SFP stick. It also makes packet captures and PPPoE debugging easier.

Use this if you want the MikroTik to handle the WAN VLAN using an `/interface vlan` on `sfp1`.

### PVID Mode

In this mode, the SFP stick performs VLAN untagging internally. The router may then receive untagged traffic from the SFP stick.

This can work, but it moves VLAN handling into the SFP stick, which is a much smaller device with fewer debugging tools.

If using PVID mode, the router configuration may need PPPoE directly on `sfp1` instead of on a VLAN subinterface.

## Recommended Design

Use transparent/manual forwarding on the SFP stick and do VLAN handling on the MikroTik.

This keeps the paths separate:

```text
sfp1                 = physical SFP interface and SFP management access
wan-vlan331 on sfp1  = PPPoE WAN over VLAN 331
pppoe-out1           = Internet PPPoE client
bridge               = LAN bridge
```

The SFP management IP stays reachable on the physical interface:

```text
Router SFP management IP: 192.168.1.1/24
SFP management IP:        192.168.1.80/24
```

The LAN stays separate:

```text
Router LAN IP: 192.168.88.1/24
LAN DHCP pool: 192.168.88.2-192.168.88.254
```

## Known Working MikroTik Configuration

This is a sanitized version of the working MikroTik configuration. Replace placeholders with your own values.

Set the SFP interface MAC address if your ISP expects the stock ONT/router-facing MAC:

```routeros
/interface ethernet
set [ find default-name=sfp1 ] mac-address=<stock WAN MAC>
```

Create the VLAN interface on `sfp1`:

```routeros
/interface vlan
add comment=wan-vlan331 interface=sfp1 name=wan-vlan331 vlan-id=331
```

Create the PPPoE client on the VLAN interface:

```routeros
/interface pppoe-client
add add-default-route=yes dial-on-demand=yes disabled=no interface=wan-vlan331 name=pppoe-out1 use-peer-dns=yes user=<pppoe username> password=<pppoe password>
```

Add interface lists:

```routeros
/interface list
add comment=defconf name=WAN
add comment=defconf name=LAN

/interface list member
add comment=defconf interface=bridge list=LAN
add interface=pppoe-out1 list=WAN
```

Keep SFP management on the physical `sfp1` interface:

```routeros
/ip address
add address=192.168.1.1/24 comment="SFP management" interface=sfp1 network=192.168.1.0
```

Keep the normal LAN on the bridge:

```routeros
/ip address
add address=192.168.88.1/24 comment=defconf interface=bridge network=192.168.88.0

/ip pool
add name=dhcp ranges=192.168.88.2-192.168.88.254

/ip dhcp-server
add address-pool=dhcp interface=bridge name=defconf

/ip dhcp-server network
add address=192.168.88.0/24 comment=defconf dns-server=192.168.88.1 gateway=192.168.88.1
```

Add NAT for Internet:

```routeros
/ip firewall nat
add action=masquerade chain=srcnat comment="defconf: masquerade" ipsec-policy=out,none out-interface-list=WAN
```

Add NAT for reaching the SFP management IP from the LAN:

```routeros
/ip firewall nat
add action=masquerade chain=srcnat comment="NAT for SFP management" dst-address=192.168.1.80 out-interface=sfp1
```

Do not actively bridge `sfp1` into the LAN bridge while it is used as WAN and SFP management. If RouterOS default configuration added it as a bridge port, disable or remove that bridge port:

```routeros
/interface bridge port
set [ find interface=sfp1 ] disabled=yes
```

Alternatively, remove it completely:

```routeros
/interface bridge port
remove [ find interface=sfp1 ]
```

## Working Configuration Shape

The working configuration used this structure:

```text
/interface ethernet
sfp1 MAC overridden to stock WAN MAC

/interface vlan
wan-vlan331 on sfp1, vlan-id 331

/interface pppoe-client
pppoe-out1 on wan-vlan331

/ip address
192.168.88.1/24 on bridge
192.168.1.1/24 on sfp1 for SFP management

/ip firewall nat
masquerade out WAN
masquerade to 192.168.1.80 out sfp1 for SFP management
```

My exact working export had:

```routeros
/interface vlan
add comment=wan-vlan331 interface=sfp1 name=wan-vlan331 vlan-id=331

/interface pppoe-client
add add-default-route=yes dial-on-demand=yes disabled=no interface=wan-vlan331 name=pppoe-out1 use-peer-dns=yes user=<redacted>

/ip address
add address=192.168.88.1/24 comment=defconf interface=bridge network=192.168.88.0
add address=192.168.1.1/24 comment="SFP management" interface=sfp1 network=192.168.1.0

/ip firewall nat
add action=masquerade chain=srcnat comment="defconf: masquerade" ipsec-policy=out,none out-interface-list=WAN
add action=masquerade chain=srcnat comment="NAT for SFP management" dst-address=192.168.1.80 out-interface=sfp1
```

## VLAN 100 Alternative

Because the stock ONT showed VLAN `100`, this VLAN may also work depending on SFP VLAN mode.

To test VLAN `100` instead of `331`, create a VLAN 100 interface and move PPPoE to it:

```routeros
/interface vlan
add comment=wan-vlan100 interface=sfp1 name=wan-vlan100 vlan-id=100

/interface pppoe-client
set pppoe-out1 interface=wan-vlan100
```

Do not keep multiple enabled PPPoE clients trying the same credentials unless you are intentionally testing and know what your ISP permits.

## Troubleshooting

If the SFP reaches `O5` but there is no Internet:

* Confirm the PPPoE username and password.
* Confirm the selected VLAN mode in the SFP web UI.
* Try PPPoE on VLAN `100` and VLAN `331`, one at a time.
* Check `omcicli mib get 171` for live OLT VLAN rules.
* Capture packets on the MikroTik to see whether PPPoE discovery frames are tagged or untagged.
* Keep SFP management on physical `sfp1`, not on the PPPoE VLAN interface.

If the SFP management IP becomes unreachable after changing VLAN settings:

* Verify that `192.168.1.1/24` is assigned to physical `sfp1`.
* Verify that the SFP IP is still `192.168.1.80`.
* Verify `sfp1` is not actively bridged into the LAN bridge.
* Verify the management NAT rule exists if accessing from LAN.
* Revert the SFP VLAN mode if PVID caused management traffic to be hidden behind tagging behavior.

If the stick stays at `O3`:

* Recheck GPON serial number.
* Recheck PLOAM password, if used.
* Recheck `MAC_KEY`.
* Recheck vendor ID, manufacturer, model, hardware version, and OMCI-related identity fields.
* Check optical RX power and connector cleanliness.

## Final Notes

The main lesson from this setup is not simply "use VLAN 331" or "use VLAN 100".

The actual lesson is:

```text
romfile.cfg VLAN: 100
OMCI ME 171 VLAN treatment: 331
Observed working VLANs: 100 and 331
Preferred setup: transparent/manual SFP VLAN mode, router-side VLAN handling
```

For this MikroTik setup, router-side VLAN handling was preferred because it keeps the SFP stick simple and moves VLAN processing to a device with more resources and better diagnostics.
