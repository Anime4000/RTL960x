# cat /etc/runomci.sh
#!/bin/sh

get_omci_dbg_level ()
{
        dbgLevel=`flash get OMCI_DBGLVL | sed 's/OMCI_DBGLVL=//g'`

        case "$dbgLevel" in
                0)
                        dbgLevel_opt="off"
                        ;;
                1)
                        dbgLevel_opt="driver"
                        ;;
                2)
                        dbgLevel_opt="high"
                        ;;
                3)
                        dbgLevel_opt="normal"
                        ;;
                4)
                        dbgLevel_opt="low"
                        ;;
                *)
                        dbgLevel_opt="off"
                        ;;
        esac
        echo $dbgLevel_opt
}

get_omci_log_format ()
{
        logFormat=`flash get OMCI_LOGFILE | sed 's/OMCI_LOGFILE=//g'`
        logMask=`flash get OMCI_LOGFILE_MASK | sed 's/OMCI_LOGFILE_MASK=//g'`

        case "$logFormat" in
                0)
                        logFormat_opt="off"
                        ;;
                1)
                        logFormat_opt="raw"
                        ;;
                2)
                        logFormat_opt="parsed"
                        ;;
                3)
                        logFormat_opt="both"
                        ;;
                7)
                        logFormat_opt="time"
                        ;;
                *)
                        logFormat_opt="off"
                        ;;
        esac
        logFormat_opt=$logFormat_opt" $logMask"
        echo $logFormat_opt
}

get_omci_dual_mgmt_mode ()
{
        dualMgmt=`flash get DUAL_MGMT_MODE | sed 's/DUAL_MGMT_MODE=//g'`

        case "$dualMgmt" in
                0)
                        dualMgmt_opt="disable"
                        ;;
                1)
                        dualMgmt_opt="enable"
                        ;;
                *)
                        dualMgmt_opt="disable"
                        ;;
        esac
        echo $dualMgmt_opt
}

get_omci_dev_type ()
{
        devType=`flash get DEVICE_TYPE | sed 's/DEVICE_TYPE=//g'`

        case "$devType" in
                0)
                        devType_opt="bridge"
                        ;;
                1)
                        devType_opt="router"
                        ;;
                2)
                        devType_opt="hybrid"
                        ;;
                *)
                        devType_opt="bridge"
                        ;;
        esac
        echo $devType_opt
}

get_omci_cus_conf ()
{
        cus_conf=""
        cus_bridge=`flash get OMCI_CUSTOM_BDP | sed 's/OMCI_CUSTOM_BDP=//g'`
        if [ -n "$cus_bridge" ]; then
                cus_conf=$cus_conf" -cb $cus_bridge"
        fi

        cus_route=`flash get OMCI_CUSTOM_RDP | sed 's/OMCI_CUSTOM_RDP=//g'`
        if [ -n "$cus_route" ]; then
                cus_conf=$cus_conf" -cr $cus_route"
        fi

        cus_mcast=`flash get OMCI_CUSTOM_MCAST | sed 's/OMCI_CUSTOM_MCAST=//g'`
        if [ -n "$cus_mcast" ]; then
                cus_conf=$cus_conf" -cmc $cus_mcast"
        fi

        cus_me=`flash get OMCI_CUSTOM_ME | sed 's/OMCI_CUSTOM_ME=//g'`
        if [ -n "$cus_me" ]; then
                cus_conf=$cus_conf" -cme $cus_me"
        fi


        echo $cus_conf
}

get_omci_iot_vlan_cfg ()
{
        iot_vlan_cfg=""
        vlan_type=`flash get VLAN_CFG_TYPE | sed 's/VLAN_CFG_TYPE=//g' | grep -v fail`
        vlan_manu_mode=`flash get VLAN_MANU_MODE | sed 's/VLAN_MANU_MODE=//g' | grep -v fail`
        vlan_manu_vid=`flash get VLAN_MANU_TAG_VID | sed 's/VLAN_MANU_TAG_VID=//g' | grep -v fail`
        vlan_manu_pri=`flash get VLAN_MANU_TAG_PRI | sed 's/VLAN_MANU_TAG_PRI=//g' | grep -v fail`

        if [ -n "$vlan_type" ]; then

                case "$vlan_type" in
                        1)
                                case "$vlan_manu_mode" in
                                        1)
                                                if [ -n "$vlan_manu_vid" ] && [ -n "$vlan_manu_pri" ]; then
                                                        iot_vlan_cfg=$iot_vlan_cfg" -iot_vt 1 -iot_vm 1 -iot_vid $vlan_manu_vid -iot_pri $vlan_manu_pri"
                                                fi
                                                ;;
                                        *)
                                                if [ -z "$vlan_manu_mode" ]; then
                                                        vlan_manu_mode=255
                                                fi
                                                iot_vlan_cfg=$iot_vlan_cfg" -iot_vt 1 -iot_vm $vlan_manu_mode -iot_vid 65535 -iot_pri 255"
                                                ;;
                                esac
                                ;;
                        *)
                                if [ -z "$vlan_manu_mode" ]; then
                                        vlan_manu_mode="255"
                                fi
                                iot_vlan_cfg=$iot_vlan_cfg" -iot_vt 0 -iot_vm $vlan_manu_mode -iot_vid 65535 -iot_pri 255"
                                ;;
                esac
        fi
        echo $iot_vlan_cfg
}

get_omci_veip_slot_id_conf ()
{
        veip_slot_id_conf=""

        veip_slot_value=`flash get OMCI_VEIP_SLOT_ID | sed 's/OMCI_VEIP_SLOT_ID=//g'`

        if [ -n "$veip_slot_value" ]; then
                veip_slot_id_conf=$veip_slot_id_conf" -slot_veip $veip_slot_value"
        fi

        echo $veip_slot_id_conf
}

get_omci_voice_vendor ()
{
        voice_vendor=""

        if [ -f /etc/rc_voip ]; then
                voice_vendor=$voice_vendor" -voice_vendor 1"
        else
                voice_vendor=$voice_vendor" -voice_vendor 0"
        fi

        echo $voice_vendor
}
gpon_sn=`flash get GPON_SN | sed 's/GPON_SN=//g'`
gpon_ploam_pwd=`flash get GPON_PLOAM_PASSWD | sed 's/GPON_PLOAM_PASSWD=//g'`
gpon_loid=`flash get LOID | sed 's/LOID=//g'`
gpon_loidPwd=`flash get LOID_PASSWD | sed 's/LOID_PASSWD=//g'`

if [ -n "$gpon_ploam_pwd" ]; then
        gpon_ploam_pwd_set="-p $gpon_ploam_pwd"
else
        gpon_ploam_pwd_set=""
fi

if [ -n "$gpon_loid" ]; then
        gpon_loid_set="-l $gpon_loid"
else
        gpon_loid_set=""
fi

if [ -n "$gpon_loidPwd" ]; then
        gpon_loidPwd_set="-w $gpon_loidPwd"
else
    gpon_loidPwd_set=""
fi

if [ $(get_omci_dev_type) == "bridge" ]; then
        /etc/runigmp.sh
fi

omci_app -s $gpon_sn -f $(get_omci_log_format) -m $(get_omci_dual_mgmt_mode) -d $(get_omci_dbg_level) -t $(get_omci_dev_type) $gpon_ploam_pwd_set $gpon_loid_set $gpon_loidPwd_set $(get_omci_cus_conf) $(get_omci_iot_vlan_cfg) $(get_omci_veip_slot_id_conf) $(get_omci_voice_vendor) &

