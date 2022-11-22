#!/bin/sh

STAGE_URL="https://www.linksyssmartwifi.com/product-service/rest/productRegistrations"

wan_mac="$(nvram_get 2860 wan_hwaddr)"
model_number="$(nvram_get 2860 model_number)"
fw_ver="$(nvram_get 2860 fw_version)"
hw_ver="$(nvram_get 2860 hw_version)"
sn="$(nvram_get 2860 get_sn)"
CountryCode="$(nvram_get 2860 CountryCode)"
sku="$model_number-$CountryCode"
reg_time="$(date +%Y-%m-%dT%TZ)"
email_addr="$(nvram_get 2860 email_addr)"
optin="$(nvram_get 2860 privacy_policy)"

if [ $model_number = "E5350" ];then
	Linksys_head="X-Cisco-HN-Client-Type-Id:CF889E89-A326-49F9-A03C-25A56ACEF9FB"
elif [ $model_number = "E5400" ];then
	Linksys_head="X-Cisco-HN-Client-Type-Id:FE3DFCBE-F255-40AB-9FC9-6696435F34C4"
else
	Linksys_head="X-Cisco-HN-Client-Type-Id:35DE691A-34E5-48E9-9531-0E66307EF770"
fi
echo $Linksys_head
Accept_head="Accept:application/json"
Content_type="Content-type:application/json;charset=UTF-8"


json_data="{\"productRegistration\":{\"serialNumber\":\"$sn\",\"modelNumber\":\"$model_number\",\"sku\":\"$sku\",\"emailAddress\":\"$email_addr\",\"optIn\":\"$optin\",\"registrationDate\":\"$reg_time\",\"hardwareVersion\":\"$hw_ver\",\"firmwareVersion\":\"$fw_ver\",\"macAddress\":\"$wan_mac\"}}"

#cp /lib/libcrypto.so.1.0.0.lzma /lib/libcrypto.so.1.0.0.lzma-1
cp /lib/libssl.so.1.0.0.lzma /lib/libssl.so.1.0.0.lzma-1

unlzma /lib/libcurl.so.lzma
#unlzma /lib/libcrypto.so.1.0.0.lzma
unlzma /lib/libssl.so.1.0.0.lzma
#ln -sf /lib/libcrypto.so.1.0.0 /lib/libcrypto.so
ln -sf /lib/libssl.so.1.0.0 /lib/libssl.so

#curl -H "X-Cisco-HN-Client-Type-Id:697DB986-9768-4F0F-9748-EC0068E157C8" -H "Accept:application/json" -H "Content-type:application/json;charset=UTF-8" -X POST -d $json_data -k "$STAGE_URL"
result=`curl -H "$Linksys_head" -H "$Accept_head" -H "$Content_type" -X POST -d $json_data -k "$STAGE_URL"`
if echo $result | grep "productRegistrationId";then
	nvram_set email_register 1
	echo "Success"
else
	nvram_set email_register 0
	echo "Fail"
fi

#rm /lib/libcrypto.so.1.0.0 -rf
rm /lib/libssl.so.1.0.0 -rf
#rm /lib/libcrypto.so -rf
rm /lib/libssl.so -rf
#mv /lib/libcrypto.so.1.0.0.lzma-1 /lib/libcrypto.so.1.0.0.lzma
mv /lib/libssl.so.1.0.0.lzma-1 /lib/libssl.so.1.0.0.lzma
