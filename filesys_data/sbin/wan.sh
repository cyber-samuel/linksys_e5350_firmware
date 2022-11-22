#!/bin/sh
#
# $Id: //WIFI_SOC/MP/SDK_5_0_0_0/RT288x_SDK/source/user/rt2880_app/scripts/wan.sh#1 $
#
# usage: wan.sh
#

. /sbin/global.sh

write_dhcpc_wan_conf()
{
  cat >/tmp/dhcpc-wan.conf <<_EOFILE
send host-name "`nvram_get 2860 machine_name`";
send dhcp-client-identifier 01:`web 2860 sys wanMacAddr`;
request subnet-mask, routers, domain-name, domain-name-servers;
require subnet-mask, routers,
dhcp-lease-time, dhcp-server-identifier;
_EOFILE
}

write_dhcp6c_wan_conf()
{
  cat >/tmp/dhcp6c-wan.conf <<_EOFILE
request dhcp6.name-servers, dhcp6.domain-search, dhcp6.sntp-servers;
send dhcp6.client-id 00:03:00:01:`web 2860 sys wanMacAddr`;
_EOFILE
}

start_dhclient()
{
  write_dhcpc_wan_conf
  dhclient -d -nw -cf /tmp/dhcpc-wan.conf -sf /bin/dhcpc  \
   -lf /tmp/dhcpc-wan.leases -pf /var/run/dhcpc-wan.pid $wan_if
}

stop_dhclient()
{
  killall -q dhclient
  rm -rf /var/run/dhcpc-wan.pid
}


start_dhclient6()
{
  write_dhcp6c_wan_conf
  dhclient -6 -N -P -q -nw -cf /tmp/dhcp6c-wan.conf -sf /bin/client6  \
   -lf /tmp/dhcp6c-wan.leases -pf /var/run/dhcp6c-wan.pid $wan_if
}

stop_dhclient6()
{
  killall -q dhclient
  rm -rf /var/run/dhcp6c-wan.pid
}

start_bridge()
{
  if [ "$1" = 1 ]; then
    cat >/tmp/dhcpc-wan.conf <<_EOFILE
send host-name "`nvram_get 2860 machine_name`";
send dhcp-client-identifier 01:`web 2860 sys wanMacAddr`;
request subnet-mask, routers, domain-name, domain-name-servers;
require subnet-mask, routers,
dhcp-lease-time, dhcp-server-identifier;
_EOFILE
	wireless_bridge=`nvram_get 2860 wbridge_mode`
	if [ "$wireless_bridge" = "0" ]; then
  		dhclient -nw -cf /tmp/dhcpc-wan.conf -sf /bin/dhcpc  \
   		-lf /tmp/dhcpc-wan.leases -pf /var/run/dhcpc-wan.pid -bm br0 eth2.2 
	else
		wbridge_band=`nvram_get 2860 wbridge_band`
		if [ "$wbridge_band" = "0" ]; then
  			dhclient -nw -cf /tmp/dhcpc-wan.conf -sf /bin/dhcpc  \
   			-lf /tmp/dhcpc-wan.leases -pf /var/run/dhcpc-wan.pid -bm br0 apcli0 
		else
  			dhclient -nw -cf /tmp/dhcpc-wan.conf -sf /bin/dhcpc  \
   			-lf /tmp/dhcpc-wan.leases -pf /var/run/dhcpc-wan.pid -bm br0 apclii0 
		fi
	fi

  else
	ip=`nvram_get 2860 switch_ipaddr`
	nm=`nvram_get 2860 switch_netmask`
	gw=`nvram_get 2860 switch_gateway`
	pd=`nvram_get 2860 wan_primary_dns`
	sd=`nvram_get 2860 wan_secondary_dns`

	ifconfig $lan_if $ip netmask $nm
	route del default
	if [ "$gw" != "" ]; then
	 route add default gw $gw
	fi
	config-dns.sh $pd $sd
	wan start_switch_wan_done
  fi

}

stop_bridge()
{
  killall -q dhclient
  rm -rf /var/run/dhcpc-wan.pid
}

# stop all
killall -q syslogd
killall -q udhcpc
stop_dhclient
killall -q pppd
killall -q l2tpd
killall -q openl2tpd


clone_en=`nvram_get 2860 macCloneEnabled`
clone_mac=`nvram_get 2860 macCloneMac`
#MAC Clone: bridge mode doesn't support MAC Clone
if [ "$opmode" != "0" -a "$clone_en" = "1" ]; then
	ifconfig $wan_if down
	if [ "$opmode" = "2" ]; then
		if [ "$CONFIG_RT2860V2_STA" == "m" ]; then
		rmmod rt2860v2_sta_net
		rmmod rt2860v2_sta
		rmmod rt2860v2_sta_util

		insmod -q rt2860v2_sta_util
		insmod -q rt2860v2_sta mac=$clone_mac
		insmod -q rt2860v2_sta_net
		elif [ "$CONFIG_RLT_STA_SUPPORT" == "m" ]; then
			rmmod rlt_wifi_sta
			insmod -q rlt_wifi_sta mac=$clone_mac
		fi
	else
		ifconfig $wan_if hw ether $clone_mac
	fi
	ifconfig $wan_if up
fi

if [ "$opmode" = "0" ]; then
	switch_mode_dhcp=`nvram_get 2860 switch_mode_dhcp`
	start_bridge $switch_mode_dhcp
else
	echo "Start WAN ....."
	wan stop
	wan start boot
fi

#Not execute the following shell commands
if [ "1" = "0" ]; then
if [ "$wanmode" = "STATIC" ]; then
	#always treat bridge mode having static wan connection
	ip=`nvram_get 2860 wan_ipaddr`
	nm=`nvram_get 2860 wan_netmask`
	gw=`nvram_get 2860 wan_gateway`
	pd=`nvram_get 2860 wan_primary_dns`
	sd=`nvram_get 2860 wan_secondary_dns`

	#lan and wan ip should not be the same except in bridge mode
	if [ "$opmode" != "0" ]; then
		lan_ip=`nvram_get 2860 lan_ipaddr`
		if [ "$ip" = "$lan_ip" ]; then
			echo "wan.sh: warning: WAN's IP address is set identical to LAN"
			exit 0
		fi
	else
		#use lan's ip address instead
		ip=`nvram_get 2860 lan_ipaddr`
		nm=`nvram_get 2860 lan_netmask`
	fi
	ifconfig $wan_if $ip netmask $nm
	route del default
	if [ "$gw" != "" ]; then
	route add default gw $gw
	fi
	config-dns.sh $pd $sd
elif [ "$wanmode" = "DHCP" ]; then
	#wan_ipv6_dhcp="`nvram_get 2860 wan_ipv6_dhcp`"
	wan stop
	wan start boot
	#if [ "$wan_ipv6_dhcp" = "on" ]; then
	#	start_dhclient6
	#else
	#	start_dhclient
	#fi
	#Not use udhcpc
	if [ "1" = "0" ]; then
	hn=`nvram_get 2860 wan_dhcp_hn`
	if [ "$hn" != "" ]; then
		udhcpc -i $wan_if -h $hn -s /sbin/udhcpc.sh -p /var/run/udhcpc.pid &
	else
		udhcpc -i $wan_if -s /sbin/udhcpc.sh -p /var/run/udhcpc.pid &
	fi
	fi
elif [ "$wanmode" = "PPPOE" ]; then
	u=`nvram_get 2860 wan_pppoe_user`
	pw=`nvram_get 2860 wan_pppoe_pass`
	pppoe_opmode=`nvram_get 2860 wan_pppoe_opmode`
	if [ "$pppoe_opmode" = "" ]; then
		echo "pppoecd $wan_if -u $u -p $pw"
		pppoecd $wan_if -u "$u" -p "$pw"
	else
		pppoe_optime=`nvram_get 2860 wan_pppoe_optime`
		config-pppoe.sh $u $pw $wan_if $pppoe_opmode $pppoe_optime
	fi
elif [ "$wanmode" = "L2TP" ]; then
	srv=`nvram_get 2860 wan_l2tp_server`
	u=`nvram_get 2860 wan_l2tp_user`
	pw=`nvram_get 2860 wan_l2tp_pass`
	mode=`nvram_get 2860 wan_l2tp_mode`
	l2tp_opmode=`nvram_get 2860 wan_l2tp_opmode`
	l2tp_optime=`nvram_get 2860 wan_l2tp_optime`
	if [ "$mode" = "0" ]; then
		ip=`nvram_get 2860 wan_l2tp_ip`
		nm=`nvram_get 2860 wan_l2tp_netmask`
		gw=`nvram_get 2860 wan_l2tp_gateway`
		if [ "$gw" = "" ]; then
			gw="0.0.0.0"
		fi
		config-l2tp.sh static $wan_if $ip $nm $gw $srv $u $pw $l2tp_opmode $l2tp_optime
	else
		config-l2tp.sh dhcp $wan_if $srv $u $pw $l2tp_opmode $l2tp_optime
	fi
elif [ "$wanmode" = "PPTP" ]; then
	srv=`nvram_get 2860 wan_pptp_server`
	u=`nvram_get 2860 wan_pptp_user`
	pw=`nvram_get 2860 wan_pptp_pass`
	mode=`nvram_get 2860 wan_pptp_mode`
	pptp_opmode=`nvram_get 2860 wan_pptp_opmode`
	pptp_optime=`nvram_get 2860 wan_pptp_optime`
	if [ "$mode" = "0" ]; then
		ip=`nvram_get 2860 wan_pptp_ip`
		nm=`nvram_get 2860 wan_pptp_netmask`
		gw=`nvram_get 2860 wan_pptp_gateway`
		if [ "$gw" = "" ]; then
			gw="0.0.0.0"
		fi
		config-pptp.sh static $wan_if $ip $nm $gw $srv $u $pw $pptp_opmode $pptp_optime
	else
		config-pptp.sh dhcp $wan_if $srv $u $pw $pptp_opmode $pptp_optime
	fi
elif [ "$wanmode" = "3G" ]; then
	autoconn3G.sh connect &
else
	echo "wan.sh: unknown wan connection type: $wanmode"
	exit 1
fi
fi
