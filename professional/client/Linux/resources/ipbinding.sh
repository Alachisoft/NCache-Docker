#!/bin/sh

ip="$(hostname -I | cut -d ' ' -f 1)"
DESTINATION=/opt

cd $DESTINATION/ncache/bin/service

printf "%s\n" ",s/<IP>/$ip/g" wq | ed -s Alachisoft.NCache.Daemon.dll.config

cd $DESTINATION/ncache/config

printf "%s\n" ",s/<IP>/$ip/g" wq | ed -s client.ncconf
printf "%s\n" ",s/<IP>/$ip/g" wq | ed -s config.ncconf 

rm -f /app/ipbinding.sh
