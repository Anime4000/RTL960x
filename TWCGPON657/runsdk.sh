# cat runsdk.sh
#!/bin/sh

pon_mode=`flash get PON_MODE`
fiber_mode=`flash get FIBER_MODE | sed 's/FIBER_MODE=//g'`
if [ "$pon_mode" == "PON_MODE=1" ]; then
                /etc/runomci.sh
                /bin/pondetect &
                echo "running GPON mode ..."
elif [ "$pon_mode" == "PON_MODE=2" ]; then
        insmod /lib/modules/epon_drv.ko
        /etc/runoam.sh
        insmod epon_polling.ko
        insmod epon_mpcp.ko
        sleep 2
        /bin/pondetect &
        echo "running EPON mode ..."
elif [ "$pon_mode" == "PON_MODE=3" ]; then
        echo $fiber_mode > proc/fiber_mode
elif echo $pon_mode | grep -q "GET fail"; then
        echo $fiber_mode > proc/fiber_mode
else
        echo "running Ether mode..."
fi

insmod rldp_drv.ko

