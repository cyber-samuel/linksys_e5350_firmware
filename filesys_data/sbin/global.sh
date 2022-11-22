#!/bin/sh

. /sbin/config.sh

Platform2="2860"
Platform5="rtdev"

getSkuName()
{
	sku=`cbtinfo r sku`
	
	nvram_set $Platform2 CountryCode $sku
	nvram_set $Platform5 CountryCode $sku
}

# WAN interface name -> $wan_if
getWanIfName()
{
	wan_mode=`nvram_get 2860 wanConnectionMode`
	if [ "$opmode" = "0" ]; then
		wan_if="br0"
	elif [ "$opmode" = "1" ]; then
		if [ "$CONFIG_RAETH_ROUTER" = "y" -o "$CONFIG_MAC_TO_MAC_MODE" = "y" -o "$CONFIG_RT_3052_ESW" = "y" ]; then
		    if [ "$CONFIG_RAETH_SPECIAL_TAG" == "y" ]; then
			if [ "$CONFIG_WAN_AT_P0" == "y" ]; then
				wan_if="eth2.1"
			else
				wan_if="eth2.5"
			fi
		    elif [ "$CONFIG_RAETH_GMAC2" = "y" ]; then
			wan_if="eth3"
		    else
			wan_if="eth2.2"
		    fi
		elif [ "$CONFIG_GE1_RGMII_AN" = "y" -a "$CONFIG_GE2_RGMII_AN" = "y" ]; then
			wan_if="eth3"
		else
			wan_if="eth2"
		fi
	elif [ "$opmode" = "2" ]; then
		wan_if="ra0"
	elif [ "$opmode" = "3" ]; then
		wan_if="apcli0"
	fi

	if [ "$wan_mode" = "PPPOE" -o  "$wan_mode" = "L2TP" -o "$wan_mode" = "PPTP"  ]; then
		wan_ppp_if="ppp0"
	else
		wan_ppp_if=$wan_if
	fi
	#John add nvram value: wan_ifname

	vlan_num=`nvram_get  2860 vlan_info`
	if [ -n "${vlan_num}" ]; then
		vlan0_info="`nvram_get 2860  vlan0_info`"
		vlanid="`echo ${vlan0_info} |cut -d, -f1`"
		enable="`echo ${vlan0_info} |cut -d, -f8`"
		if [ "${enable}" = "on" ]; then
			nvram_set 2860 wan_ifname "eth2.${vlanid}"
		fi
	else
		nvram_set 2860 wan_ifname $wan_if
	fi
}

# LAN interface name -> $lan_if
getLanIfName()
{
	bssidnum=`nvram_get 2860 BssidNum`

	if [ "$opmode" = "0" ]; then
		lan_if="br0"
	elif [ "$opmode" = "1" ]; then
		if [ "$CONFIG_RAETH_ROUTER" = "y" -o "$CONFIG_MAC_TO_MAC_MODE" = "y" -o "$CONFIG_RT_3052_ESW" = "y" ]; then
			lan_if="br0"
		elif [ "$CONFIG_ICPLUS_PHY" = "y" ]; then 
			if [ "$CONFIG_RT2860V2_AP_MBSS" = "y" -a "$bssidnum" != "1" ]; then
				lan_if="br0"
			else
				lan_if="ra0"
			fi
		elif [ "$CONFIG_GE1_RGMII_AN" = "y" -a "$CONFIG_GE2_RGMII_AN" = "y" ]; then
			lan_if="br0"
		else
			lan_if="ra0"
		fi
	elif [ "$opmode" = "2" ]; then
		lan_if="br0"
	elif [ "$opmode" = "3" ]; then
		lan_if="br0"
	fi
	#John add nvram value: lan_ifname
	nvram_set 2860 lan_ifname $lan_if

}

# ethernet converter enabled -> $ethconv "y"
getEthConv()
{
	ec=`nvram_get 2860 ethConvert`
	if [ "$opmode" = "0" -a "$CONFIG_RT2860V2_STA_DPB" = "y" -a "$ec" = "1" ]; then
		ethconv="y"
	elif [ "$opmode" = "0" -a "$CONFIG_RLT_STA_SUPPORT" != "" ]; then
		ethconv="y"
	else
		ethconv="n"
	fi
}

# station driver loaded -> $stamode "y"
getStaMode()
{
	if [ "$opmode" = "2" -o "$ethconv" = "y" ]; then
		stamode="y"
	else
		stamode="n"
	fi
}

insmodNfModules() {
        dirs=$(find /lib/modules -name 'netfilter' -type d)
        for dire in $dirs
        do
           #echo "in $dire:"
           for file in $dire/*
           do
                insmod -q  ${file%.*}
           done
        done
}

opmode=`nvram_get 2860 OperationMode`
wanmode=`nvram_get 2860 wanConnectionMode`
ethconv="n"
stamode="n"
wan_if="br0"
wan_ppp_if="br0"
lan_if="br0"
#getSkuName
getWanIfName
getLanIfName
getEthConv
getStaMode

# debug
#echo "opmode=$opmode"
#echo "wanmode=$wanmode"
#echo "ethconv=$ethconv"
#echo "stamode=$stamode"
#echo "wan_if=$wan_if"
#echo "lan_if=$lan_if"

