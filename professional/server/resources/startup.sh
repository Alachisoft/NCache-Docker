#!/bin/sh

if [ -e /app/ipbinding.sh ]
then
	/app/ipbinding.sh
fi

/usr/share/dotnet/dotnet /opt/ncache/bin/service/Alachisoft.NCache.Daemon.dll /opt/ncache

if [ -e /app/activate.sh ]
then
    /app/activate.sh
fi

sleep infinity
