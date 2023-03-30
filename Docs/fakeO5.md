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

## For Users using CHT FTTH in Taiwan
You can call to support center `0800-080-412` then tell them "重整線路" or reset the port from the [web portal](https://my.cht.com.tw/Trouble) to clear some config cache on the OLT.

## For Users using TAIFO in Taiwan
Their GEM and VLAN configs are so strange, for example they don't use ME 84 to filter VLAN.
They are using QinQ, and they are trunk all VLANs to ONU and filtering nothing.
If you tag the wrong VLAN, you still can see PPPoE BRAS, but you will get a 691 error.

You can get correct VLAN through ```omcicli mib get 171```, the  Filter Outer/Inner values are the QinQ Outer/Inner VLAN IDs.

## For Users using Vivo Fibra in the Vivo 1/São Paulo region
You might try setting the following values, they were copied from a stock EdgeCore GG-11000 ONU:
```
flash set OMCC_VER 160
flash set OMCI_TM_OPT 1
```
If using `DFP-34X-2C2`, one option to avoid the `OMCI_SW_VER*` override after reboot is to set the following value, as discussed [here](https://github.com/Anime4000/RTL960x/issues/30#issuecomment-1146604684):
```
flash set OMCI_OLT_MODE 21
```
The VLAN tag for the internet is not being mapped to `10` like the stock ONU, so check the output of `omcicli mib get 84` to get the tag. In my case the VLAN tag for the internet is `885`.
