#!/bin/sh

FW_URL="$(nvram_get 2860 online_fw_dl_url)"
GPG_FW_PATH="/tmp/code.bin.gpg"
FW_PATH="/tmp/code.bin"
DEFAULT_KEY="/etc_ro/pubkey"
PUB_KEY="/tmp/pub_key"

manufacturer="cybertan"
mac_address=`nvram_get 2860 WAN_MAC_ADDR`
wan_mac=`echo $mac_address | sed 's/:/-/g'`
hardware_version=`nvram_get 2860 hw_version`
model_number=`nvram_get 2860 model_name`
installed_version=`nvram_get 2860 fw_version`
serial_number=`nvram_get 2860 get_sn`

KEY_URL="https://update.linksys.com/api/v2/key?manufacturer=$manufacturer&mac_address=$wan_mac&hardware_version=$hardware_version&model_number=$model_number&installed_version=$installed_version&serial_number=$serial_number"

kill_process()
{
	killall miniupnpd
	killall tftpd
	killall cron
#	killall cesmDNS
#	killall dnsmasq
	killall dhcpd
	rm /lib/libzebra-0.9.28.so
	rm /lib/libdhcp.so
	unlzma /lib/libcurl.so.lzma
#	unlzma /lib/libcrypto.so.1.0.0.lzma
	unlzma /lib/libssl.so.1.0.0.lzma
#	ln -sf /lib/libcrypto.so.1.0.0 /lib/libcrypto.so
	ln -sf /lib/libssl.so.1.0.0 /lib/libssl.so

	echo 3 > /proc/sys/vm/drop_caches
}

check_mem()
{
	mem=`expr $1 \* 1024`
	free_mem=`free | awk '/Mem/ {print $4}'`
	echo "free:$free_mem------need mem:$mem"
	if [ $free_mem -ge $mem ]; then
		return 0
	fi
	return 1
}

handle_cbt_download_fw()
{
	retry=3
	kill_process
	check_mem 10
	ret=$?
	if [ $ret -eq 0 ];then
		while [ $retry -gt 0 ]; do
			if curl -m 120 -o "$GPG_FW_PATH" -k "$FW_URL"; then
				if [ -s $GPG_FW_PATH ];then
					echo "Download f/w OK!" >/dev/console
					return 0	
				else
					echo "download f/w fail from Internet Server!" >/dev/console
					retry=`awk -v a=$retry 'BEGIN{print a-1}'`
					rm $FW_PATH
				fi
			else
				echo "fail to download f/w from Internet Server!" >/dev/console
				retry=`awk -v a=$retry 'BEGIN{print a-1}'`
				rm $GPG_FW_PATH
			fi
		done
	fi
	return 1
}

backup_to_local()
{
	unlzma /bin/openssl.lzma
	cbtinfo w pubkey $PUB_KEY
	return 0
}

load_local_key()
{
	cbtinfo r pubkey
	return 0
}

check_key()
{
	sta=`cat $PUB_KEY | sed -n 1p | cut -d '"' -f 4`
	content=`cat $PUB_KEY | sed '1d' | sed '$d'`
	end=`cat $PUB_KEY | sed -n '$p' | cut -d '"' -f 1`
	echo "$sta" > $PUB_KEY
	echo "$content" >> $PUB_KEY
	echo "$end" >> $PUB_KEY
}

handle_cbt_download_pubkey()
{
	retry=3
	while [ $retry -gt 0 ]; do
#if wget -O "$PUB_KEY" "$KEY_URL"; then
		if curl -m 300 -o "$PUB_KEY" -k "$KEY_URL"; then
			if [ -s $PUB_KEY ];then
				echo "Download key OK!" >/dev/console
				check_key
				backup_to_local
				return 0	
			else
				echo "download f/w fail from Internet Server!" >/dev/console
				retry=`awk -v a=$retry 'BEGIN{print a-1}'`
				rm $PUB_KEY
			fi
		else
			echo "fail to download f/w from Internet Server!" >/dev/console
			retry=`awk -v a=$retry 'BEGIN{print a-1}'`
			rm $PUB_KEY
		fi
	done
	load_local_key
	ret=$?
	if [ $ret -eq 0 ];then
		return 0
	else
		return 1
	fi
}

verify_sign_fw()
{
	unlzma /usr/sbin/gpg.lzma
	free_mem.sh
	check_mem 10
	ret=$?
	if [ $ret -eq 0 ];then
		echo "key file:$PUB_KEY"
		if gpg --import "$PUB_KEY"; then
			if gpg --verify "$GPG_FW_PATH"; then
				if gpg -vv "$GPG_FW_PATH"; then
					return 0
				else
					echo "gpg -vv fail"
					return -1
				fi
			fi
		fi
	fi
	return 1
}

handle_cbt_code_pattern()
{
	[ -z "$1" ] && exit 0
	if [ $(hexdump -n 4 -e '4 "%c"' $1) != "$(nvram_get 2860 code_pt)" ]; then
		echo "code pattern is wrong!" > /dev/console
		return 1
        fi

	return 0	
}

mtd_write_fw()
{
	handle_cbt_code_pattern $FW_PATH
	ret=$?
	if [ $ret -eq 0 ];then
		size=`ls -l $FW_PATH | awk '{print $5}'`
		#ignore 32 bytes code header
		mtd_write -o 32 -l $size write $FW_PATH Kernel
		ret=$?
		if [ $ret -eq 0 ];then
			echo "1" > /tmp/.fw_up_result
			nvram_set 2860 wz_fw_up_result 1
			nvram_commit 2860
			return 0
		fi
	fi
}

handle_cbt_download_fw
ret=$?
if [ $ret -eq 0 ];then
	handle_cbt_download_pubkey
	ret=$?
	if [ $ret -eq 0 ];then
		verify_sign_fw
		ret=$?
		if [ $ret -eq 0 ];then
			mtd_write_fw
			return 0
		elif [ $ret -eq 1 ];then
			echo "user default key"
			PUB_KEY=$DEFAULT_KEY
			verify_sign_fw
			ret=$?
			if [ $ret -eq 0 ];then
				mtd_write_fw
				return 0
			fi
		fi
	fi
fi
echo "0" >/tmp/.fw_up_result
nvram_set 2860 wz_fw_up_result 0
nvram_commit 2860
