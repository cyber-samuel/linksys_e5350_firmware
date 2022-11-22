#!/bin/sh
#
# $Id: //WIFI_SOC/MP/SDK_5_0_0_0/RT288x_SDK/source/user/rt2880_app/scripts/internet.sh#38 $
#
# usage: internet.sh
#

. /sbin/config.sh
. /sbin/global.sh
. /sbin/function.sh

Platform2="2860"
Platform5="rtdev"

# revert eeprom
revert_eeprom

lan_ip=`nvram_get 2860 lan_ipaddr`
stp_en=`nvram_get 2860 stpEnabled`
nat_en=`nvram_get 2860 natEnabled`
radio_off1=`nvram_get 2860 RadioOff`
radio_off2=`nvram_get rtdev RadioOff`
radio_off3=`nvram_get wifi3 RadioOff`
wifi_off=`nvram_get 2860 WiFiOff`

# opmode adjustment:
#   if AP client was not compiled and operation mode was set "3" -> set $opmode "1"
#   if Station was not compiled and operation mode was set "2" -> set $opmode "1"
if [ "$opmode" = "3" -a "$CONFIG_RT2860V2_AP_APCLI$CONFIG_RT3090_AP_APCLI$CONFIG_RT5392_AP_APCLI$CONFIG_RT5592_AP_APCLI$CONFIG_RT3593_AP_APCLI$CONFIG_MT7610_AP_APCLI$CONFIG_RT3572_AP_APCLI$CONFIG_RT5572_AP_APCLI$CONFIG_RT3680_iNIC_AP_APCLI$CONFIG_RTPCI_AP_APCLI$CONFIG_APCLI_SUPPORT" == "" ]; then
	nvram_set 2860 OperationMode 1
	opmode="1"
fi
if [ "$opmode" = "2" -a "$CONFIG_RT2860V2_STA$CONFIG_RLT_STA_SUPPORT$CONFIG_MT_STA_SUPPORT" == "" ]; then
	nvram_set 2860 OperationMode 1
	opmode="1"
fi

genDevNode
mdev -s
genSysFiles

echo 2 > proc/sys/vm/overcommit_memory
echo 50 > proc/sys/vm/overcommit_ratio
echo 0 > /proc/sys/net/ipv4/ip_forward

# disable ipv6 DAD on all interfaces by default
if [ "$CONFIG_IPV6" == "y" -o "$CONFIG_IPV6" == "m" ]; then
	echo "0" > /proc/sys/net/ipv6/conf/default/accept_dad
fi

if [ "$CONFIG_DWC_OTG" == "m" ]; then
usbmod_exist=`lsmod | grep dwc_otg | wc -l`
if [ $usbmod_exist == 0 ]; then
insmod -q lm
insmod -q dwc_otg
fi
fi

if [ "$CONFIG_USB_EHCI_HCD" == "m" ]; then
usbmod_exist=`lsmod | grep ehci-hcd | wc -l`
if [ $usbmod_exist == 0 ]; then
insmod -q ehci-hcd
fi
fi

if [ "$CONFIG_USB_OHCI_HCD" == "m" ]; then
usbmod_exist=`lsmod | grep ohci-hcd | wc -l`
if [ $usbmod_exist == 0 ]; then
insmod -q ohci-hcd
fi
fi

if [ "$CONFIG_USB_XHCI_HCD" == "m" ]; then
usbmod_exist=`lsmod | grep xhci-hcd | wc -l`
if [ $usbmod_exist == 0 ]; then
insmod -q xhci-hcd
fi
fi


if [ "$CONFIG_MTK_MMC" == "m" ]; then
msdcmod_exist=`lsmod | grep mtk_sd | wc -l`
if [ $msdcmod_exist == 0 ]; then
insmod -q mtk_sd
fi
fi

if [ "$CONFIG_UFSD_FS" == "m" -o "$CONFIG_UFSD_FS" == "y" ]; then
jnlmod_exist=`lsmod | grep jnl | wc -l`
ufsdmod_exist=`lsmod | grep ufsd | wc -l`
if [ $jnlmod_exist == 0 ]; then
	insmod -q jnl
fi
if [ $ufsdmod_exist == 0 ]; then
	insmod -q ufsd
fi
fi

if [ "$CONFIG_GE2_RGMII_AN" = "y" -o "$CONFIG_GE2_INTERNAL_GPHY" = "y" ]; then
	ifconfig eth3 down
fi
killall -9 watchdog 1>/dev/null 2>&1
if [ "$CONFIG_RALINK_WATCHDOG" = "m" -o "$CONFIG_RALINK_TIMER_WDG" = "m" ]; then
rmmod ralink_wdt
fi
if [ "$CONFIG_RA_CLASSIFIER" = "y" -o "$CONFIG_RA_CLASSIFIER" = "m" ]; then
rmmod cls
fi
if [ "$CONFIG_RA_HW_NAT" = "m" ]; then
rmmod hw_nat
fi

if [ "$CONFIG_NF_SHORTCUT_HOOK" = "y" ]; then
rmmod nf_sc
fi

# insmod all
if [ "$CONFIG_BRIDG" = "m" ]; then
insmod -q bridge
fi
if [ "$CONFIG_MII" = "m" ]; then
insmod -q mii
fi
if [ "$CONFIG_RAETH" = "m" ]; then
rmmod raeth
insmod -q raeth
fi

# avoid eth2 doing ipv6 DAD
disableIPv6dad eth2

# In 2.6.36 kernel(MT7620& MT7621), avoid ipv6 traffic unless everything ready
if [ "$CONFIG_RALINK_MT7620" = "y" -o "$CONFIG_RALINK_MT7621" = "y" -o "$CONFIG_ARCH_MT7623" = "y" ]; then
if [ "$CONFIG_IPV6" == "y" -o "$CONFIG_IPV6" == "m" ]; then
echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6
fi
fi

stop_wireless

ifconfig lo 127.0.0.1
ifconfig br0 down
brctl delbr br0
if [ "$CONFIG_DBDC_MODE" = "y" ]; then
#	if[ "$CONFIG_WIFI_PKT_FWD" != "y" ]; then
		ifconfig br1 down
		brctl delbr br1
#	fi
fi

# stop all
iptables --flush
iptables --flush -t nat
iptables --flush -t mangle


mdev -s
setMDEV

if [ "$CONFIG_BT_MTK_HCI_USB" == "m" -o "$CONFIG_BT_MTK_HCI_USB" == "y" ]; then
btmtkmod_exist=`lsmod | grep btmtk_usb | wc -l`
if [ $btmtkmod_exist == 0 ]; then
	echo 'insmod btmtk_usb'
	insmod -q btmtk_usb
fi
fi

#insmodNfModules
insmod ipt_webstr
sipEnable=`nvram_get 2860 nf_alg_sip`
if [ "$sipEnable" == "1" ]; then
        insmod nf_conntrack_sip
        insmod nf_nat_sip
fi
#insmod dnshook

start_wireless

#
# init ip address to all interfaces for different OperationMode:
#   0 = Bridge Mode
#   1 = Gateway Mode
#   2 = Ethernet Converter Mode
#   3 = AP Client
#
if [ "$opmode" = "0" ]; then
	configVIF
	nvram_set 2860 QoSEnable 0
	if [ "$CONFIG_RAETH_ROUTER" = "y" -a "$CONFIG_LAN_WAN_SUPPORT" = "y" ]; then
		echo "##### restore IC+ to dump switch #####"
		config-vlan.sh 0 0
	elif [ "$CONFIG_MAC_TO_MAC_MODE" = "y" ]; then
		echo "##### restore Vtss to dump switch #####"
		config-vlan.sh 1 0
		if [ "$CONFIG_IPV6" == "y" -o "$CONFIG_IPV6" == "m" ]; then
			sleep 3
		fi
	elif [ "$CONFIG_RT_3052_ESW" = "y" ]; then
		echo "##### restore Ralink ESW to dump switch #####"
		if [ "$CONFIG_RALINK_RT6855" = "y" -o "$CONFIG_RALINK_RT6855A" = "y" -o "$CONFIG_RALINK_MT7620" = "y" -o "$CONFIG_RALINK_MT7621" = "y" -o "$CONFIG_ARCH_MT7623" = "y" ]; then
			config-vlan.sh 3 0
		else
			config-vlan.sh 2 0
			switch reg w e4 3f
		fi
		if [ "$CONFIG_WAN_AT_P0" = "y" ]; then
			if [ "$CONFIG_RALINK_MT7621" = "y" -o "$CONFIG_ARCH_MT7623" = "y" -o "$CONFIG_GE_RGMII_MT7530_P0_AN" = "y" -o "$CONFIG_GE_RGMII_MT7530_P4_AN" = "y" -o "$CONFIG_P5_RGMII_TO_MT7530_MODE" = "y" ]; then
				echo '##### config Switch vlan partition (WLLLL) #####'
				switch vlan  set 1 1 01111011
				switch vlan  set 2 2 10000100
				switch pvid 0 2
				switch pvid 5 2
				switch reg w 2004 ff0003
				switch reg w 2104 ff0003
				switch reg w 2204 ff0003
				switch reg w 2304 ff0003
				switch reg w 2404 ff0003
				switch reg w 2504 ff0003
				switch reg w 2604 ff0003
			fi
		else
			if [ "$CONFIG_RALINK_MT7621" = "y" -o "$CONFIG_ARCH_MT7623" = "y" -o "$CONFIG_GE_RGMII_MT7530_P0_AN" = "y" -o "$CONFIG_GE_RGMII_MT7530_P4_AN" = "y" -o "$CONFIG_P5_RGMII_TO_MT7530_MODE" = "y" ]; then
				echo '##### config Switch vlan partition (LLLLW) #####'
				switch vlan  set 1 1 11110011
				switch vlan  set 2 2 00001100
				switch pvid 4 2
				switch pvid 5 2
				switch reg w 2004 ff0003
				switch reg w 2104 ff0003
				switch reg w 2204 ff0003
				switch reg w 2304 ff0003
				switch reg w 2404 ff0003
				switch reg w 2504 ff0003
				switch reg w 2604 ff0003
			fi
		fi
	fi
	if [ "$CONFIG_IPV6" == "y" -o "$CONFIG_IPV6" == "m" ]; then
		sleep 2
	fi
	wireless_bridge=`nvram_get 2860 wbridge_mode`
	addBr0
#	if [ "$wireless_bridge" = "0" -a "$radio_off1" = "0" ]; then
	if [ "$radio_off1" = "0" ]; then
		addRax2Br0
	fi
	addWds2Br0
	addMesh2Br0
	brctl addif br0 eth2
	if [ "$CONFIG_GE2_RGMII_AN" = "y" -o "$CONFIG_GE2_INTERNAL_GPHY" = "y" ]; then
		brctl addif br0 eth3
	fi

# RTDEV_MII support: start mii iNIC after network interface is working
	if [ "$CONFIG_RTDEV_MII" != "" ]; then
		rmmod iNIC_mii
		iNIC_Mii_en=`nvram_get rtdev InicMiiEnable`
		if [ "$iNIC_Mii_en" == "1" ]; then
			ifconfig rai0 down 1>/dev/null 2>&1
			insmod -q iNIC_mii miimaster=eth2
			ifconfig rai0 up 1>/dev/null 2>&1
		fi
	fi
#	if [ "$wireless_bridge" = "0" -a "$radio_off2" = "0" ]; then
	if [ "$radio_off2" = "0" ]; then
		addRaix2Br0
	fi

	addInicWds2Br0
	addRaL02Br0
	addRaex2Br0
	if [ "$CONFIG_RT2860V2_AP_APCLI$CONFIG_RT3090_AP_APCLI$CONFIG_RT5392_AP_APCLI$CONFIG_RT5592_AP_APCLI$CONFIG_RT3593_AP_APCLI$CONFIG_MT7610_AP_APCLI$CONFIG_RT3572_AP_APCLI$CONFIG_RT5572_AP_APCLI$CONFIG_RT3680_iNIC_AP_APCLI$CONFIG_RTPCI_AP_APCLI$CONFIG_APCLI_SUPPORT" != "" ]; then
		wbridge_band=`nvram_get 2860 wbridge_band`
		APCLI_RT2860=`nvram_get 2860 apClient`
		if [ "$APCLI_RT2860" = "1" -a "$wireless_bridge" = "1" -a "$wbridge_band" = "0" ]; then
			ifconfig apcli0 up
			brctl addif br0 apcli0
			wbridge_band=`nvram_get 2860 wbridge_band`
			iwpriv apcli0 set ApCliAutoConnect=1
			iwpriv apcli0 set ApCliEnable=1
			dbdc_en=`nvram_get DBDC_MODE`
			if [ "$CONFIG_DBDC_MODE" = "y" -a "$dbdc_en" = "1" ]; then
				ifconfig apcli1 up
				iwpriv apcli1 set ApCliEnable=1
				if [ "$CONFIG_WIFI_PKT_FWD" != "y" ]; then
					addDBDCApCliBr1
				else
					brctl addif br0 apcli1
				fi
			fi
		fi
		APCLI_RTDEV=`nvram_get rtdev apClient`
		if [ "$APCLI_RTDEV" = "1" -a "$wireless_bridge" = "1" -a "$wbridge_band" = "1" ]; then
			ifconfig apclii0 up
			brctl addif br0 apclii0
			iwpriv apclii0 set ApCliAutoConnect=1
			iwpriv apclii0 set ApCliEnable=1
			if [ "$CONFIG_WIFI_PKT_FWD" = "y" ]; then
				brctl addif br0 apclii0
			fi
		fi
	fi
	wan.sh
	lan.sh
	if [ "$wireless_bridge" = "1" ]; then
		ifRaxDown	
		ifRaixDown	
	fi
elif [ "$opmode" = "1" ]; then
	#John add 
	vlan_num=`nvram_get  2860 vlan_info`
	if [ -z "${vlan_num}" -o "${vlan_num}" == "0" ]; then
		configVIF
	fi

	if [ "$CONFIG_RAETH_ROUTER" = "y" -a "$CONFIG_LAN_WAN_SUPPORT" = "y" ]; then
		if [ "$CONFIG_WAN_AT_P0" = "y" ]; then
			echo '##### config IC+ vlan partition (WLLLL) #####'
			config-vlan.sh 0 WLLLL
		else
			echo '##### config IC+ vlan partition (LLLLW) #####'
			config-vlan.sh 0 LLLLW
		fi
	fi
	if [ "$CONFIG_MAC_TO_MAC_MODE" = "y" ]; then
		if [ "$CONFIG_WAN_AT_P0" = "y" ]; then
			echo '##### config Vtss vlan partition (WLLLL) #####'
			config-vlan.sh 1 WLLLL
		else
			echo '##### config Vtss vlan partition (LLLLW) #####'
			config-vlan.sh 1 LLLLW
		fi
		if [ "$CONFIG_IPV6" == "y" -o "$CONFIG_IPV6" == "m" ]; then
			sleep 3
		fi
	fi
	if [ "$CONFIG_RT_3052_ESW" = "y" -a "$CONFIG_LAN_WAN_SUPPORT" = "y" ]; then
		if [ "$CONFIG_P5_RGMII_TO_MAC_MODE" = "y" -o  "$CONFIG_GE2_RGMII_AN" = "y" -o "$CONFIG_GE2_INTERNAL_GPHY" = "y" ]; then
			echo "##### restore Ralink ESW to dump switch #####"
			if [ "$CONFIG_RALINK_RT6855" = "y" -o "$CONFIG_RALINK_RT6855A" -o "$CONFIG_RALINK_MT7620" = "y" -o "$CONFIG_RALINK_MT7621" = "y" -o "$CONFIG_ARCH_MT7623" = "y" ]; then
				config-vlan.sh 3 0 
			else
				config-vlan.sh 2 0
			fi
			if [ "$CONFIG_WAN_AT_P0" = "y" ]; then
				if [ "$CONFIG_RALINK_MT7621" = "y" -o "$CONFIG_ARCH_MT7623" = "y" -o "$CONFIG_GE_RGMII_MT7530_P0_AN" = "y" -o "$CONFIG_GE_RGMII_MT7530_P4_AN" = "y" -o "$CONFIG_P5_RGMII_TO_MT7530_MODE" = "y" ]; then
					echo '##### config Switch vlan partition (WLLLL) #####'
					switch vlan  set 1 1 01111011
					switch vlan  set 2 2 10000100
					switch pvid 0 2
					switch pvid 5 2
					switch reg w 2004 ff0003
					switch reg w 2104 ff0003
					switch reg w 2204 ff0003
					switch reg w 2304 ff0003
					switch reg w 2404 ff0003
					switch reg w 2504 ff0003
					switch reg w 2604 ff0003
				elif [ "$CONFIG_RALINK_RT6855" = "y" -o "$CONFIG_RALINK_RT6855A" = "y" -o "$CONFIG_RALINK_MT7620" = "y" ]; then
					echo '##### config External Switch vlan partition (WLLLL) #####'
				else
					echo '##### config External Switch vlan partition (WLLLL) #####'
					echo "initialize external switch (WLLLL)"
					config-vlan.sh 1 WLLLL
				fi
			else
				if [ "$CONFIG_RALINK_MT7621" = "y" -o "$CONFIG_ARCH_MT7623" = "y" -o "$CONFIG_GE_RGMII_MT7530_P0_AN" = "y" -o "$CONFIG_GE_RGMII_MT7530_P4_AN" = "y" -o "$CONFIG_P5_RGMII_TO_MT7530_MODE" = "y" ]; then
					echo '##### config Switch vlan partition (LLLLW) #####'
					switch vlan  set 1 1 11110011
					switch vlan  set 2 2 00001100
					switch pvid 4 2
					switch pvid 5 2
					switch reg w 2004 ff0003
					switch reg w 2104 ff0003
					switch reg w 2204 ff0003
					switch reg w 2304 ff0003
					switch reg w 2404 ff0003
					switch reg w 2504 ff0003
					switch reg w 2604 ff0003
				elif [ "$CONFIG_RALINK_RT6855" = "y" -o "$CONFIG_RALINK_RT6855A" = "y" -o "$CONFIG_RALINK_MT7620" = "y" ]; then
					echo '##### config External Switch vlan partition (LLLLW) #####'
				else
					echo '##### config External Switch vlan partition (LLLLW) #####'
					echo "initialize external switch (LLLLW)"
					config-vlan.sh 1 LLLLW
				fi
			fi
		else
			if [ "$CONFIG_WAN_AT_P0" = "y" ]; then
				echo '##### config Ralink ESW vlan partition (WLLLL) #####'
				if [ "$CONFIG_RALINK_RT6855" = "y" -o "$CONFIG_RALINK_RT6855A" = "y" -o "$CONFIG_RALINK_MT7620" = "y" -o "$CONFIG_RALINK_MT7621" = "y" -o "$CONFIG_ARCH_MT7623" = "y" ]; then
					config-vlan.sh 3 WLLLL
				else
					config-vlan.sh 2 WLLLL
				fi
			else
				echo '##### config Ralink ESW vlan partition (LLLLW) #####'
				if [ "$CONFIG_RALINK_RT6855" = "y" -o "$CONFIG_RALINK_RT6855A" = "y" -o "$CONFIG_RALINK_MT7620" = "y" -o "$CONFIG_RALINK_MT7621" = "y" -o "$CONFIG_ARCH_MT7623" = "y" ]; then
					config-vlan.sh 3 LLLLW
				else
					config-vlan.sh 2 LLLLW
					#John.zhu@2018.8 config vlan
					config-vlan.sh 2 VLAN
				fi
			fi
		fi
	fi

	if [ "$CONFIG_IPV6" == "y" -o "$CONFIG_IPV6" == "m" ]; then
		sleep 1
	fi

	addBr0
	if [ "$radio_off1" = "0" ]; then
		addRax2Br0
	fi
	addWds2Br0
	addMesh2Br0
	if [ "$CONFIG_RAETH_ROUTER" = "y" -o "$CONFIG_MAC_TO_MAC_MODE" = "y" -o "$CONFIG_RT_3052_ESW" = "y" ]; then
		if [ "$CONFIG_RAETH_SPECIAL_TAG" == "y" ]; then
			if [ "$CONFIG_WAN_AT_P4" = "y" ]; then
				brctl addif br0 eth2.1
			fi
			brctl addif br0 eth2.2
			brctl addif br0 eth2.3
			brctl addif br0 eth2.4
			if [ "$CONFIG_WAN_AT_P0" = "y" ]; then
				brctl addif br0 eth2.5
			fi
		elif [ "$CONFIG_GE2_RGMII_AN" = "y" -o "$CONFIG_GE2_INTERNAL_GPHY" = "y" ]; then
			brctl addif br0 eth2
		else
			brctl addif br0 eth2.1
		fi
	fi

	# IC+ 100 PHY (one port only)
	if [ "$CONFIG_ICPLUS_PHY" = "y" ]; then
		echo '##### connected to one port 100 PHY #####'
		#
		# setup ip alias for user to access web page.
		#
		ifconfig eth2:1 172.32.1.254 netmask 255.255.255.0 up
	fi
	if [ "$CONFIG_GE1_RGMII_AN" = "y" -a "$CONFIG_GE2_RGMII_AN" = "y" ]; then
		echo "##### connected to two Giga PHY port #####"
		brctl addif br0 eth2
	fi
	if [ "$radio_off2" = "0" ]; then
		addRaix2Br0
	fi
	addInicWds2Br0
	addRaL02Br0
	addRaex2Br0
	#John, record br0 mac address
	lan_br0_mac=`ifconfig br0 | sed -n '/HWaddr/p' | sed -e 's/.*HWaddr \(.*\)/\1/'`
	nvram_set 2860 lan_br0_mac "${lan_br0_mac}"
	wan.sh
	lan.sh
	nat.sh

	# set the global ipv6 address for LAN/WAN, enable ipv6 forwarding,
	# enable ecmh(multicast) daemon
elif [ "$opmode" = "2" ]; then
	configVIF
	# if (-1 == initStaProfile())
	#   error(E_L, E_LOG, T("internet.c: profiles in nvram is broken"));
	# else
	#   initStaConnection();

	if [ "$CONFIG_RAETH_ROUTER" = "y" -a "$CONFIG_LAN_WAN_SUPPORT" = "y" ]; then
		echo "##### restore IC+ to dump switch #####"
		config-vlan.sh 0 0
	fi
	if [ "$CONFIG_MAC_TO_MAC_MODE" = "y" ]; then
		echo "##### restore External Switch to dump switch #####"
		config-vlan.sh 1 0
	fi
	if [ "$CONFIG_RT_3052_ESW" = "y" ]; then
		if [ "$CONFIG_P5_RGMII_TO_MAC_MODE" = "y" -o "$CONFIG_GE1_RGMII_FORCE_1000" = "y" -o "$CONFIG_GE1_RGMII_FORCE_1200" = "y" ]; then
			echo "##### restore Ralink ESW to dump switch #####"
			if [ "$CONFIG_RALINK_RT6855" = "y" -o "$CONFIG_RALINK_RT6855A" = "y" -o "$CONFIG_RALINK_MT7620" = "y" -o "$CONFIG_RALINK_MT7621" = "y" -o "$CONFIG_ARCH_MT7623" = "y" ]; then
				config-vlan.sh 3 0
			else
				config-vlan.sh 2 0
			fi
			echo "##### restore External Switch to dump switch #####"
			if [ "$CONFIG_RALINK_RT6855" = "y" -o "$CONFIG_RALINK_RT6855A" = "y" -o "$CONFIG_RALINK_MT7620" = "y" -o "$CONFIG_RALINK_MT7621" = "y" -o "$CONFIG_ARCH_MT7623" = "y" ]; then
				echo "initialize external switch"
			else
				config-vlan.sh 1 0
			fi
		else
			echo "##### restore Ralink ESW to dump switch #####"
			if [ "$CONFIG_RALINK_RT6855" = "y" -o "$CONFIG_RALINK_RT6855A" = "y" -o "$CONFIG_RALINK_MT7620" = "y" -o "$CONFIG_RALINK_MT7621" = "y" -o "$CONFIG_ARCH_MT7623" = "y" ]; then
				config-vlan.sh 3 0
			else
				config-vlan.sh 2 0
			fi
		fi
		# MT7530 P4, P5 MAC mode
		if [ "$CONFIG_WAN_AT_P0" = "y" ]; then
			if [ "$CONFIG_RALINK_MT7621" = "y" -o "$CONFIG_ARCH_MT7623" = "y" -o "$CONFIG_GE_RGMII_MT7530_P0_AN" = "y" -o "$CONFIG_GE_RGMII_MT7530_P4_AN" = "y" -o "$CONFIG_P5_RGMII_TO_MT7530_MODE" = "y" ]; then
				echo '##### config Switch vlan partition (WLLLL) #####'
				switch vlan  set 1 1 01111011
				switch vlan  set 2 2 10000100
				switch pvid 0 2
				switch pvid 5 2
				switch reg w 2004 ff0003
				switch reg w 2104 ff0003
				switch reg w 2204 ff0003
				switch reg w 2304 ff0003
				switch reg w 2404 ff0003
				switch reg w 2504 ff0003
				switch reg w 2604 ff0003
			fi
		else
			if [ "$CONFIG_RALINK_MT7621" = "y" -o "$CONFIG_ARCH_MT7623" = "y" -o "$CONFIG_GE_RGMII_MT7530_P0_AN" = "y" -o "$CONFIG_GE_RGMII_MT7530_P4_AN" = "y" -o "$CONFIG_P5_RGMII_TO_MT7530_MODE" = "y" ]; then
				echo '##### config Switch vlan partition (LLLLW) #####'
				switch vlan  set 1 1 11110011
				switch vlan  set 2 2 00001100
				switch pvid 4 2
				switch pvid 5 2
				switch reg w 2004 ff0003
				switch reg w 2104 ff0003
				switch reg w 2204 ff0003
				switch reg w 2304 ff0003
				switch reg w 2404 ff0003
				switch reg w 2504 ff0003
				switch reg w 2604 ff0003
			fi
		fi
	fi
	if [ "$CONFIG_IPV6" == "y" -o "$CONFIG_IPV6" == "m" ]; then
		sleep 1
	fi
	addBr0
	brctl addif br0 eth2
	if [ "$CONFIG_GE2_RGMII_AN" = "y" -o "$CONFIG_GE2_INTERNAL_GPHY" = "y" ]; then
		brctl addif br0 eth3
	fi
	enableIPv6dad $lan_if 1
	enableIPv6dad $wan_if 1

	if [ "$radio_off2" = "0" ]; then
		addRaix2Br0
	fi
	addInicWds2Br0
	addRaL02Br0
	addRaex2Br0
	wan.sh
	lan.sh
	nat.sh
elif [ "$opmode" = "3" ]; then
	configVIF
	if [ "$CONFIG_RAETH_ROUTER" = "y" -o "$CONFIG_MAC_TO_MAC_MODE" = "y" -o "$CONFIG_RT_3052_ESW" = "y" ]; then
		if [ "$CONFIG_RAETH_ROUTER" = "y" ]; then
			echo "##### restore IC+ to dump switch #####"
			config-vlan.sh 0 0
		fi
		if [ "$CONFIG_MAC_TO_MAC_MODE" = "y" ]; then
			echo "##### restore Vtss to dump switch #####"
			config-vlan.sh 1 0
		fi
		if [ "$CONFIG_RT_3052_ESW" = "y" ]; then
			if [ "$CONFIG_P5_RGMII_TO_MAC_MODE" = "y" -o "$CONFIG_GE1_RGMII_FORCE_1000" = "y" -o "$CONFIG_GE1_RGMII_FORCE_1200" = "y" ]; then
				echo "##### restore Ralink ESW to dump switch #####"
				if [ "$CONFIG_RALINK_RT6855" = "y" -o "$CONFIG_RALINK_RT6855A" = "y" -o "$CONFIG_RALINK_MT7620" = "y" -o "$CONFIG_RALINK_MT7621" = "y" -o "$CONFIG_ARCH_MT7623" = "y" ]; then
					config-vlan.sh 3 0
				else
					config-vlan.sh 2 0
				fi
				echo "##### restore External Switch to dump switch #####"
				if [ "$CONFIG_RALINK_RT6855" = "y" -o "$CONFIG_RALINK_RT6855A" = "y" -o "$CONFIG_RALINK_MT7620" = "y" -o "$CONFIG_RALINK_MT7621" = "y" -o "$CONFIG_ARCH_MT7623" = "y" ]; then
					echo "initialize external switch"
				else
					config-vlan.sh 1 0
				fi
			else
				echo "##### restore Ralink ESW to dump switch #####"
				if [ "$CONFIG_RALINK_RT6855" = "y" -o "$CONFIG_RALINK_RT6855A" = "y" -o "$CONFIG_RALINK_MT7620" = "y" -o "$CONFIG_RALINK_MT7621" = "y" -o "$CONFIG_ARCH_MT7623" = "y" ]; then
					config-vlan.sh 3 0
				else
					config-vlan.sh 2 0
				fi
			fi
			# MT7530 P4, P5 MAC mode
			if [ "$CONFIG_WAN_AT_P0" = "y" ]; then
				if [ "$CONFIG_RALINK_MT7621" = "y" -o "$CONFIG_ARCH_MT7623" = "y" -o "$CONFIG_GE_RGMII_MT7530_P0_AN" = "y" -o "$CONFIG_GE_RGMII_MT7530_P4_AN" = "y" -o "$CONFIG_P5_RGMII_TO_MT7530_MODE" = "y" ]; then
					echo '##### config Switch vlan partition (WLLLL) #####'
					switch vlan  set 1 1 01111011
					switch vlan  set 2 2 10000100
					switch pvid 0 2
					switch pvid 5 2
					switch reg w 2004 ff0003
					switch reg w 2104 ff0003
					switch reg w 2204 ff0003
					switch reg w 2304 ff0003
					switch reg w 2404 ff0003
					switch reg w 2504 ff0003
					switch reg w 2604 ff0003
				fi
			else
				if [ "$CONFIG_RALINK_MT7621" = "y" -o "$CONFIG_ARCH_MT7623" = "y" -o "$CONFIG_GE_RGMII_MT7530_P0_AN" = "y" -o "$CONFIG_GE_RGMII_MT7530_P4_AN" = "y" -o "$CONFIG_P5_RGMII_TO_MT7530_MODE" = "y" ]; then
					echo '##### config Switch vlan partition (LLLLW) #####'
					switch vlan  set 1 1 11110011
					switch vlan  set 2 2 00001100
					switch pvid 4 2
					switch pvid 5 2
					switch reg w 2004 ff0003
					switch reg w 2104 ff0003
					switch reg w 2204 ff0003
					switch reg w 2304 ff0003
					switch reg w 2404 ff0003
					switch reg w 2504 ff0003
					switch reg w 2604 ff0003
				fi
			fi
		fi
	fi
	if [ "$CONFIG_IPV6" == "y" -o "$CONFIG_IPV6" == "m" ]; then
		sleep 1
	fi
	addBr0
	if [ "$radio_off1" = "0" ]; then
		addRax2Br0
	fi
	brctl addif br0 eth2
	if [ "$CONFIG_GE2_RGMII_AN" = "y" -o "$CONFIG_GE2_INTERNAL_GPHY" = "y" ]; then
		brctl addif br0 eth3
	fi
	if [ "$radio_off2" = "0" ]; then
		addRaix2Br0
	fi
	addInicWds2Br0
	addRaL02Br0
	addRaex2Br0
	wan.sh
	lan.sh
	nat.sh
else
	echo "unknown OperationMode: $opmode"
	exit 1
fi

# INIC support
#if [ "$CONFIG_RT2880_INIC" != "" ]; then
#	ifconfig rai0 down
#	rmmod rt_pci_dev
#	ralink_init make_wireless_config rtdev
#	insmod -q rt_pci_dev
#	ifconfig rai0 up
#	RaAP&
#	sleep 3
#fi

if [ "$opmode" != "0" ]; then
	echo 1 > /proc/sys/net/ipv4/ip_forward
fi

# in order to use broadcast IP address in L2 management daemon
if [ "$CONFIG_ICPLUS_PHY" = "y" ]; then
	route add -host 255.255.255.255 dev $wan_if
else
	route add -host 255.255.255.255 dev $lan_if
fi


m2uenabled1=`nvram_get 2860 M2UEnabled`
if [ "$m2uenabled1" = "1" ]; then
	iwpriv ra0 set IgmpSnEnable=1
	echo "iwpriv ra0 set IgmpSnEnable=1"
fi
m2uenabled2=`nvram_get rtdev M2UEnabled`
if [ "$m2uenabled2" = "1" ]; then
	iwpriv rai0 set IgmpSnEnable=1
	echo "iwpriv rai0 set IgmpSnEnable=1"
fi

if [ "$wifi_off" = "1" ]; then
	ifRaxWdsxDown
	reg s b0180000
	reg w 400 0x1080
	reg w 1204 8
	reg w 1004 3
fi

RVT=`nvram_get 2860 RVT`
if [ "$RVT" = "1" ]; then
	if [ "$CONFIG_RA_CLASSIFIER" = "y" -o "$CONFIG_RA_CLASSIFIER" = "m" ]; then
	insmod -q cls
	fi
fi

HWNAT=`nvram_get 2860 hwnatEnabled`
if [ "$HWNAT" = "1" ]; then
	insmod -q hw_nat
	if [ "$CONFIG_RA_HW_NAT_WIFI_NEW_ARCH" = "y" ]; then
	iwpriv ra0 set hw_nat_register=1
		if [ "$CONFIG_SECOND_IF_MT7615E" = "y" ]; then
		iwpriv rai0 set hw_nat_register=1
		fi
	fi
fi

#WDGE=`nvram_get 2860 WatchDogEnable`
#if [ "$WDGE" = "1" ]; then
	#if [ "$CONFIG_RALINK_WATCHDOG" = "m" -o "$CONFIG_RALINK_TIMER_WDG" = "m" ]; then
	#	insmod -q ralink_wdt
	#fi
	#wdg.sh
	#watchdog
#fi

# In 2.6.36 kernel(MT7620& MT7621), avoid ipv6 traffic unless everything ready
if [ "$CONFIG_RALINK_MT7620" = "y" -o "$CONFIG_RALINK_MT7621" = "y" -o "$CONFIG_ARCH_MT7623" = "y" ]; then
if [ "$CONFIG_IPV6" == "y" -o "$CONFIG_IPV6" == "m" ]; then
echo 0 > /proc/sys/net/ipv6/conf/all/disable_ipv6
fi
fi

if [ "$CONFIG_RALINK_MT7621" = "y" -o "$CONFIG_ARCH_MT7623" = "y" ]; then
	smp.sh wifi
fi

# radvd
#radvd.sh

#ipv6_logo.sh

if [ "$CONFIG_ARCH_MT7623" = "y" -a "$CONFIG_MTK_COMBO" = "y" ]; then
#stop
	killall -9 wmt_launcher

	rm /dev/wmtWifi c 153 0
	rm /dev/stpbt  c 192 0
	rm /dev/stpwmt c 190 0

#restart
	mknod /dev/stpwmt c 190 0
	mknod /dev/stpbt  c 192 0
	mknod /dev/wmtWifi c 153 0

	wmt_launcher -p /etc_ro/wmt/ &
fi

if [ "$CONFIG_RALINKAPP_HOTSPOT" == "y" ]; then
	hotspot.sh
fi
echo 4096 > /proc/sys/net/ipv4/tcp_max_tw_buckets

if [ "$CONFIG_USER_BLUEANGEL" == "y" ]; then
	if [ "$CONFIG_USER_BTCLI_ON" == "y" ]; then
		killall -9 btcli
	fi
#	if [ "$CONFIG_USER_BLUEANGEL_RPLAYER" == "y" ]; then
#		killall -9 rplayer
#	fi
	if [ "$CONFIG_USER_BLUEANGEL_MTKBT" == "y" -a "$CONFIG_USER_BTCLI_ON" == "y" ]; then
		killall -9 mtkbt
		echo 'mtkbt ..start'
		mtkbt >/dev/null 2>&1 &
	fi
#	if [ "$CONFIG_USER_BLUEANGEL_RPLAYER" == "y" ]; then
#		sleep 1
#		echo 'rplayer ..start'
#		rplayer &
#	fi	
	if [ "$CONFIG_USER_BTCLI_ON" == "y" ]; then
		sleep 1
		echo 'btcli ..start'
		btcli -c 0 -s 2 --lib_debug=5 --cli_debug=001B &
	fi
fi

if [ "$CONFIG_RALINK_MT7628" = "y" ]; then
killall -q long_loop
config-longloop.sh 1
fi



if [ "$CONFIG_USER_NFCSD" = "y" ]; then
killall nfchod
killall nfcsd
wps_ra0=`nvram_get 2860 WscModeOption`
nfc_ra0=`nvram_get 2860 NFC_ra0_enable`
if [ "$wps_ra0" = "7" ]; then
if [ "$nfc_ra0" = "1" ]; then
		nfchod &
		sleep 2
		iwpriv ra0 set NfcStatus=1
fi
fi
wps_rai0=`nvram_get rtdev WscModeOption`
nfc_rai0=`nvram_get rtdev NFC_rai0_enable`
if [ "$wps_rai0" = "7" ]; then
if [ "$nfc_rai0" = "1" ]; then
		nfchod -s rai0 &
		sleep 2;
		iwpriv rai0 set NfcStatus=1
fi
fi
fi

if [ "$CONFIG_USER_MOCAD2" = "y" -a "$CONFIG_RALINK_MT7620" = "y" ]; then
	mocad2Init stop
	mocad2Init start
fi

if [ "$CONFIG_USER_WSC" = "y" ]; then
	nfchod -s rai0&
	iwpriv rai0 set NfcStatus=1
else
	nfchod bt&
fi

#//+++Add by shiang for ATED support of QA usage
#ated -b br0 -i ra0 -u &
#//--Add by shiang for ATED suppport of QA usage
