#!/bin/sh

if [ -e /app/ipbinding.sh ]
then
	/app/ipbinding.sh
fi

/opt/ncache/bin/service/Alachisoft.NCache.Daemon /opt/ncache/
/opt/ncache/bin/service/Alachisoft.NCache.BridgeDaemon /opt/ncache/
/opt/ncache/bin/service/Alachisoft.NCache.ExecutionDaemon /opt/ncache/

sleep infinity
