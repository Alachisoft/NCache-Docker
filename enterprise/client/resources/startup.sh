#!/bin/sh

if [ -e /app/ipbinding.sh ]
then
	/app/ipbinding.sh
fi

/opt/ncache/bin/service/Alachisoft.NCache.Daemon /opt/ncache/

if [ -e /app/activate.sh ]
then
    /app/activate.sh
fi

sleep infinity
