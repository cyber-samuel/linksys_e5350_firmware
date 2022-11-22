#!/bin/sh

#FW_TYPE="Stage"

#test URL
STAGE_URL="https://update1-stage.linksys.com/api/v2/fw/update"
#normal URL
PROD_URL="https://update1.linksys.com/api/v2/fw/update"
if [ "${FW_TYPE}" = "Stage" ]; then
	FW_URL="${STAGE_URL}"
else
	FW_URL="${PROD_URL}"
fi

RESP="/tmp/.resp"
FW_INFO="/tmp/.fw_info"

wan_mac="$(nvram_get 2860 wan_hwaddr)"
hw_version="$(nvram_get 2860 hw_version)"
model_number="$(nvram_get 2860 model_number)"
fw_ver="$(nvram_get 2860 fw_version)"
wan_ip="$(nvram_get 2860 wan_ipaddr)"
sn="$(nvram_get 2860 get_sn)"
params="mac_address=$wan_mac&hardware_version=$hw_version&model_number=$model_number&installed_version=$fw_ver&ip_address=$wan_ip&serial_number=$sn"

retry=3

rm $RESP -rf 
rm $FW_INFO -rf 

#cp /lib/libcrypto.so.1.0.0.lzma /lib/libcrypto.so.1.0.0.lzma-1
cp /lib/libssl.so.1.0.0.lzma /lib/libssl.so.1.0.0.lzma-1
cp /lib/libcurl.so.lzma /lib/libcurl.so.lzma-1

unlzma /lib/libcurl.so.lzma
#unlzma /lib/libcrypto.so.1.0.0.lzma
unlzma /lib/libssl.so.1.0.0.lzma
#ln -sf /lib/libcrypto.so.1.0.0 /lib/libcrypto.so
ln -sf /lib/libssl.so.1.0.0 /lib/libssl.so

while [ $retry -gt 0 ]; do
if curl -m 30 -o "$RESP" -k "$FW_URL?$params"; then
#        if curl -m 300 -o "$RESP" -k "$FW_URL"; then
                if [ -s $RESP ];then
                        echo "check f/w info OK!" >/dev/console
                        retry=0
                        local fw_info="$(cat $RESP | sed -e 's/{//g' -e 's/}//g' -e 's/"//g')"
                        echo $fw_info >$FW_INFO 
                else
                        echo "curl reponse null to check f/w info from Update Server!" >/dev/console
			retry=`awk -v a=$retry 'BEGIN{print a-1}'`
                fi
        else
                echo "fail to check f/w info from Internet Server!" >/dev/console
		retry=`awk -v a=$retry 'BEGIN{print a-1}'`
        fi
done

#rm /lib/libcrypto.so.1.0.0 -rf
rm /lib/libssl.so.1.0.0 -rf
#rm /lib/libcrypto.so -rf
rm /lib/libssl.so -rf
#mv /lib/libcrypto.so.1.0.0.lzma-1 /lib/libcrypto.so.1.0.0.lzma
mv /lib/libssl.so.1.0.0.lzma-1 /lib/libssl.so.1.0.0.lzma
mv /lib/libcurl.so.lzma-1 /lib/libcurl.so.lzma

