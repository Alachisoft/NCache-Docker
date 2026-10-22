#!/bin/sh
#
# startup.sh - entry point of the NCache Open Source container.
#
# Binds NCache to the container's address on the first start (ipbinding.sh), then starts the
# NCache service. The service runs in the background, so the script then waits for ever to keep
# the container running.

if [ -e /app/ipbinding.sh ]; then
	/app/ipbinding.sh
fi

/opt/ncache/bin/service/Alachisoft.NCache.Daemon /opt/ncache/

sleep infinity
