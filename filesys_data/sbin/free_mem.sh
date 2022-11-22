#!/bin/sh
rm /lib/*.lzma -rf
rm /lib/libzebra-0.9.28.so* -rf
rm /lib/libcrypto.so.1.0.0* -rf
rm /lib/libssl.so.1.0.0* -rf
rm /lib/modules/ -rf
rm /lib/libpcre-0.9.28.so* -rf
rm /lib/libdhcp.so* -rf
rm /lib/libfl-0.9.28.so* -rf
rm /lib/libpcre-0.9.28.so* -rf
rm /usr/sbin/traceroute -rf
rm /usr/sbin/pppd -rf
rm /usr/sbin/ping6 -rf
rm /usr/sbin/pptp -rf
rm /usr/sbin/cesmDNS -rf
rm /usr/sbin/tftpd -rf

rm /bin/openssl* -rf
rm /bin/tc -rf
rm /bin/ripd -rf
rm /bin/httpd -rf
rm /bin/iptables -rf
rm /bin/dnsmasq -rf
rm /bin/ip -rf
rm /bin/zebra -rf
rm /bin/mft_cli -rf
rm /bin/ip6tables -rf

rm /sbin/dhcpd -rf
rm /sbin/dhclient -rf
rm /sbin/dhcp6s -rf
rm /sbin/wfa_ca -rf
rm /sbin/dhcp6c -rf

cp /etc_ro/pubkey /home/
rm /etc_ro/* -rf
mv /home/pubkey /etc_ro/

echo 3 > /proc/sys/vm/drop_caches
