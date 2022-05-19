# Stock ONU
here list known ONU device for OMCI Info Cloning, making your xPON ONU SFP Stick act like your original ONU to fool Fiber Vendor OLT

## Telnet `flash set`
![example](Images/HG8240H5_example.png)
```
flash set GPON_ONU_MODEL 
flash set GPON_SN 
flash set PON_VENDOR_ID 
flash set HW_HWVER 
flash set OMCI_SW_VER1 
flash set OMCI_SW_VER2 
```
Use value from table below

# OMCI Info
| `GPON_ONU_MODEL` | `GPON_SN`    |`PON_VENDOR_ID` | `HW_HWVER`      | `OMCI_SW_VER#`   | Owner     | ISP |
|------------------|--------------|----------------|-----------------|------------------|-----------|-----|
| EG8010Hv6        | HWTC12345678 | HWTC           | 260F.A          | V5R020C10S035    | lwk523    | [Allo](https://www.allo.my/city-broadband/) |
| HG8240H          | HWTC12345678 | HWTC           | BF9.A           | V3R017C10S100    | hezaika   | [TIME](https://www.time.com.my/personal/broadband/fibre-broadband) |
| HG8240H5         | HWTC12345678 | HWTC           | 168D.A          | V5R019C00S125    | anime4000 | [TM](https://www.unifi.com.my/) |
| HG8145V5         | HWTC12345678 | HWTC           | 15AD.A          | V5R020C00S060    | hezaika   | [TIME](https://www.time.com.my/personal/broadband/fibre-broadband) |
| G-240G-E         | ALCL12345678 | ALCL           | 3FE48153CBAA    | 3FE46606BGCB45   | anime4000 | [TM](https://www.unifi.com.my/) |
| HG6240A          | FHTT12345678 | FHTT           | WKE2.094.325A01 | RP2775           | lwk523    | [TM](https://www.unifi.com.my/) |
