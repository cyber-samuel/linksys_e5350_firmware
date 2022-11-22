#!/bin/sh
. /sbin/config.sh
. /sbin/global.sh

wireless_bridge=`nvram_get 2860 wbridge_mode`
RadioOff_24=`nvram_get 2860 RadioOff`
RadioOff_5=`nvram_get rtdev RadioOff`

revert_eeprom()
{
	tmp_0=`flash -r 40034 -c 1`
	tmp_1=`flash -r 40035 -c 1`
	tmp_2=`flash -r 40036 -c 1`
	tmp_3=`flash -r 40037 -c 1`
	tmp_4=`flash -r 40038 -c 1`
	tmp_5=`flash -r 40039 -c 1`
	if [ "$tmp_0" != "40034: 22" ] || [ "$tmp_1" != "40035: 34" ] || [ "$tmp_2" != "40036: 0" ] || [ "$tmp_3" != "40037: 20" ] || [ "$tmp_4" != "40038: FF" ] || [ "$tmp_5" != "40039: FF" ]; then
		flash -w 40034 -o 22
		flash -w 40035 -o 34
		flash -w 40036 -o 00
		flash -w 40037 -o 20
		flash -w 40038 -o FF
		flash -w 40039 -o FF
	fi
}

genDevNode()
{
#Linux2.6 uses udev instead of devfs, we have to create static dev node by myself.
if [ "$CONFIG_HOTPLUG" == "y" -a "$CONFIG_USB" == "y" -o "$CONFIG_MMC" == "y" ]; then
	mounted=`mount | grep mdev | wc -l`
	if [ $mounted -eq 0 ]; then
#	mount -t ramfs none /dev
	mount -t ramfs mdev /dev
	mkdir /dev/pts
	mount -t devpts devpts /dev/pts

        mknod   /dev/video0      c       81      0
	mknod	/dev/ppp	 c	 108	 0   
        mknod   /dev/spiS0       c       217     0
        mknod   /dev/i2cM0       c       218     0
        mknod   /dev/mt6605      c       219     0
        mknod   /dev/flash0      c       200     0
        mknod   /dev/swnat0      c       210     0
        mknod   /dev/hwnat0      c       220     0
        mknod   /dev/acl0        c       230     0
        mknod   /dev/ac0         c       240     0
        mknod   /dev/mtr0        c       250     0
        mknod   /dev/apsoc_nvram       c       251     0      
        if [ "$CONFIG_ARCH_MT7623" = "y" ]; then
        	mknod   /dev/rdm0        c       263     0
        	mknod   /dev/gpio        c       241     0
        else
        	mknod   /dev/rdm0        c       253     0
          mknod   /dev/gpio        c       252     0  
        fi
        mknod   /dev/pcm0        c       233     0
        mknod   /dev/i2s0        c       191     0
        mknod   /dev/cls0        c       235     0
	mknod   /dev/spdif0      c       236     0
	mknod   /dev/vdsp        c       245     0
	mknod   /dev/slic        c       225     0
if [ "$CONFIG_SOUND" = "y" ] || [ "$CONFIG_SOUND" = "m" ]; then
	mknod   /dev/controlC0   c       116     0
	mknod   /dev/pcmC0D0c    c       116     24
	mknod   /dev/pcmC0D0p    c       116     16
fi	

	fi
	echo "# <device regex> <uid>:<gid> <octal permissions> [<@|$|*> <command>]" > /etc/mdev.conf
        echo "# The special characters have the meaning:" >> /etc/mdev.conf
        echo "# @ Run after creating the device." >> /etc/mdev.conf
        echo "# $ Run before removing the device." >> /etc/mdev.conf
        echo "# * Run both after creating and before removing the device." >> /etc/mdev.conf
        echo "sd[a-z][1-9] 0:0 0660 */sbin/automount_boot.sh \$MDEV" >> /etc/mdev.conf
        echo "sd[a-z] 0:0 0660 */sbin/automount_boot.sh \$MDEV" >> /etc/mdev.conf
	echo "mmcblk[0-9]p[0-9] 0:0 0660 */sbin/automount_boot.sh \$MDEV" >> /etc/mdev.conf
	echo "mmcblk[0-9] 0:0 0660 */sbin/automount_boot.sh \$MDEV" >> /etc/mdev.conf
	if [ "$CONFIG_USB_SERIAL" = "y" ] || [ "$CONFIG_USB_SERIAL" = "m" ]; then
		echo "ttyUSB0 0:0 0660 @/sbin/autoconn3G.sh connect" >> /etc/mdev.conf
	fi
	if [ "$CONFIG_BLK_DEV_SR" = "y" ] || [ "$CONFIG_BLK_DEV_SR" = "m" ]; then
		echo "sr0 0:0 0660 @/sbin/autoconn3G.sh connect" >> /etc/mdev.conf
	fi
	if [ "$CONFIG_USB_SERIAL_HSO" = "y" ] || [ "$CONFIG_USB_SERIAL_HSO" = "m" ]; then
		echo "ttyHS0 0:0 0660 @/sbin/autoconn3G.sh connect" >> /etc/mdev.conf
	fi
fi
}

setMDEV()
{
#Linux2.6 uses udev instead of devfs, we have to create static dev node by myself.
if [ "$CONFIG_HOTPLUG" == "y" -a "$CONFIG_USB" == "y" -o "$CONFIG_MMC" == "y" ]; then
	echo "# <device regex> <uid>:<gid> <octal permissions> [<@|$|*> <command>]" > /etc/mdev.conf
        echo "# The special characters have the meaning:" >> /etc/mdev.conf
        echo "# @ Run after creating the device." >> /etc/mdev.conf
        echo "# $ Run before removing the device." >> /etc/mdev.conf
        echo "# * Run both after creating and before removing the device." >> /etc/mdev.conf
        echo "sd[a-z][1-9] 0:0 0660 */sbin/automount.sh \$MDEV" >> /etc/mdev.conf
        echo "sd[a-z] 0:0 0660 */sbin/automount.sh \$MDEV" >> /etc/mdev.conf
	echo "mmcblk[0-9]p[0-9] 0:0 0660 */sbin/automount.sh \$MDEV" >> /etc/mdev.conf
	echo "mmcblk[0-9] 0:0 0660 */sbin/automount.sh \$MDEV" >> /etc/mdev.conf
	if [ "$CONFIG_USB_SERIAL" = "y" ] || [ "$CONFIG_USB_SERIAL" = "m" ]; then
		echo "ttyUSB0 0:0 0660 @/sbin/autoconn3G.sh connect" >> /etc/mdev.conf
	fi
	if [ "$CONFIG_BLK_DEV_SR" = "y" ] || [ "$CONFIG_BLK_DEV_SR" = "m" ]; then
		echo "sr0 0:0 0660 @/sbin/autoconn3G.sh connect" >> /etc/mdev.conf
	fi
	if [ "$CONFIG_USB_SERIAL_HSO" = "y" ] || [ "$CONFIG_USB_SERIAL_HSO" = "m" ]; then
		echo "ttyHS0 0:0 0660 @/sbin/autoconn3G.sh connect" >> /etc/mdev.conf
	fi

        #enable usb hot-plug feature
        echo "/sbin/mdev" > /proc/sys/kernel/hotplug
fi
}

set_vlan_map()
{
	# vlan priority tag => skb->priority mapping
	vconfig set_ingress_map $1 0 0
	vconfig set_ingress_map $1 1 1
	vconfig set_ingress_map $1 2 2
	vconfig set_ingress_map $1 3 3
	vconfig set_ingress_map $1 4 4
	vconfig set_ingress_map $1 5 5
	vconfig set_ingress_map $1 6 6
	vconfig set_ingress_map $1 7 7

	# skb->priority => vlan priority tag mapping
	vconfig set_egress_map $1 0 0
	vconfig set_egress_map $1 1 1
	vconfig set_egress_map $1 2 2
	vconfig set_egress_map $1 3 3
	vconfig set_egress_map $1 4 4
	vconfig set_egress_map $1 5 5
	vconfig set_egress_map $1 6 6
	vconfig set_egress_map $1 7 7
}

ifRaxDown()
{
	num=16
	while [ "$num" -gt 0 ]
	do
		num=`expr $num - 1`
		ifconfig ra$num down 1>/dev/null 2>&1
	done
}

ifRaxWdsxDown()
{
	num=16
	while [ "$num" -gt 0 ]
	do
		num=`expr $num - 1`
		ifconfig ra$num down 1>/dev/null 2>&1
	done

	ifconfig wds0 down 1>/dev/null 2>&1
	ifconfig wds1 down 1>/dev/null 2>&1
	ifconfig wds2 down 1>/dev/null 2>&1
	ifconfig wds3 down 1>/dev/null 2>&1

	ifconfig apcli0 down 1>/dev/null 2>&1
	if [ "$CONFIG_DBDC_MODE" = "y" ]; then
		ifconfig apcli1 down 1>/dev/null 2>&1
	fi

	ifconfig mesh0 down 1>/dev/null 2>&1
	echo -e "\n##### disable 1st wireless interface #####"
}

ifRaixDown()
{
	num=16
	while [ "$num" -gt 0 ]
	do
		num=`expr $num - 1`
		ifconfig rai$num down 1>/dev/null 2>&1
	done
}

ifRaixWdsxDown()
{
	num=16
	while [ "$num" -gt 0 ]
	do
		num=`expr $num - 1`
		ifconfig rai$num down 1>/dev/null 2>&1
	done

	ifconfig wdsi0 down 1>/dev/null 2>&1
	ifconfig wdsi1 down 1>/dev/null 2>&1
	ifconfig wdsi2 down 1>/dev/null 2>&1
	ifconfig wdsi3 down 1>/dev/null 2>&1
	ifconfig apclii0 down 1>/dev/null 2>&1
	ifconfig meshi0 down 1>/dev/null 2>&1
	echo -e "\n##### disable 2nd wireless interface #####"
}

ifRaexWdsxDown()
{
	num=16
	while [ "$num" -gt 0 ]
	do
		num=`expr $num - 1`
		ifconfig rae$num down 1>/dev/null 2>&1
	done

	ifconfig wdse0 down 1>/dev/null 2>&1
	ifconfig wdse1 down 1>/dev/null 2>&1
	ifconfig wdse2 down 1>/dev/null 2>&1
	ifconfig wdse3 down 1>/dev/null 2>&1
	ifconfig apclie0 down 1>/dev/null 2>&1
	ifconfig meshe0 down 1>/dev/null 2>&1
	echo -e "\n##### disable 3rd wireless interface #####"
}

addBr0()
{
	brctl addbr br0

	# configure stp forward delay
	if [ "$wan_if" = "br0" -o "$lan_if" = "br0" ]; then
		stp=`nvram_get 2860 stpEnabled`
		if [ "$stp" = "1" ]; then
			brctl setfd br0 15
			brctl stp br0 1
		else
			brctl setfd br0 1
			brctl stp br0 0
		fi
		enableIPv6dad br0 2
	fi

}

addBr1()
{
	gn_enable=`nvram_get 2860 gn_enable`
	wl0_gmode=`nvram_get 2860 wl0_gmode`
	gn_lan_ifname=`nvram_get 2860 gn_lan_ifname`
	if [ "$gn_enable" = "1" -a "$wl0_gmode" != "-1" ]; then
		brctl addbr $gn_lan_ifname
		brctl setfd $gn_lan_ifname 1
		brctl stp $gn_lan_ifname 1
	fi
}

addDBDCApCliBr1()
{
	brctl addbr br1
	ifconfig br1 up

	binding_ap_list=`nvram_get ApcliDBDCSsidId`
	O_IFS=$IFS
	IFS=";"
	export IFS;
	i=0
	for binding in $binding_ap_list; do
		if [ "$i" != "0" ]; then
			brctl delif br0 ra$binding
		fi
		brctl addif br$i ra$binding
		brctl addif br$i apcli$i
		i=`expr $i + 1`
	done
	IFS=$O_IFS
	export IFS;
	
}

addRax2Br0()
{
	if [ "$CONFIG_FIRST_IF_NONE" == "y" ]; then
		return
	fi
	num=1
	brctl addif br0 ra0
	bssid_num=`nvram_get 2860 BssidNum`
	while [ "$num" -lt "$bssid_num" ]
	do 
		if [ "$num" = "0" ]; then
			ifconfig ra$num 0.0.0.0 1>/dev/null 2>&1
			brctl addif br0 ra$num 
		else
			gn_lan_ifname=`nvram_get 2860 gn_lan_ifname`
			gn_lan_ipaddr=`nvram_get 2860 gn_lan_ipaddr`
			gn_enable=`nvram_get 2860 gn_enable`
			wl0_gmode=`nvram_get 2860 wl0_gmode`
			if [ "$gn_enable" = "1" -a "$wl0_gmode" != "-1" ]; then
				addBr1
				ifconfig ra$num 0.0.0.0 1>/dev/null 2>&1
				brctl addif $gn_lan_ifname ra$num
				ifconfig $gn_lan_ifname up $gn_lan_ipaddr
			else
				ifconfig $gn_lan_ifname down
			fi
		fi
		num=`expr $num + 1` 
	done 
}

addWds2Br0()
{
	if [ "$CONFIG_FIRST_IF_NONE" == "y" ]; then
		return
	fi
	wds_en=`nvram_get 2860 WdsEnable`
	if [ "$wds_en" != "0" ]; then
		ifconfig wds0 up 1>/dev/null 2>&1
		ifconfig wds1 up 1>/dev/null 2>&1
		ifconfig wds2 up 1>/dev/null 2>&1
		ifconfig wds3 up 1>/dev/null 2>&1
		brctl addif br0 wds0
		brctl addif br0 wds1
		brctl addif br0 wds2
		brctl addif br0 wds3
	fi
}

addMesh2Br0()
{
	if [ "$CONFIG_FIRST_IF_NONE" == "y" ]; then
		return
	fi
	meshenabled=`nvram_get 2860 MeshEnabled`
	if [ "$meshenabled" = "1" ]; then
		ifconfig mesh0 up 1>/dev/null 2>&1
		brctl addif br0 mesh0
		meshhostname=`nvram_get 2860 MeshHostName`
		iwpriv mesh0 set  MeshHostName="$meshhostname"
	fi
}

addRaix2Br0()
{
	if [ "$CONFIG_SECOND_IF_NONE" == "y" ]; then
		return
	fi
	brctl addif br0 rai0
	num=0
	bssid_num=`nvram_get rtdev BssidNum`
	while [ "$num" -lt "$bssid_num" ]
	do
		ifconfig rai$num up 1>/dev/null 2>&1
		brctl addif br0 rai$num
		num=`expr $num + 1`
	done
	echo -e "\n##### enable 2nd wireless interface #####"
}

addInicWds2Br0()
{
	if [ "$CONFIG_SECOND_IF_NONE" == "y" ]; then
		return
	fi
	wds_en=`nvram_get rtdev WdsEnable`
	if [ "$wds_en" != "0" ]; then
		ifconfig wdsi0 up 1>/dev/null 2>&1
		ifconfig wdsi1 up 1>/dev/null 2>&1
		ifconfig wdsi2 up 1>/dev/null 2>&1
		ifconfig wdsi3 up 1>/dev/null 2>&1
		brctl addif br0 wdsi0
		brctl addif br0 wdsi1
		brctl addif br0 wdsi2
		brctl addif br0 wdsi3
	fi
}

addRaL02Br0()
{
	if [ "$CONFIG_RT2561_AP" != "" ]; then
		brctl addif br0 raL0
	fi
}

addRaex2Br0()
{
	if [ "$CONFIG_THIRD_IF_NONE" == "y" ]; then
		return
	fi
	brctl addif br0 rae0
	num=0
	bssid_num=`nvram_get wifi3 BssidNum`
	while [ "$num" -lt "$bssid_num" ]
	do
		ifconfig rae$num up 1>/dev/null 2>&1
		brctl addif br0 rae$num
		num=`expr $num + 1`
	done
	wds_en=`nvram_get wifi3 WdsEnable`
	if [ "$wds_en" != "0" ]; then
		ifconfig wdse0 up 1>/dev/null 2>&1
		ifconfig wdse1 up 1>/dev/null 2>&1
		ifconfig wdse2 up 1>/dev/null 2>&1
		ifconfig wdse3 up 1>/dev/null 2>&1
		brctl addif br0 wdse0
		brctl addif br0 wdse1
		brctl addif br0 wdse2
		brctl addif br0 wdse3
	fi
	echo -e "\n##### enable 3rd wireless interface #####"
}

#
#	ipv6 config#
#	$1:	interface name
#	$2:	dad_transmit number
#
enableIPv6dad()
{
	if [ "$CONFIG_IPV6" == "y" -o "$CONFIG_IPV6" == "m" ]; then
		echo "2" > /proc/sys/net/ipv6/conf/$1/accept_dad
		echo $2 > /proc/sys/net/ipv6/conf/$1/dad_transmits
	fi
}

disableIPv6dad()
{
	if [ "$CONFIG_IPV6" == "y" -o "$CONFIG_IPV6" == "m" ]; then
		echo "0" > /proc/sys/net/ipv6/conf/$1/accept_dad
	fi
}


genSysFiles()
{
	login=`nvram_get 2860 Login`
	pass=`nvram_get 2860 Password`
	if [ "$login" != "" -a "$pass" != "" ]; then
	echo "$login::0:0:Adminstrator:/:/bin/sh" > /etc/passwd
	echo "$login:x:0:$login" > /etc/group
		chpasswd.sh $login $pass
	fi
	if [ "$CONFIG_PPPOL2TP" == "y" ]; then
	echo "l2tp 1701/tcp l2f" > /etc/services
	echo "l2tp 1701/udp l2f" >> /etc/services
	fi
}

configVIF()
{
	echo "##### configVIF #####"

	if [ "$CONFIG_TASKLET_WORKQUEUE_SW" == "y" ]; then
		ifconfig eth2 down
		PLATFORM=`nvram_get 2860 Platform | tr A-Z a-z`
		if [ "$wanmode" == "PPPOE" -o "$wanmode" == "L2TP" -o "$wanmode" == "PPTP" ]; then
			echo 1 > /proc/$PLATFORM/schedule
		else
			echo 0 > /proc/$PLATFORM/schedule
		fi
	fi
	ifconfig eth2 0.0.0.0
	if [ "$CONFIG_GE2_RGMII_AN" = "y" -o "$CONFIG_GE2_INTERNAL_GPHY" = "y" ]; then
		ifconfig eth3 up
		enableIPv6dad eth3 2

	elif [ "$CONFIG_RAETH_ROUTER" = "y" -o "$CONFIG_MAC_TO_MAC_MODE" = "y" -o "$CONFIG_RT_3052_ESW" = "y" ]; then
		vconfig rem eth2.1
		vconfig rem eth2.2
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
		vconfig add eth2 2
		set_vlan_map eth2.2
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
			ifconfig eth2.2 down
			wan_mac=`nvram_get 2860 WAN_MAC_ADDR`
			if [ "$wan_mac" != "FF:FF:FF:FF:FF:FF" ]; then
				ifconfig eth2.2 hw ether $wan_mac
				ifconfig eth2.2 hw ether $wan_mac
				ifconfig eth2.2 hw ether $wan_mac
			fi
			enableIPv6dad eth2.2 1
		fi

		ifconfig eth2.1 0.0.0.0
		ifconfig eth2.2 0.0.0.0
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

stop_wireless()
{
	ifRaxWdsxDown
	ifRaixWdsxDown
	ifRaexWdsxDown
	if [ "$CONFIG_RT2860V2_AP" != "" ]; then
		rmmod rt2860v2_ap_net
		rmmod rt2860v2_ap
		rmmod rt2860v2_ap_util
	fi
	if [ "$CONFIG_RT2860V2_STA" != "" ]; then
		rmmod rt2860v2_sta_net
		rmmod rt2860v2_sta
		rmmod rt2860v2_sta_util
	fi
	if [ "$RT2880v2_INIC_PCI" != "" ]; then
		rmmod iNIC_pci
	fi

	if [ "$CONFIG_RLT_AP_SUPPORT" != "" -o "$CONFIG_RLT_STA_SUPPORT" != "" ]; then
	  rmmod rlt_wifi 
		
	fi
	if [ "$CONFIG_MT_AP_SUPPORT" != "" ]; then
			rmmod mt_wifi
	fi
	if [ "$CONFIG_RT3090_AP" != "" ]; then
		rmmod RT3090_ap_net
		rmmod RT3090_ap
		rmmod RT3090_ap_util
	fi
	if [ "$CONFIG_RT5392_AP" != "" ]; then
		rmmod RT5392_ap
	fi
	if [ "$CONFIG_RT5592_AP" != "" ]; then
		rmmod RT5592_ap
	fi
	if [ "$CONFIG_RT3593_AP" != "" ]; then
		rmmod RT3593_ap
	fi
	if [ "$CONFIG_MT7610_AP" != "" ]; then
		rmmod MT7610_ap
	fi
	if [ "$CONFIG_RTPCI_AP" != "" ]; then
		rmmod RTPCI_ap
	fi
	if [ "$CONFIG_RT3572_AP" != "" ]; then
		rmmod RT3572_ap_net
		rmmod RT3572_ap
		rmmod RT3572_ap_util
	fi
	if [ "$CONFIG_RT5572_AP" != "" ]; then
		rmmod RT5572_ap_net
		rmmod RT5572_ap
		rmmod RT5572_ap_util
	fi
	if [ "$RT305x_INIC_USB" != "" ]; then
		rmmod iNIC_usb
	fi
	if [ "$CONFIG_RT3680_iNIC_AP" != "" ]; then
		rmmod RT3680_ap
	fi
	if [ "$CONFIG_RT2561_AP" != "" ]; then
		rmmod rt2561ap
	fi

}

start_wireless()
{
	if [ "$CONFIG_RT2860V2_AP_WAPI$CONFIG_RT3090_AP_WAPI$CONFIG_RT5392_AP_WAPI$CONFIG_RT5592_AP_WAPI$CONFIG_RT3593_AP_WAPI$CONFIG_MT7610_AP_WAPI$CONFIG_RT3572_AP_WAPI$CONFIG_RT5572_AP_WAPI$CONFIG_RT3680_iNIC_AP_WAPI$CONFIG_RTPCI_AP_WAPI" != "" ]; then
		ralink_init gen wapi
	fi
	ralink_init make_wireless_config rt2860
	DBDC_MODE=`nvram_get 2860 DBDC_MODE`
	if [ "$DBDC_MODE" == "1" ]; then
		cp /etc_ro/Wireless/RT2860AP/RT2860_dbdc_def.dat /etc/Wireless/RT2860/RT2860_def.dat
	elif [ "$DBDC_MODE" == "0" ]; then
		cp /etc_ro/Wireless/RT2860AP/RT2860_def.dat /etc/Wireless/RT2860/RT2860_def.dat
	fi
	ralink_init make_wireless_config rtdev
	ralink_init make_wireless_config wifi3
	if [ "$CONFIG_RT2860V2_AP_DFS$CONFIG_RT5592_AP_DFS$CONFIG_RT3593_AP_DFS$CONFIG_MT7610_AP_DFS$CONFIG_RT3572_AP_DFS$CONFIG_RT5572_AP_DFS$CONFIG_RTPCI_AP_DFS" != "" ]; then
		insmod -q rt_timer
	fi
	if [ "$CONFIG_RT2860V2_STA" != "" -a "$stamode" = "y" ]; then
		insmod -q rt2860v2_sta_util
		insmod -q rt2860v2_sta
		insmod -q rt2860v2_sta_net

		if [ "$CONFIG_RT2860V2_STA_WPA_SUPPLICANT" == "y" ]; then
			ralink_init gen cert
		fi
	elif [ "$CONFIG_RT2860V2_AP" != "" ]; then
		insmod -q rt2860v2_ap_util
		insmod -q rt2860v2_ap
		insmod -q rt2860v2_ap_net
	fi
	# RTDEV_PCI support
	if [ "$RT2880v2_INIC_PCI" != "" ]; then
		insmod -q iNIC_pci 
	fi
	if [ "$CONFIG_RLT_AP_SUPPORT" != "" -o "$CONFIG_RLT_STA_SUPPORT" != "" ]; then
	  cp /lib/modules/2.6.36\+/kernel/drivers/net/wireless/rlt_wifi_ap/rlt_wifi.ko.lzma /lib/
	  unlzma /lib/modules/2.6.36\+/kernel/drivers/net/wireless/rlt_wifi_ap/rlt_wifi.ko.lzma 
	  sleep 1
	  insmod -q rlt_wifi 
	  mv /lib/rlt_wifi.ko.lzma /lib/modules/2.6.36\+/kernel/drivers/net/wireless/rlt_wifi_ap/
	  rm /lib/modules/2.6.36\+/kernel/drivers/net/wireless/rlt_wifi_ap/rlt_wifi.ko -rf
	fi
	if [ "$CONFIG_MT_AP_SUPPORT" != "" ]; then
			insmod -q mt_wifi
	fi
	if [ "$CONFIG_RT3090_AP" != "" ]; then
		insmod -q RT3090_ap_util
		insmod -q RT3090_ap
		insmod -q RT3090_ap_net
	fi
	if [ "$CONFIG_RT5392_AP" != "" ]; then
		insmod -q RT5392_ap
	fi
	if [ "$CONFIG_RT5592_AP" != "" ]; then
		insmod -q RT5592_ap
	fi
	if [ "$CONFIG_MT7610_AP" != "" ]; then
		insmod -q MT7610_ap
	fi
	if [ "$CONFIG_RT3593_AP" != "" ]; then
		insmod -q RT3593_ap
	fi
	if [ "$CONFIG_RTPCI_AP" != "" ]; then
		insmod -q RTPCI_ap
	fi
	# RTDEV_USB support
	if [ "$RT305x_INIC_USB" != "" ]; then
		insmod -q iNIC_usb 
	fi
	if [ "$CONFIG_RT3572_AP" != "" ]; then
		insmod -q RT3572_ap_util
		insmod -q RT3572_ap
		insmod -q RT3572_ap_net
	fi
	if [ "$CONFIG_RT5572_AP" != "" ]; then
		insmod -q RT5572_ap_util
		insmod -q RT5572_ap
		insmod -q RT5572_ap_net
	fi
	if [ "$CONFIG_RT3680_iNIC_AP" != "" ]; then
		insmod -q RT3680_ap
	fi

	# RT2561(Legacy) support
	if [ "$CONFIG_RT2561_AP" != "" ]; then
		insmod -q rt2561ap
	fi
	if [ "$CONFIG_RTDEV_PLC" != "" ]; then
		ifconfig plc0 up
	fi
	# config interface
#	if [ "$wireless_bridge" = "0" ]; then
		if [ "$RadioOff_24" = "0" ]; then
			ifconfig ra0 0.0.0.0 1>/dev/null 2>&1
			if [ "$ethconv" = "y" ]; then
				iwpriv ra0 set EthConvertMode=hybrid
				iwpriv ra0 set EthCloneMac=`nvram_get 2860 ethConvertMAC`
			fi
		fi
		if [ "$CONFIG_SECOND_IF_NONE" != "y" -o "$CONFIG_RT2561_AP" != "" ]; then
			if [ "$RadioOff_5" = "0" ]; then
				ifconfig rai0 0.0.0.0 1>/dev/null 2>&1
			fi
		fi
#	fi
	if [ "$CONFIG_THIRD_IF_NONE" != "y" ]; then
		ifconfig rae0 0.0.0.0 1>/dev/null 2>&1
		if [ "$radio_off3" = "1" ]; then
			iwpriv rae0 set RadioOn=0
		fi
	fi
	
	m2uenabled1=`nvram_get 2860 M2UEnabled`
	if [ "$m2uenabled1" = "1" ]; then
        	iwpriv ra0 set IgmpSnEnable=1
	        echo "***iwpriv ra0 set IgmpSnEnable=1**"
	fi
	m2uenabled2=`nvram_get rtdev M2UEnabled`
	if [ "$m2uenabled2" = "1" ]; then
        	iwpriv rai0 set IgmpSnEnable=1
	        echo "***iwpriv rai0 set IgmpSnEnable=1**"
	fi
}

start_wireless_all()
{
	start_wireless
	if [ "$opmode" = "0" ]; then
#addBr0
		if [ "$RadioOff_24" = "0" ]; then
			addRax2Br0
		fi
		addWds2Br0
		addMesh2Br0
		if [ "$RadioOff_5" = "0" ]; then
			addRaix2Br0
		fi
		addInicWds2Br0
		addRaL02Br0
		addRaex2Br0
#		wan.sh
#		lan.sh
		if [ "$wireless_bridge" = "1" ]; then
			ifRaxDown
			ifRaixDown
		fi
	elif [ "$opmode" = "1" ]; then
		addBr0
		if [ "$RadioOff_24" = "0" ]; then
			addRax2Br0
		fi
		addWds2Br0
		addMesh2Br0
		if [ "$RadioOff_5" = "0" ]; then
			addRaix2Br0
		fi
		addInicWds2Br0
		addRaL02Br0
		addRaex2Br0
		#wan.sh
#		lan.sh
#		nat.sh

		# set the global ipv6 address for LAN/WAN, enable ipv6 forwarding,
		# enable ecmh(multicast) daemon
	elif [ "$opmode" = "2" ]; then
		addBr0
		if [ "$RadioOff_5" = "0" ]; then
			addRaix2Br0
		fi
		addInicWds2Br0
		addRaL02Br0
		addRaex2Br0
		#wan.sh
		lan.sh
		nat.sh
	elif [ "$opmode" = "3" ]; then
		addBr0
		if [ "$RadioOff_24" = "0" ]; then
			addRax2Br0
		fi
		brctl addif br0 eth2
		if [ "$CONFIG_GE2_RGMII_AN" = "y" -o "$CONFIG_GE2_INTERNAL_GPHY" = "y" ]; then
			brctl addif br0 eth3
		fi
		if [ "$RadioOff_5" = "0" ]; then
			addRaix2Br0
		fi
		addInicWds2Br0
		addRaL02Br0
		addRaex2Br0
		#wan.sh
		lan.sh
		nat.sh
	else
		echo "unknown OperationMode: $opmode"
		exit 1
	fi
}
