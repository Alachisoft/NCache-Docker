#!/bin/sh

if [ -e /app/ipbinding.sh ]
then
	/app/ipbinding.sh
fi

/opt/ncache/bin/service/Alachisoft.NCache.Daemon /opt/ncache/

sleep infinity
