#!/bin/sh
#
. /sbin/config.sh
. /sbin/global.sh

#  arg1:  phy address.
link_down()
{
	# get original register value
	get_mii=`mii_mgr -g -p $1 -r 0`
	orig=`echo $get_mii | sed 's/^.....................//'`

	# stupid hex value calculation.
	pre=`echo $orig | sed 's/...$//'`
	post=`echo $orig | sed 's/^..//'` 
	num_hex=`echo $orig | sed 's/^.//' | sed 's/..$//'`
	case $num_hex in
		"0")	rep="8"	;;
		"1")	rep="9"	;;
		"2")	rep="a"	;;
		"3")	rep="b"	;;
		"4")	rep="c"	;;
		"5")	rep="d"	;;
		"6")	rep="e"	;;
		"7")	rep="f"	;;
		# The power is already down
		*)		echo "Port$1 is down. Skip.";return;;
	esac
	new=$pre$rep$post
	# power down
	mii_mgr -s -p $1 -r 0 -v $new
}

link_up()
{
	# get original register value
	get_mii=`mii_mgr -g -p $1 -r 0`
	orig=`echo $get_mii | sed 's/^.....................//'`

	# stupid hex value calculation.
	pre=`echo $orig | sed 's/...$//'`
	post=`echo $orig | sed 's/^..//'` 
	num_hex=`echo $orig | sed 's/^.//' | sed 's/..$//'`
	case $num_hex in
		"8")	rep="2"	;;
		"9")	rep="3"	;;
		"a")	rep="2"	;;
		"b")	rep="3"	;;
		"c")	rep="6"	;;
		"d")	rep="7"	;;
		"e")	rep="6"	;;
		"f")	rep="7"	;;
		# The power is already up
		*)		echo "Port$1 is up. Skip.";return;;
	esac
	new=$pre$rep$post
	# power up
	mii_mgr -s -p $1 -r 0 -v $new
}

reset_all_phys()
{
	sleep_time=$1

	if [ "$CONFIG_RAETH_ROUTER" != "y" -a "$CONFIG_RT_3052_ESW" != "y" ]; then
		return
	fi

	opmode=`nvram_get 2860 OperationMode`

	#skip WAN port
	if [ "$opmode" != "1" ]; then #no wan port
		link_down 0
		link_down 4
	elif [ "$CONFIG_WAN_AT_P4" = "y" ]; then #wan port at port4
		link_down 0
	elif [ "$CONFIG_WAN_AT_P0" = "y" ]; then #wan port at port0
		link_down 4
	fi
	link_down 1
	link_down 2
	link_down 3

	#force Windows clients to renew IP and update DNS server
	sleep $sleep_time

	#skip WAN port
	if [ "$opmode" != "1" ]; then #no wan port
		link_up 0
		link_up 4
	elif  [ "$CONFIG_WAN_AT_P4" = "y" ]; then #wan port at port4
		link_up 0
	elif [ "$CONFIG_WAN_AT_P0" = "y" ]; then #wan port at port0
		link_up 4
	fi
	link_up 1
	link_up 2
	link_up 3
}

#$1 is up/down, $2 is port.
if [ "$1" = "up" ]; then
	link_up "$2"
elif [ "$1" = "down" ]; then
	link_down "$2"
elif [ "$1" = "reset" ]; then
	reset_all_phys 2
fi


