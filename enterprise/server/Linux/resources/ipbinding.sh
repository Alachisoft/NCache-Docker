#!/bin/sh

ip="$(hostname -i)"
DESTINATION=<DESTINATION>

cd $DESTINATION/ncache/bin/service

sed -i "s/<IP>/$ip/g" "Alachisoft.NCache.Daemon.dll.config"
sed -i "s/<IP>/$ip/g" "Alachisoft.NCache.BridgeDaemon.dll.config"
sed -i "s/<IP>/$ip/g" "Alachisoft.NCache.LoaderDaemon.dll.config"

cd $DESTINATION/ncache/config

sed -i "s/<IP>/$ip/g" "bridge.ncconf"
sed -i "s/<IP>/$ip/g" "client.ncconf"
sed -i "s/<IP>/$ip/g" "config.ncconf"

rm -f /app/ipbinding.sh