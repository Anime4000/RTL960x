# Diag
Realtek RTL9601C1 has xPON Utility called `diag`, problably can modify OMCI bandwidth control
```
# cat /etc/version
C00R657V00B12 --  Thu Nov 21 14:52:46 CST 2019
# diag
RTK.0> gpon show onu-info
Vendor ID   : GPON
Model ID    : G657
Gpon MAC    : 6cefc6000000
Hardware    : V1.0
Software    : C00R657V00B13
RTK.0> gpon show us-flow
============================================================
    GPON ONU MAC U/S Flow Status
Flow ID | GEM Port | Type | TCont
      0 |      263 |  ETH |     0
      1 |      264 |  ETH |     1
      2 |      267 |  ETH |     1
      3 |      272 |  ETH |     2
     64 |        2 | OMCI |    16
============================================================
RTK.0> bandwidth get egress port all
port: 0  rate:4194296
         queue: 0  apr-index: 0
         queue: 1  apr-index: 0
         queue: 2  apr-index: 0
         queue: 3  apr-index: 0
         queue: 4  apr-index: 0
         queue: 5  apr-index: 0
         queue: 6  apr-index: 0
         queue: 7  apr-index: 0
port: 2  rate:4194296
         queue: 0  apr-index: 0
         queue: 1  apr-index: 0
         queue: 2  apr-index: 0
         queue: 3  apr-index: 0
         queue: 4  apr-index: 0
         queue: 5  apr-index: 0
         queue: 6  apr-index: 0
         queue: 7  apr-index: 0
RTK.0> bandwidth get ingress port all rate
port: 0 rate:4194296
port: 2 rate:4194296
RTK.0> bandwidth set egress port all rate
<UINT:rate>                                      - rate vlaue (unit 1Kbps), <8~1048568>
RTK.0> bandwidth set ingress port all rate
<UINT:rate>                                      - rate value (unit 1Kbps), <8~1048568>
RTK.0> bandwidth set egress port all rate 1048568
RTK.0> bandwidth set ingress port all rate 1048568
RTK.0> bandwidth get egress port all
port: 0  rate:1048568
         queue: 0  apr-index: 0
         queue: 1  apr-index: 0
         queue: 2  apr-index: 0
         queue: 3  apr-index: 0
         queue: 4  apr-index: 0
         queue: 5  apr-index: 0
         queue: 6  apr-index: 0
         queue: 7  apr-index: 0
port: 2  rate:1048568
         queue: 0  apr-index: 0
         queue: 1  apr-index: 0
         queue: 2  apr-index: 0
         queue: 3  apr-index: 0
         queue: 4  apr-index: 0
         queue: 5  apr-index: 0
         queue: 6  apr-index: 0
         queue: 7  apr-index: 0
RTK.0> bandwidth get ingress port all rate
port: 0 rate:1048568
port: 2 rate:1048568
RTK.0> port get status port all
Port Status Speed    Duplex TX_FC RX_FC
---- ------ -----    ------ ----- -----
0    Up     1000M    Full   En    En
2    Up     1000M    Full   Dis   Dis

```