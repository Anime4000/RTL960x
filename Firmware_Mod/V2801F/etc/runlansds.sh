#!/bin/sh

echo 1 > /proc/lan_sds/lan_sds_cfg
echo 1 > /proc/lan_sds/sfp_app
sfpapp &
