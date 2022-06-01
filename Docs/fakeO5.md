# `O5` No Internet
This known issue with Alcatel/Nokia OLT giving fake `O5` ONU Status, OLT will hold OMCI Provisioning until correct OMCI Information

# Value to try
In this examplme, will be using Huawei HG8240H as example.

## Subscriber Identity
```
flash set GPON_PLOAM_FORMAT 1
flash set GPON_PLOAM_PASSWD DEFAULT012
```

## Device Identitiy
```
flash set GPON_ONU_MODEL HG8240H
flash set GPON_SN HWTC12345678
flash set PON_VENDOR_ID HWTC
flash set HW_HWVER BF9.A
flash set OMCI_SW_VER1 V3R017C10S100
flash set OMCI_SW_VER2 V3R017C10S100
```

## Device Capability
```
flash set OMCC_VER 128
flash set OMCI_TM_OPT 0
flash set OMCI_FAKE_OK 1
flash set OMCI_OLT_MODE 1
```

If still no luck, try `flash all` to print all then see any `OMCI_*`
