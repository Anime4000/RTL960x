# Stock ONU
here list known ONU device for OMCI Info Cloning, making your xPON ONU SFP Stick act like your original ONU to fool Fiber Vendor OLT

## Telnet `flash set`
```
flash set GPON_ONU_MODEL 
flash set GPON_SN 
flash set PON_VENDOR_ID 
flash set HW_HWVER 
flash set OMCI_SW_VER1 
flash set OMCI_SW_VER2 
flash get OUI
flash get HW_SERIAL_NO
```
Use value from table below

# OMCI Info
Below are essential OMCI ONU details required by Universal OLT. For a comprehensive understanding, explore various [MIB datasets](OMCI_CLI.md).

| `GPON_ONU_MODEL` | `GPON_SN`    |`PON_VENDOR_ID` | `HW_HWVER`      | `OMCI_SW_VER#`   | Owner     | ISP |
|------------------|--------------|----------------|-----------------|------------------|-----------|-----|
| EG8010Hv6        | HWTC12345678 | HWTC           | 260F.A          | V5R020C10S035    | lwk523    | [Allo](https://www.allo.my/city-broadband/) |
| HG8240H          | HWTC12345678 | HWTC           | BF9.A           | V3R017C10S100    | hezaika   | [TIME](https://www.time.com.my/personal/broadband/fibre-broadband) |
| RTF8207W         | ASKY12345678 | ASKY           | RTF8207W        | R82XXR230308     | pccr10001 | [Hinet](https://broadband.hinet.net/Broadband/internetManagement/internet/internet/internet_02.do) |
| RTF8217          | ASKY12345678 | ASKY           | RTF8217         | R82XXR230308     | akw28888 | [Hinet](https://broadband.hinet.net/Broadband/internetManagement/internet/internet/internet_02.do) |
| I040GW           | GTHG12345678 | GTHG           | 3FE99997HGW001  | I040GWR200110    | akw28888 | [Hinet](https://broadband.hinet.net/Broadband/internetManagement/internet/internet/internet_02.do) |
| I040GB           | GMTK12345678 | GMTK           | 3FE99995AAAA01  | I040GBN131231    | akw28888 | [Hinet](https://broadband.hinet.net/Broadband/internetManagement/internet/internet/internet_02.do) |
| H660WM           | DSNW12345678 | DSNW           | H660WM          | H660WMR210825    | akw28888 | [Hinet](https://broadband.hinet.net/Broadband/internetManagement/internet/internet/internet_02.do) |
| RV6699           | SCOM12345678 | SCOM           | V4              | SC3.0.14         | skon77 | [MGTS](https://mgts.ru/) |
| RV6699           | SCOM12345678 | SCOM           | V4              | SC3.0.16         | skon77 | [MGTS](https://mgts.ru/) |
| PMG4506-T20B     | ZYXE12345678 | ZYXE           | PMG4506-T20B    | P4506R220712     | akw28888 | [Hinet](https://broadband.hinet.net/Broadband/internetManagement/internet/internet/internet_02.do) |
| G040WQ           | NOKW12345678 | GMTK           | 3FE47772AAAA    | G040WQR201207    | pccr10001 | [Hinet](https://broadband.hinet.net/Broadband/internetManagement/internet/internet/internet_02.do) |
| EDGG11000        | EDCR12345678 | EDCR           | GG-GAPL100v02   | GG-11000-C003    | Remooh    | [Vivo (Vivo 1/São Paulo region)](https://www.vivo.com.br/para-voce/produtos-e-servicos/para-casa/internet) |
| F670L            | ZTEGC457BB2F | ZTEG           | V9.0            | V9.0.11P1N13     | ombuncit | [Indihome](https://indihome.co.id/) |
| F620             | ZTEGC44EF6FF | ZTEG           | V7.0            | V9.0.10P4N3      | erwin c   | [TM](https://www.unifi.com.my/) |
| HG8245Q2         | HWTC12345678 | HWTC           | B99.A           | V3R019C10S375    | killme56k | [Claro Brazil](https://www.claro.com.br/internet/banda-larga) |
| RTF3505VW-N1     | BRCM12345678 | ASKY           | RTF3505VW-N1    | R3505VWN1001     | Remooh    | [Vivo (Vivo 1/São Paulo region)](https://www.vivo.com.br/para-voce/produtos-e-servicos/para-casa/internet) |
| H640GO           | DSNW12345678 | DSNW           | H640GO          | 4.01p1-3090      | akw28888 | [TAIFO](https://www.taipeifiber.com.tw/) |
| G-140W-H         | ALCLFBE950F3 | ALCL           | 3FE48054BDAA    | 3FE48077HJIJ86   | azambuja | [Oi Fibra](https://www.oi.com.br/internet) |
| EDGG11000        | EDCR12345678 | EDCR           | R1              | 1.2.8            | koge97   | [Movistar Chile](https://ww2.movistar.cl/hogar/internet-hogar/) |

