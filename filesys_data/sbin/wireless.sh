#!/bin/sh

. /sbin/config.sh
. /sbin/global.sh
. /sbin/function.sh

lan_ip=`nvram_get 2860 lan_ipaddr`
stp_en=`nvram_get 2860 stpEnabled`
nat_en=`nvram_get 2860 natEnabled`
radio_off1=`nvram_get 2860 RadioOff`
radio_off2=`nvram_get rtdev RadioOff`
radio_off3=`nvram_get wifi3 RadioOff`
wifi_off=`nvram_get 2860 WiFiOff`

Platform2="2860"
Platform5="rtdev"

if [ "$1" = "stop" ]; then
	echo "=================stop======================"
#	init_nvram
	stop_wireless
elif [ "$1" = "start" ]; then
	echo "=================start======================"
#	init_nvram
	start_wireless_all
elif [ "$1" = "restart" ]; then
	echo "=================restart======================"
#	init_nvram
	stop_wireless
	start_wireless_all
fi
	
