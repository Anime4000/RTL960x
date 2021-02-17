# cat runigmp.sh
#!/bin/sh

if [ -d /proc/rg ]; then
        rg_igmp=1
else
        rg_igmp=0
fi

create_igmp_conf ()
{
        if [ ! -f /var/config/igmp_gpon.conf ]; then
                cp /etc/igmp_gpon.conf /var/config/igmp_gpon.conf
        fi
}

if [ "$rg_igmp" == "0" ]; then
        create_igmp_conf
        insmod /lib/modules/igmp_drv.ko
        wait 1
        igmpd -f /var/config/igmp_gpon.conf &
fi
