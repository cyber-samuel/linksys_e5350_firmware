#!/bin/sh

# $Id: //WIFI_SOC/MP/SDK_5_0_0_0/RT288x_SDK/source/user/rt2880_app/scripts/config-vlan.sh#2 $
#
# usage: config-vlan.sh <switch_type> <vlan_type>
#   switch_type: 0=IC+, 1=vtss
#   vlan_type: 0=no_vlan, 1=vlan, LLLLW=wan_4, WLLLL=wan_0
# 

. /sbin/config.sh
. /sbin/global.sh
. /sbin/function.sh

usage()
{
	echo "Usage:"
	echo "  $0 0 0 - restore IC+ to no VLAN partition"
	echo "  $0 0 LLLLW - config IC+ with VLAN and WAN at port 4"
	echo "  $0 0 WLLLL - config IC+ with VLAN and WAN at port 0"
	echo "  $0 1 0 - restore Vtss to no VLAN partition"
	echo "  $0 1 LLLLW - config Vtss with VLAN and WAN at port 4"
	echo "  $0 1 WLLLL - config Vtss with VLAN and WAN at port 0"
	echo "  $0 2 0 - restore Ralink ESW to no VLAN partition"
	echo "  $0 2 LLLLW - config Ralink ESW with VLAN and WAN at port 4"
	echo "  $0 2 WLLLL - config Ralink ESW with VLAN and WAN at port 0"
	echo "  $0 2 W1234 - config Ralink ESW with VLAN 5 at port 0 and VLAN 1~4 at port 1~4"
	echo "  $0 2 12345 - config Ralink ESW with VLAN 1~5 at port 0~4"
	echo "  $0 2 VLAN - config Ralink ESW with VLAN Settings and WAN at port 4"
	echo "  $0 2 GW - config Ralink ESW with WAN at Giga port"
	echo "  $0 2 G01234 - config Ralink ESW with VLAN 6 at Giga port, and VLAN 1~5 at port 0~4"
	echo "  $0 3 0 - restore Ralink RT6855/MT7620/MT7621 ESW to no VLAN partition"
	echo "  $0 3 LLLLW - config Ralink RT6855/MT7620/MT7621 ESW with VLAN and WAN at port 4"
	echo "  $0 3 WLLLL - config Ralink RT6855/MT7620/MT7621 ESW with VLAN and WAN at port 0"
	echo "  $0 3 12345 - config Ralink RT6855/MT7620/MT7621 ESW with VLAN 1~5 at port 0~4"
	echo "  $0 3 GW - config Ralink RT6855/MT7620/MT7621 ESW with WAN at Giga port"
	exit 0
}

config175C()
{
	mii_mgr -s -p 29 -r 23 -v 0x07c2
	mii_mgr -s -p 29 -r 22 -v 0x8420

	if [ "$1" = "LLLLW" ]; then
		mii_mgr -s -p 29 -r 24 -v 0x1
		mii_mgr -s -p 29 -r 25 -v 0x1
		mii_mgr -s -p 29 -r 26 -v 0x1
		mii_mgr -s -p 29 -r 27 -v 0x1
		mii_mgr -s -p 29 -r 28 -v 0x2
		mii_mgr -s -p 30 -r 9 -v 0x1089
		if [ "$CONFIG_RALINK_VISTA_BASIC" == "y" ]; then
			mii_mgr -s -p 30 -r 1 -v 0x2f3f
		else
			mii_mgr -s -p 30 -r 1 -v 0x2f00
		fi
		mii_mgr -s -p 30 -r 2 -v 0x0030
	elif [ "$1" = "WLLLL" ]; then
		mii_mgr -s -p 29 -r 24 -v 0x2
		mii_mgr -s -p 29 -r 25 -v 0x1
		mii_mgr -s -p 29 -r 26 -v 0x1
		mii_mgr -s -p 29 -r 27 -v 0x1
		mii_mgr -s -p 29 -r 28 -v 0x1
		mii_mgr -s -p 30 -r 9 -v 0x0189
		if [ "$CONFIG_RALINK_VISTA_BASIC" == "y" ]; then
			mii_mgr -s -p 30 -r 1 -v 0x3e3f
		else
			mii_mgr -s -p 30 -r 1 -v 0x3e00
		fi
		mii_mgr -s -p 30 -r 2 -v 0x0021
	else
		echo "LAN WAN layout $0 is not suported"
	fi
}

restore175C()
{
	mii_mgr -s -p 29 -r 23 -v 0x0
	mii_mgr -s -p 29 -r 22 -v 0x420
	mii_mgr -s -p 29 -r 24 -v 0x1
	mii_mgr -s -p 29 -r 25 -v 0x1
	mii_mgr -s -p 29 -r 26 -v 0x1
	mii_mgr -s -p 29 -r 27 -v 0x1
	mii_mgr -s -p 29 -r 27 -v 0x2
	mii_mgr -s -p 30 -r 9 -v 0x1001
	mii_mgr -s -p 30 -r 1 -v 0x2f3f
	mii_mgr -s -p 30 -r 2 -v 0x3f30
}

restore175D()
{
	mii_mgr -s -p 20 -r  4 -v 0xa000
	mii_mgr -s -p 20 -r 13 -v 0x20
	mii_mgr -s -p 21 -r  1 -v 0x1800
	mii_mgr -s -p 22 -r  0 -v 0x0
	mii_mgr -s -p 22 -r  2 -v 0x0
	mii_mgr -s -p 22 -r 10 -v 0x0
	mii_mgr -s -p 22 -r 14 -v 0x1
	mii_mgr -s -p 22 -r 15 -v 0x2
	mii_mgr -s -p 23 -r  8 -v 0x0
	mii_mgr -s -p 23 -r 16 -v 0x0

	mii_mgr -s -p 22 -r 4 -v 0x1
	mii_mgr -s -p 22 -r 5 -v 0x1
	mii_mgr -s -p 22 -r 6 -v 0x1
	mii_mgr -s -p 22 -r 7 -v 0x1
	mii_mgr -s -p 22 -r 8 -v 0x1
	mii_mgr -s -p 23 -r 0 -v 0x3f3f
}

config175D()
{
	mii_mgr -s -p 20 -r  4 -v 0xa000
	mii_mgr -s -p 20 -r 13 -v 0x21
	mii_mgr -s -p 21 -r  1 -v 0x1800
	mii_mgr -s -p 22 -r  0 -v 0x27ff
	mii_mgr -s -p 22 -r  2 -v 0x20
	mii_mgr -s -p 22 -r  3 -v 0x8100
	mii_mgr -s -p 22 -r 10 -v 0x3
	mii_mgr -s -p 22 -r 14 -v 0x1001
	mii_mgr -s -p 22 -r 15 -v 0x2002
	mii_mgr -s -p 23 -r  8 -v 0x2020
	mii_mgr -s -p 23 -r 16 -v 0x1f1f
	if [ "$1" = "LLLLW" ]; then
		mii_mgr -s -p 22 -r 4 -v 0x1
		mii_mgr -s -p 22 -r 5 -v 0x1
		mii_mgr -s -p 22 -r 6 -v 0x1
		mii_mgr -s -p 22 -r 7 -v 0x1
		mii_mgr -s -p 22 -r 8 -v 0x2
		mii_mgr -s -p 23 -r 0 -v 0x302f
	elif [ "$1" = "WLLLL" ]; then
		mii_mgr -s -p 22 -r 4 -v 0x2
		mii_mgr -s -p 22 -r 5 -v 0x1
		mii_mgr -s -p 22 -r 6 -v 0x1
		mii_mgr -s -p 22 -r 7 -v 0x1
		mii_mgr -s -p 22 -r 8 -v 0x1
		mii_mgr -s -p 23 -r 0 -v 0x213e
	else
		echo "LAN WAN layout $0 is not suported"
	fi
}

config7530Esw()
{
	#LAN/WAN ports as security mode
	switch_7530 reg w 2004 ff0003 #port0
	switch_7530 reg w 2104 ff0003 #port1
	switch_7530 reg w 2204 ff0003 #port2
	switch_7530 reg w 2304 ff0003 #port3
	switch_7530 reg w 2404 ff0003 #port4
	switch_7530 reg w 2504 ff0003 #port5
	#LAN/WAN ports as transparent port
	switch_7530 reg w 2010 810000c0 #port0
	switch_7530 reg w 2110 810000c0 #port1
	switch_7530 reg w 2210 810000c0 #port2
	switch_7530 reg w 2310 810000c0 #port3	
	switch_7530 reg w 2410 810000c0 #port4
	switch_7530 reg w 2510 810000c0 #port5
	#set CPU/P7 port as user port
	switch_7530 reg w 2610 81000000 #port6
	switch_7530 reg w 2710 81000000 #port7

	switch_7530 reg w 2604 20ff0003 #port6, Egress VLAN Tag Attribution=tagged
	switch_7530 reg w 2704 20ff0003 #port7, Egress VLAN Tag Attribution=tagged
	if [ "$CONFIG_RAETH_SPECIAL_TAG" == "y" ]; then
	    echo "Special Tag Enabled"
		switch_7530 reg w 2610 81000020 #port6
		#VLAN member port
		switch_7530 vlan set  0 1 10000010
		switch_7530 vlan set  0 2 01000010
		switch_7530 vlan set  0 3 00100010
		switch_7530 vlan set  0 4 00010010
		switch_7530 vlan set  0 5 00001010
		switch_7530 vlan set  0 6 00000110
		switch_7530 vlan set  0 7 00000110
	else
	    echo "Special Tag Disabled"
		switch_7530 reg w 2610 81000000 #port6
	fi

	if [ "$1" = "LLLLW" ]; then
		if [ "$CONFIG_RAETH_SPECIAL_TAG" == "y" ]; then
		#set PVID
		switch_7530 reg w 2014 10007 #port0
		switch_7530 reg w 2114 10007 #port1
		switch_7530 reg w 2214 10007 #port2
		switch_7530 reg w 2314 10007 #port3
		switch_7530 reg w 2414 10008 #port4
		switch_7530 reg w 2514 10007 #port5
		#VLAN member port
		switch_7530 vlan set 0 1 10000010
		switch_7530 vlan set 0 2 01000010
		switch_7530 vlan set 0 3 00100010
		switch_7530 vlan set 0 4 00010010
		switch_7530 vlan set 0 5 00001010
		switch_7530 vlan set 0 6 00000110
		switch_7530 vlan set 0 7 11110110
		switch_7530 vlan set 0 8 00001010
		else
		#set PVID
		switch_7530 reg w 2014 10001 #port0
		switch_7530 reg w 2114 10001 #port1
		switch_7530 reg w 2214 10001 #port2
		switch_7530 reg w 2314 10001 #port3
		switch_7530 reg w 2414 10002 #port4
		switch_7530 reg w 2514 10001 #port5
		#VLAN member port
		switch_7530 vlan set  0 1 11110110
		switch_7530 vlan set  0 2 00001010
		fi
	elif [ "$1" = "WLLLL" ]; then
		if [ "$CONFIG_RAETH_SPECIAL_TAG" == "y" ]; then
		#set PVID
		switch_7530 reg w 2014 10008 #port0
		switch_7530 reg w 2114 10007 #port1
		switch_7530 reg w 2214 10007 #port2
		switch_7530 reg w 2314 10007 #port3
		switch_7530 reg w 2414 10007 #port4
		switch_7530 reg w 2514 10007 #port5
		#VLAN member port
		switch_7530 vlan set  0 5 10000010
		switch_7530 vlan set  0 1 01000010
		switch_7530 vlan set  0 2 00100010
		switch_7530 vlan set  0 3 00010010
		switch_7530 vlan set  0 4 00001010
		switch_7530 vlan set  0 6 00000110
		switch_7530 vlan set  0 7 01111110
		switch_7530 vlan set  0 8 10000010
		else
		#set PVID
		switch_7530 reg w 2014 10002 #port0
		switch_7530 reg w 2114 10001 #port1
		switch_7530 reg w 2214 10001 #port2
		switch_7530 reg w 2314 10001 #port3
		switch_7530 reg w 2414 10001 #port4
		switch_7530 reg w 2514 10001 #port5
		#VLAN member port
		switch_7530 vlan set  0 1 01111110
		switch_7530 vlan set  0 2 10000010
		fi
	elif [ "$1" = "W1234" ]; then
		echo "W1234"
		#set PVID
		switch_7530 reg w 2014 10005 #port0
		switch_7530 reg w 2114 10001 #port1
		switch_7530 reg w 2214 10002 #port2
		switch_7530 reg w 2314 10003 #port3
		switch_7530 reg w 2414 10004 #port4
		switch_7530 reg w 2514 10006 #port5
		#VLAN member port
		switch_7530 vlan set  0 5 10000010
		switch_7530 vlan set  0 1 01000010
		switch_7530 vlan set  0 2 00100010
		switch_7530 vlan set  0 3 00010010
		switch_7530 vlan set  0 4 00001010
		switch_7530 vlan set  0 6 00000110
	   
	elif [ "$1" = "12345" ]; then
		echo "12345"
		#set PVID
		switch_7530 reg w 2014 10001 #port0
		switch_7530 reg w 2114 10002 #port1
		switch_7530 reg w 2214 10003 #port2
		switch_7530 reg w 2314 10004 #port3
		switch_7530 reg w 2414 10005 #port4
		switch_7530 reg w 2514 10006 #port5
		#VLAN member port
		switch_7530 vlan set  0 1 10000010
		switch_7530 vlan set  0 2 01000010
		switch_7530 vlan set  0 3 00100010
		switch_7530 vlan set  0 4 00010010
		switch_7530 vlan set  0 5 00001010
		switch_7530 vlan set  0 6 00000110
	elif [ "$1" = "GW" ]; then
		echo "GW"
		#set PVID
		switch_7530 reg w 2014 10001 #port0
		switch_7530 reg w 2114 10001 #port1
		switch_7530 reg w 2214 10001 #port2
		switch_7530 reg w 2314 10001 #port3
		switch_7530 reg w 2414 10001 #port4
		switch_7530 reg w 2514 10002 #port5
		#VLAN member port
		switch_7530 vlan set  0 1 11111010
		switch_7530 vlan set  0 2 00000110
	fi

	#clear mac table if vlan configuration changed
	switch_7530 clear
}



config6855Esw()
{
	#LAN/WAN ports as security mode
	switch reg w 2004 ff0003 #port0
	switch reg w 2104 ff0003 #port1
	switch reg w 2204 ff0003 #port2
	switch reg w 2304 ff0003 #port3
	switch reg w 2404 ff0003 #port4
	switch reg w 2504 ff0003 #port5
	#LAN/WAN ports as transparent port
	switch reg w 2010 810000c0 #port0
	switch reg w 2110 810000c0 #port1
	switch reg w 2210 810000c0 #port2
	switch reg w 2310 810000c0 #port3	
	switch reg w 2410 810000c0 #port4
	switch reg w 2510 810000c0 #port5
	#set CPU/P7 port as user port
	switch reg w 2610 81000000 #port6
	switch reg w 2710 81000000 #port7

	switch reg w 2604 20ff0003 #port6, Egress VLAN Tag Attribution=tagged
	switch reg w 2704 20ff0003 #port7, Egress VLAN Tag Attribution=tagged
	if [ "$CONFIG_RAETH_SPECIAL_TAG" == "y" ]; then
	    echo "Special Tag Enabled"
		switch reg w 2610 81000020 #port6

	else
	    echo "Special Tag Disabled"
		switch reg w 2610 81000000 #port6
	fi

	if [ "$1" = "LLLLW" ]; then
		if [ "$CONFIG_RAETH_SPECIAL_TAG" == "y" ]; then
		#set PVID
		switch reg w 2014 10007 #port0
		switch reg w 2114 10007 #port1
		switch reg w 2214 10007 #port2
		switch reg w 2314 10007 #port3
		switch reg w 2414 10008 #port4
		switch reg w 2514 10007 #port5
		#VLAN member port
		switch vlan set 0 1 10000011
		switch vlan set 1 2 01000011
		switch vlan set 2 3 00100011
		switch vlan set 3 4 00010011
		switch vlan set 4 5 00001011
		switch vlan set 5 6 00000111
		switch vlan set 6 7 11110111
		switch vlan set 7 8 00001011
		else
		#set PVID
		switch reg w 2014 10001 #port0
		switch reg w 2114 10001 #port1
		switch reg w 2214 10001 #port2
		switch reg w 2314 10001 #port3
		switch reg w 2414 10002 #port4
		switch reg w 2514 10001 #port5
		#VLAN member port
		switch vlan set 0 1 11110111
		switch vlan set 1 2 00001011
		fi
	elif [ "$1" = "WLLLL" ]; then
		if [ "$CONFIG_RAETH_SPECIAL_TAG" == "y" ]; then
		#set PVID
		switch reg w 2014 10008 #port0
		switch reg w 2114 10007 #port1
		switch reg w 2214 10007 #port2
		switch reg w 2314 10007 #port3
		switch reg w 2414 10007 #port4
		switch reg w 2514 10007 #port5
		#VLAN member port
		switch vlan set 4 5 10000011
		switch vlan set 0 1 01000011
		switch vlan set 1 2 00100011
		switch vlan set 2 3 00010011
		switch vlan set 3 4 00001011
		switch vlan set 5 6 00000111
		switch vlan set 6 7 01111111
		switch vlan set 7 8 10000011
		else
		#set PVID
		switch reg w 2014 10002 #port0
		switch reg w 2114 10001 #port1
		switch reg w 2214 10001 #port2
		switch reg w 2314 10001 #port3
		switch reg w 2414 10001 #port4
		switch reg w 2514 10001 #port5
		#VLAN member port
		switch vlan set 0 1 01111111
		switch vlan set 1 2 10000011
		fi
	elif [ "$1" = "W1234" ]; then
		echo "W1234"
		#set PVID
		switch reg w 2014 10005 #port0
		switch reg w 2114 10001 #port1
		switch reg w 2214 10002 #port2
		switch reg w 2314 10003 #port3
		switch reg w 2414 10004 #port4
		switch reg w 2514 10006 #port5
		#VLAN member port
		switch vlan set 4 5 10000011
		switch vlan set 0 1 01000011
		switch vlan set 1 2 00100011
		switch vlan set 2 3 00010011
		switch vlan set 3 4 00001011
		switch vlan set 5 6 00000111
	elif [ "$1" = "12345" ]; then
		echo "12345"
		#set PVID
		switch reg w 2014 10001 #port0
		switch reg w 2114 10002 #port1
		switch reg w 2214 10003 #port2
		switch reg w 2314 10004 #port3
		switch reg w 2414 10005 #port4
		switch reg w 2514 10006 #port5
		#VLAN member port
		switch vlan set 0 1 10000011
		switch vlan set 1 2 01000011
		switch vlan set 2 3 00100011
		switch vlan set 3 4 00010011
		switch vlan set 4 5 00001011
		switch vlan set 5 6 00000111
	elif [ "$1" = "GW" ]; then
		echo "GW"
		#set PVID
		switch reg w 2014 10001 #port0
		switch reg w 2114 10001 #port1
		switch reg w 2214 10001 #port2
		switch reg w 2314 10001 #port3
		switch reg w 2414 10001 #port4
		switch reg w 2514 10002 #port5
		#VLAN member port
		switch vlan set 0 1 11111011
		switch vlan set 1 2 00000111
	fi

	#clear mac table if vlan configuration changed
	switch clear
}

configEsw()
{
	switch reg w 14 405555
	switch reg w 50 2001
	switch reg w 98 7f3f
if [ "$CONFIG_RAETH_SPECIAL_TAG" == "y" ]; then
	switch reg w e4 40043f  
else
	switch reg w e4 3f
fi

	if [ "$1" = "LLLLW" ]; then
if [ "$CONFIG_RAETH_SPECIAL_TAG" == "y" ]; then
		switch reg w 40 7007
		switch reg w 44 7007
		switch reg w 48 7008
		switch reg w 70 48444241
		switch reg w 74 50ef6050
else
		switch reg w 40 1001
		switch reg w 44 1001
		switch reg w 48 1002
		switch reg w 70 ffff506f
fi
	elif [ "$1" = "WLLLL" ]; then
if [ "$CONFIG_RAETH_SPECIAL_TAG" == "y" ]; then
		switch reg w 40 7008
		switch reg w 44 7007
		switch reg w 48 7007
		switch reg w 70 48444241
		switch reg w 74 41fe6050
else
		switch reg w 40 1002
		switch reg w 44 1001
		switch reg w 48 1001
		switch reg w 70 ffff417e
fi
	elif [ "$1" = "W1234" ]; then
		switch reg w 40 1005
		switch reg w 44 3002
		switch reg w 48 1004
		switch reg w 70 50484442
		switch reg w 74 ffffff41
	elif [ "$1" = "12345" ]; then
		switch reg w 40 2001
		switch reg w 44 4003
		switch reg w 48 1005
		switch reg w 70 48444241
		switch reg w 74 ffffff50
	elif [ "$1" = "GW" ]; then
		switch reg w 40 1001
		switch reg w 44 1001
		switch reg w 48 2001
		switch reg w 70 ffff605f
	elif [ "$1" = "G01234" ]; then
		switch reg w 40 2001
		switch reg w 44 4003
		switch reg w 48 6005
		switch reg w 70 48444241
		switch reg w 74 ffff6050
	fi

	#clear mac table if vlan configuration changed
	switch clear
}

##Add vlan intface
configVlanIF()
{
	vlanif="$1"
	vlanid="$2"
	echo "##### config Vlan interface in VLAN mode #####"
	if [ "$CONFIG_TASKLET_WORKQUEUE_SW" == "y" ]; then
		ifconfig eth2 down
		PLATFORM=`nvram_get 2860 Platform | tr A-Z a-z`
		if [ "$wanmode" == "PPPOE" -o "$wanmode" == "L2TP" -o "$wanmode" == "PPTP" ]; then
			echo 1 > /proc/$PLATFORM/schedule
		else
			echo 0 > /proc/$PLATFORM/schedule
		fi
	fi
	ifconfig ${vlanif} 0.0.0.0
	if [ "$CONFIG_GE2_RGMII_AN" = "y" -o "$CONFIG_GE2_INTERNAL_GPHY" = "y" ]; then
		ifconfig eth3 up
		enableIPv6dad eth3 2

	elif [ "$CONFIG_RAETH_ROUTER" = "y" -o "$CONFIG_MAC_TO_MAC_MODE" = "y" -o "$CONFIG_RT_3052_ESW" = "y" ]; then

		echo "First remmove all vlan interfaces..."
		for vlan in $(cat /proc/net/vlan/config |grep eth2 |cut -d" " -f1);do
			vconfig rem $vlan
		done
		#vconfig rem "${vlanif}.${vlanid}"
		#vconfig rem eth2.1
		#vconfig rem eth2.2
		if [ "$CONFIG_RAETH_SPECIAL_TAG" == "y" ]; then
			vconfig rem eth2.3
			vconfig rem eth2.4
			vconfig rem eth2.5
		fi
		rmmod 8021q
		if [ "$CONFIG_VLAN_8021Q" == "m" ]; then
		insmod -q 8021q
		fi

		vconfig add eth2 1
		set_vlan_map eth2.1
		vconfig add ${vlanif} ${vlanid}
		set_vlan_map "${vlanif}.${vlanid}"

		if [ "$CONFIG_RAETH_SPECIAL_TAG" == "y" ]; then
			vconfig add eth2 3
			set_vlan_map eth2.3
			vconfig add eth2 4
			set_vlan_map eth2.4
			vconfig add eth2 5
			set_vlan_map eth2.5

			if [ "$CONFIG_WAN_AT_P0" = "y" ]; then
				ifconfig eth2.1 down
				wan_mac=`nvram_get 2860 WAN_MAC_ADDR`
				if [ "$wan_mac" != "FF:FF:FF:FF:FF:FF" ]; then
					ifconfig eth2.1 hw ether $wan_mac
				fi
				enableIPv6dad eth2.1 1
			else
				ifconfig eth2.5 down
				wan_mac=`nvram_get 2860 WAN_MAC_ADDR`
				if [ "$wan_mac" != "FF:FF:FF:FF:FF:FF" ]; then
					ifconfig eth2.5 hw ether $wan_mac
				fi
				enableIPv6dad eth2.5 1
			fi
		else
			ifconfig "${vlanif}.${vlanid}" down
			wan_mac=`nvram_get 2860 WAN_MAC_ADDR`
			if [ "$wan_mac" != "FF:FF:FF:FF:FF:FF" ]; then
				ifconfig "${vlanif}.${vlanid}" hw ether $wan_mac
				ifconfig "${vlanif}.${vlanid}" hw ether $wan_mac
				ifconfig "${vlanif}.${vlanid}" hw ether $wan_mac
			fi
			enableIPv6dad "${vlanif}.${vlanid}" 1
		fi

		ifconfig eth2.1 0.0.0.0
		ifconfig "${vlanif}.${vlanid}" 0.0.0.0
		ifconfig "${vlanif}.${vlanid}" 0.0.0.0
		if [ "$CONFIG_RAETH_SPECIAL_TAG" == "y" ]; then
			ifconfig eth2.3 0.0.0.0
			ifconfig eth2.4 0.0.0.0
			ifconfig eth2.5 0.0.0.0
		fi

	elif [ "$CONFIG_ICPLUS_PHY" = "y" ]; then
		#remove ip alias
		# it seems busybox has no command to remove ip alias...
		ifconfig eth2:1 0.0.0.0 1>&2 2>/dev/null
	fi
}

#John.zhu VLAN Settings
configVlan()
{
	vlan_num=`nvram_get  2860 vlan_info`
	if [ -z "${vlan_num}" ]; then
		configEsw LLLLW
		return 
	fi
	#save vlan setting of switch register
	vlan_setup_f="/tmp/vlan_setup.sh"

	port0="0" #lan port1
	port1="0" #lan port2
	port2="0" #lan port3
	port3="0" #lan port4
	port4="0" #wan port
	port5="0" #Not used in 10/10M ethernet
	port6="0" #cpu port

	#pvid assigned to internet port
	intertnet_port_tag_vid="0"
	intertnet_port_untag_vid="0"

	#idx assigned to internet port
	intertnet_port_tag_idx="0"
	intertnet_port_untag_idx="0"

	#all vlan is not enable: on, otherwise, off
	all_vlan_disable="on"  

	#default vlan1 for lan 
	vlan0_port0="1" 
	vlan0_port1="1"
	vlan0_port2="1"
	vlan0_port3="1"

	#vlanx_info of nvram value like:
	#vlan2_info=100,Excluded,Excluded,Excluded,Untagged,Excluded,vlan100,on
	#            ^	   ^	     ^       ^        ^        ^        ^      ^
	#         vlanid wan port  port1   port2    port3  port4 description  enable/disable  

	#for extract vlan info
	pattern='([^,]+),([^,]+),([^,]+),([^,]+),([^,]+),([^,]+),([^,]+),([^,]+)'

	#remove vlan setup file
	rm -rf ${vlan_setup_f}
	
	#user port setting initing must be at the first of the script
if [ "$CONFIG_RAETH_SPECIAL_TAG" == "y" ]; then
	echo "switch reg w e4 40043f" >> ${vlan_setup_f}  
else
	echo "switch reg w e4 3f" >> ${vlan_setup_f}
fi
	i=`expr ${vlan_num} - 1`
	k=`expr ${vlan_num} - 1`
	#idx is used to record vlan number
	idx=${vlan_num}

	#count the sum of idx 
	while [ $k -ge 0 ]; do
		vlanx_info_name="vlan${k}_info"
		vlanx_info=`nvram_get  2860 ${vlanx_info_name}`

		if [ -z "${vlanx_info}" ]; then
			k=`expr $k - 1`
			idx=`expr $idx - 1`
			continue
		fi

		which_pattern=`echo ${vlanx_info} |sed -r -n '/^,/{=;q;}'`
					
		if [ -n "${which_pattern}" ]; then
			#add '2' internet default vlan id for this vlan info for convienience
			vlanx_info="2${vlanx_info}"
		fi
		#get vlan info
		enable=`echo ${vlanx_info} | sed -r "s/${pattern}/\8/"`

		if [ "${enable}" == "off" -a $k -ne 0 ]; then
			k=`expr $k - 1`
			idx=`expr $idx - 1`
			continue
		fi
		k=`expr $k - 1`
	done

	#clear not used vlan group
	j=`expr ${idx} + 1`
	while [ $j -lt 16 ]; do
		echo "switch vlan set ${j} 0 0000000"  >> ${vlan_setup_f}
		j=`expr $j + 1`
	done

	while [ $i -ge 0 ]; do
		vlanx_info_name="vlan${i}_info"
		vlanx_info=`nvram_get  2860 ${vlanx_info_name}`

		if [ -z "${vlanx_info}" ]; then
			i=`expr $i - 1`
			continue
		fi
		#tag port, 1:untag, 0:tag
		tag_port0="1" 
		tag_port1="1"
		tag_port2="1"
		tag_port3="1"
		tag_port4="1"
		tag_port5="1"
		tag_port6="0"

		which_pattern=`echo ${vlanx_info} |sed -r -n '/^,/{=;q;}'`
					
		if [ -n "${which_pattern}" ]; then
			#add '2' internet default vlan id for this vlan info for convienience
			vlanx_info="2${vlanx_info}"
		fi

		#get vlan info
		vlan_id=`echo ${vlanx_info} | sed -r "s/${pattern}/\1/"`
		internet_port=`echo ${vlanx_info} | sed -r "s/${pattern}/\2/"`
		port0=`echo ${vlanx_info} | sed -r "s/${pattern}/\3/"`
		port1=`echo ${vlanx_info} | sed -r "s/${pattern}/\4/"`
		port2=`echo ${vlanx_info} | sed -r "s/${pattern}/\5/"`
		port3=`echo ${vlanx_info} | sed -r "s/${pattern}/\6/"`
		desc=`echo ${vlanx_info} | sed -r "s/${pattern}/\7/"`
		enable=`echo ${vlanx_info} | sed -r "s/${pattern}/\8/"`

		if [ "${enable}" == "off" -a $i -ne 0 ]; then
			i=`expr $i - 1`
			continue
		elif [ "${enable}" == "on" ]; then  
			all_vlan_disable="off"
		fi

		echo "#VLAN idx  ${idx} settings..." >> ${vlan_setup_f}

		#Deal Tagged/Untagged/Excluded
		if [ "${internet_port}" == "Excluded" ]; then
			internet_port="0"
			port6="0"
		else
			if [ "${enable}" == "on" ]; then
				if [ "${internet_port}" == "Tagged" ]; then
					tag_port4="0"
					tag_port6="0"
					tag_port4_pvid="${vlan_id}"
					echo "switch user-port 4"  >> ${vlan_setup_f}
					#set pvid for port4/internet port
					if [ "${intertnet_port_untag_vid}" == "0" ]; then
						intertnet_port_tag_idx="${idx}"
						intertnet_port_tag_vid="${vlan_id}"
						echo "switch pvid 4  ${vlan_id}" >> ${vlan_setup_f}
					fi
				else
					intertnet_port_untag_idx="${idx}"
					intertnet_port_untag_vid="${vlan_id}"
					echo "switch pvid 4  ${vlan_id}" >> ${vlan_setup_f}
				fi
			fi
			internet_port="1"
			port6="0"
		fi
	 
		if [ "${port0}" == "Excluded" ]; then
			port0="0"
		else
			if [ "${enable}" == "on" ]; then
				echo "switch pvid 0  ${vlan_id}"  >> ${vlan_setup_f}
				if [ "${port0}" == "Tagged" ]; then
					tag_port0_pvid="${vlan_id}" 
					tag_port0="0"

				fi
			fi
			echo "switch user-port 0"  >> ${vlan_setup_f}
			port0="1"
			vlan0_port0="0" 
		fi

		if [ "${port1}" == "Excluded" ]; then
			port1="0"
		else
			if [ "${enable}" == "on" ]; then
				echo "switch pvid 1  ${vlan_id}"  >> ${vlan_setup_f}
				if [ "${port1}" == "Tagged" ]; then
					tag_port1_pvid="${vlan_id}" 
					tag_port1="0"
				fi
			fi
			echo "switch user-port 1"  >> ${vlan_setup_f}
			port1="1"
			vlan0_port1="0" 
		fi

		if [ "${port2}" == "Excluded" ]; then
			port2="0"
		else
			if [ "${enable}" == "on" ]; then
				echo "switch pvid 2  ${vlan_id}"  >> ${vlan_setup_f}
				if [ "${port2}" == "Tagged" ]; then
					tag_port2_pvid="${vlan_id}" 
					tag_port2="0"
				fi
			fi
			echo "switch user-port 2"  >> ${vlan_setup_f}
			port2="1"
			vlan0_port2="0" 
		fi

		if [ "${port3}" == "Excluded" ]; then
			port3="0"
		else
			if [ "${enable}" == "on" ]; then
				echo "switch pvid 3  ${vlan_id}"  >> ${vlan_setup_f}
				if [ "${port3}" == "Tagged" ]; then
					tag_port3_pvid="${vlan_id}" 
					tag_port3="0"
				fi
			fi
			echo "switch user-port 3"  >> ${vlan_setup_f}
			port3="1"
			vlan0_port3="0" 
		fi

		#port 4 is wan
		#port 5 is not used in 10/100M eth, but set it to 1 
		#in lan
		#set vlan for internet

		if [ "$i" == "0" ]; then
			vlan0_ports="${vlan0_port0}${vlan0_port1}${vlan0_port2}${vlan0_port3}011"
			##first add default vlan0 (LAN) 
			echo "switch vlan set 0 1 ${vlan0_ports}"  >> ${vlan_setup_f}
			#set vlan 0 bitmap vlan table
			echo "switch tag 0 1111110"  >> ${vlan_setup_f}
			if [ "${enable}" == "on" ]; then 
				#if not untaged internet port, set its pvid,
				#becase now must be tagged with internet port.
				if [ "${intertnet_port_untag_vid}" == "0" ]; then
					echo "switch pvid 4  ${vlan_id}"  >> ${vlan_setup_f}
				fi

				vlan_ports="${port0}${port1}${port2}${port3}${internet_port}01"
				echo "switch vlan set ${idx} ${vlan_id} ${vlan_ports}"  >> ${vlan_setup_f}
				#set tag for ports if any
				tags="${tag_port0}${tag_port1}${tag_port2}${tag_port3}${tag_port4}${tag_port5}${tag_port6}"
				echo "switch tag ${idx} ${tags}"  >> ${vlan_setup_f}

				#John add nvram value: wan_ifname
				nvram_set 2860 wan_ifname "eth2.${vlan_id}"

				configVlanIF "eth2" "${vlan_id}"
			else
				##Add default vlan for WAN  
				echo "switch vlan set 1 2 0000101"  >> ${vlan_setup_f}
				echo "switch pvid 4  2"  >> ${vlan_setup_f}
				#set tag for ports if any
				tags="1111110"
				echo "switch tag ${idx} ${tags}"  >> ${vlan_setup_f}
				#John add nvram value: wan_ifname
				nvram_set 2860 wan_ifname "eth2.2"
				configVlanIF "eth2" "2"
			fi

		elif [ "${enable}" == "on" ]; then #set the other vlan 
			#set vlan port member
			vlan_ports="${port0}${port1}${port2}${port3}${internet_port}${port5}${port6}"
			echo "switch vlan set ${idx} ${vlan_id} ${vlan_ports}"  >> ${vlan_setup_f}
			#set tag for ports if any
			tags="${tag_port0}${tag_port1}${tag_port2}${tag_port3}${tag_port4}${tag_port5}${tag_port6}"
			echo "switch tag ${idx} ${tags}"  >> ${vlan_setup_f}
		fi
	
		if [ "${enable}" == "on" ]; then 
			idx=`expr $idx - 1`
		fi

		i=`expr $i - 1`
	done
	
	#set port0---port3 pvid if tagged
	#vid between 17 to 4094
	if [ "${tag_port0_pvid}" != "" ]; then
		i=17 
		while [ $i -lt 4094 ]; do
			if [ "$i" != "${tag_port0_pvid}" \
				-a "$i" != "${tag_port1_pvid}" \
				-a "$i" != "${tag_port2_pvid}" \
				-a "$i" != "${tag_port3_pvid}" \
				-a "$i" != "${tag_port4_pvid}" ]; then
				echo "switch pvid 0  $i"  >> ${vlan_setup_f}
				tag_port0_pvid_new="$i"
				break
			fi
			i=`expr $i + 1`
		done
	fi

	if [ "${tag_port1_pvid}" != "" ]; then
		i=17
		while [ $i -lt 4094 ]; do
			if [ "$i" != "${tag_port0_pvid}" \
				-a "$i" != "${tag_port1_pvid}" \
				-a "$i" != "${tag_port2_pvid}" \
				-a "$i" != "${tag_port3_pvid}" \
				-a "$i" != "${tag_port4_pvid}" \
				-a "$i" != "${tag_port0_pvid_new}" ]; then
				echo "switch pvid 1  $i"  >> ${vlan_setup_f}
				tag_port1_pvid_new="$i"
				break
			fi
			i=`expr $i + 1`
		done
	fi

	if [ "${tag_port2_pvid}" != "" ]; then
		i=17
		while [ $i -lt 4094 ]; do
			if [ "$i" != "${tag_port0_pvid}" \
				-a "$i" != "${tag_port1_pvid}" \
				-a "$i" != "${tag_port2_pvid}" \
				-a "$i" != "${tag_port3_pvid}" \
				-a "$i" != "${tag_port4_pvid}" \
				-a "$i" != "${tag_port0_pvid_new}" \
				-a "$i" != "${tag_port1_pvid_new}" ]; then
				echo "switch pvid 2  $i"  >> ${vlan_setup_f}
				tag_port2_pvid_new="$i"
				break
			fi
			i=`expr $i + 1`
		done
	fi

	if [ "${tag_port3_pvid}" != "" ]; then
		i=17
		while [ $i -lt 4094 ]; do
			if [ "$i" != "${tag_port0_pvid}" \
				-a "$i" != "${tag_port1_pvid}" \
				-a "$i" != "${tag_port2_pvid}" \
				-a "$i" != "${tag_port3_pvid}" \
				-a "$i" != "${tag_port4_pvid}" \
				-a "$i" != "${tag_port0_pvid_new}" \
				-a "$i" != "${tag_port1_pvid_new}" \
				-a "$i" != "${tag_port2_pvid_new}" ]; then
				echo "switch pvid 3  $i"  >> ${vlan_setup_f}
				tag_port3_pvid_new="$i"
				break
			fi
			i=`expr $i + 1`
		done
	fi
	echo "switch reg w 14 5f5555"  >> ${vlan_setup_f}
	#per port per vlan untag: use untag enable bitmap in VLAN table
	if [ "${all_vlan_disable}" == "off" ]; then
		echo "switch reg w 98 ff3f"  >> ${vlan_setup_f}
	else
		echo "switch reg w 98 7f3f"  >> ${vlan_setup_f}
	fi

	#clear mac table if vlan configuration changed
	echo "switch clear"  >> ${vlan_setup_f}

	#At last, execute the vlan settings 
	source  ${vlan_setup_f}
}

	restore7530Esw()
	{
		echo "restore MT7530 ESW to dump switch mode"
		#port matrix mode
		switch_7530 reg w 2004 ff0000 #port0
		switch_7530 reg w 2104 ff0000 #port1
		switch_7530 reg w 2204 ff0000 #port2
		switch_7530 reg w 2304 ff0000 #port3
		switch_7530 reg w 2404 ff0000 #port4
		switch_7530 reg w 2504 ff0000 #port5
		switch_7530 reg w 2604 ff0000 #port6

		#LAN/WAN ports as transparent mode
		switch_7530 reg w 2010 810000c0 #port0
		switch_7530 reg w 2110 810000c0 #port1
		switch_7530 reg w 2210 810000c0 #port2
		switch_7530 reg w 2310 810000c0 #port3	
		switch_7530 reg w 2410 810000c0 #port4
		switch_7530 reg w 2510 810000c0 #port5
		switch_7530 reg w 2610 810000c0 #port6
		
		#clear mac table if vlan configuration changed
		switch_7530 clear
		switch_7530 vlan clear
	}

	restore6855Esw()
	{
		echo "restore GSW to dump switch mode"
		#port matrix mode
		switch reg w 2004 ff0000 #port0
		switch reg w 2104 ff0000 #port1
		switch reg w 2204 ff0000 #port2
		switch reg w 2304 ff0000 #port3
		switch reg w 2404 ff0000 #port4
		switch reg w 2504 ff0000 #port5
		switch reg w 2604 ff0000 #port6
		switch reg w 2704 ff0000 #port7

		#LAN/WAN ports as transparent mode
		switch reg w 2010 810000c0 #port0
		switch reg w 2110 810000c0 #port1
		switch reg w 2210 810000c0 #port2
		switch reg w 2310 810000c0 #port3	
		switch reg w 2410 810000c0 #port4
		switch reg w 2510 810000c0 #port5
		switch reg w 2610 810000c0 #port6
		switch reg w 2710 810000c0 #port7
		
		#clear mac table if vlan configuration changed
		switch clear
		switch vlan clear
	}
	restoreEsw()
	{
		switch reg w 14 5555
		switch reg w 40 1001
		switch reg w 44 1001
		switch reg w 48 1001
		switch reg w 4c 1
		switch reg w 50 2001
		switch reg w 70 ffffffff
		switch reg w 98 7f7f
		switch reg w e4 7f
		
		#clear mac table if vlan configuration changed
		switch clear
	}

	vtss_cpu()
	{
		vreg=`spicmd vtss read 7 0 10 | sed -e 's/.*> //'`
		pre=`echo $vreg | sed -e 's/\(.*\)[0-9a-f]/\1/'`
		hex=`echo $vreg | sed -e 's/.*\([0-9a-f]\)/\1/'`

		# 0 -> disable clock (bit 1)
		# 1 -> enable clock (bit 1)
		# 2 -> soft reset (bit 0)
		if [ "$1" = "0" ]; then
			case $hex in
				"2")	rep="0"	;;
				"3")	rep="1"	;;
				"6")	rep="4"	;;
				"7")	rep="5"	;;
			"a")	rep="8"	;;
			"b")	rep="9"	;;
			"e")	rep="c"	;;
			"f")	rep="d"	;;
			*)	return;;
		esac
		new=$pre$rep
		spicmd vtss write 7 0 10 $new > /dev/null
	elif [ "$1" = "1" ]; then
		case $hex in
			"0")	rep="2"	;;
			"1")	rep="3"	;;
			"4")	rep="6"	;;
			"5")	rep="7"	;;
			"8")	rep="a"	;;
			"9")	rep="b"	;;
			"c")	rep="e"	;;
			"d")	rep="f"	;;
			*)	return;;
		esac
		new=$pre$rep
		spicmd vtss write 7 0 10 $new > /dev/null
	elif [ "$1" = "2" ]; then
		case $hex in
			"1")	rep="0";;
			"3")	rep="2";;
			"5")	rep="4";;
			"7")	rep="6";;
			"9")	rep="8";;
			"b")	rep="a";;
			"d")	rep="c";;
			"f")	rep="e";;
			*)	return;;
		esac
		new=$pre$rep
		spicmd vtss write 7 0 10 $new > /dev/null
		spicmd vtss write 7 0 10 $vreg > /dev/null
	fi
}

vtss_power_save()
{
	# turn on ActiPHY feature (PHY_AUX_CTRL_STAT bit 6) for power saving
	for i in 0 1 2 3 4; do
		x=`expr $i \* 2 + 1`
		spicmd vtss write 3 0 1 4${x}c0000 /dev/null > /dev/null
		vreg=`spicmd vtss read 3 0 2 | sed -e 's/.*> //'`
		h1=`echo $vreg | sed -e 's/.//'`
		h2=`echo $vreg | sed -e 's/..//'`
		h3=`echo $vreg | sed -e 's/...//'`
		h4=`echo $vreg | sed -e 's/....//'`
		if [ "$h1" = "" ]; then
			spicmd vtss write 3 0 1 ${x}c004$vreg > /dev/null
		elif [ "$h2" = "" ]; then
			hex=`echo $vreg | sed -e 's/\(.\)./\1/'`
			post=`echo $vreg | sed -e 's/.\(.\)/\1/'`
			case $hex in
				"0")	rep="4";;
				"1")	rep="5";;
				"2")	rep="6";;
				"3")	rep="7";;
				"8")	rep="c";;
				"9")	rep="d";;
				"a")	rep="e";;
				"b")	rep="f";;
				*)	return;;
			esac
			spicmd vtss write 3 0 1 ${x}c00$rep$post > /dev/null
		elif [ "$h3" = "" ]; then
			pre=`echo $vreg | sed -e 's/\(.\)../\1/'`
			hex=`echo $vreg | sed -e 's/.\(.\)./\1/'`
			post=`echo $vreg | sed -e 's/..\(.\)/\1/'`
			case $hex in
				"0")	rep="4";;
				"1")	rep="5";;
				"2")	rep="6";;
				"3")	rep="7";;
				"8")	rep="c";;
				"9")	rep="d";;
				"a")	rep="e";;
				"b")	rep="f";;
				*)	return;;
			esac
			spicmd vtss write 3 0 1 ${x}c0$pre$rep$post > /dev/null
		elif [ "$h4" = "" ]; then
			pre=`echo $vreg | sed -e 's/\(..\)../\1/'`
			hex=`echo $vreg | sed -e 's/..\(.\)./\1/'`
			post=`echo $vreg | sed -e 's/...\(.\)/\1/'`
			case $hex in
				"0")	rep="4";;
				"1")	rep="5";;
				"2")	rep="6";;
				"3")	rep="7";;
				"8")	rep="c";;
				"9")	rep="d";;
				"a")	rep="e";;
				"b")	rep="f";;
				*)	return;;
			esac
			spicmd vtss write 3 0 1 ${x}c0$pre$rep$post > /dev/null
		fi
	done
}

if [ "$1" = "0" ]; then
	#isc is used to distinguish between 175C and 175D
	isc=`mii_mgr -g -p 29 -r 31`
	if [ "$2" = "0" ]; then
		if [ "$isc" = "Get: phy[29].reg[31] = 175c" ]; then
			restore175C
		else
			restore175D
		fi
	elif [ "$2" = "LLLLW" ]; then
		if [ "$isc" = "Get: phy[29].reg[31] = 175c" ]; then
			config175C "LLLLW"
		else
			config175D "LLLLW"
		fi
	elif [ "$2" = "WLLLL" ]; then
		if [ "$isc" = "Get: phy[29].reg[31] = 175c" ]; then
			config175C "WLLLL"
		else
			config175D "WLLLL"
		fi
	else
		echo "unknown vlan type $2"
		echo ""
		usage $0
	fi
elif [ "$1" = "1" ]; then
	if [ "$2" = "0" ]; then
		spicmd vtss novlan
	elif [ "$2" = "LLLLW" ]; then
		spicmd vtss p4
	elif [ "$2" = "WLLLL" ]; then
		spicmd vtss p0
	else
		echo "unknown vlan type $2"
		echo ""
		usage $0
	fi
	sleep 1
	vtss_cpu 0
	vtss_power_save
	vtss_cpu 2
	vtss_cpu 1
elif [ "$1" = "2" ]; then
	if [ "$2" = "0" ]; then
		restoreEsw
	elif [ "$2" = "LLLLW" ]; then
		configEsw LLLLW
	elif [ "$2" = "WLLLL" ]; then
		configEsw WLLLL
	elif [ "$2" = "W1234" ]; then
		configEsw W1234
	elif [ "$2" = "12345" ]; then
		configEsw 12345
	elif [ "$2" = "VLAN" ]; then
		configVlan
	elif [ "$2" = "G01234" ]; then
		configEsw G01234
	elif [ "$2" = "GW" ]; then
		configEsw GW
	else
		echo "unknown vlan type $2"
		echo ""
		usage $0
	fi
elif [ "$1" = "3" ]; then
	if [ "$2" = "0" ]; then
		restore6855Esw
	elif [ "$2" = "LLLLW" ]; then
		config6855Esw LLLLW
	elif [ "$2" = "WLLLL" ]; then
		config6855Esw WLLLL
	elif [ "$2" = "12345" ]; then
		config6855Esw 12345
	elif [ "$2" = "GW" ]; then
		config6855Esw GW
	else
		echo "unknown vlan type $2"
		echo ""
		usage $0
	fi
elif [ "$1" = "4" ]; then
	if [ "$2" = "0" ]; then
		restore7530Esw
	elif [ "$2" = "LLLLW" ]; then
		config7530Esw LLLLW
	elif [ "$2" = "WLLLL" ]; then
		config7530Esw WLLLL
	elif [ "$2" = "12345" ]; then
		config7530Esw 12345
	elif [ "$2" = "GW" ]; then
		config7530Esw GW
	else
		echo "unknown vlan type $2"
		echo ""
		usage $0
	fi
else
	echo "unknown swith type $1"
	echo ""
	usage $0
fi
