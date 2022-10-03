#!/bin/sh

ip="$(hostname -i)"
DESTINATION=/opt

cd $DESTINATION/ncache/bin/service

printf "%s\n" ",s/<IP>/$ip/g" wq | ed -s Alachisoft.NCache.Daemon.dll.config

cd $DESTINATION/ncache/config

printf "%s\n" ",s/<IP>/$ip/g" wq | ed -s client.ncconf
printf "%s\n" ",s/<IP>/$ip/g" wq | ed -s config.ncconf 

