#!/bin/sh
set -e

if [ -n "$NC_USER_PASSWORD" ]; then
    # Check if the current password already matches
    if ! echo "$NC_USER_PASSWORD" | su -c "true" ncache >/dev/null 2>&1; then
        # Validate password length
        if [ "${#NC_USER_PASSWORD}" -lt 6 ]; then
            echo "Error: NC_USER_PASSWORD must be at least 6 characters long."
            exit 1
        fi

       echo "ncache\n$NC_USER_PASSWORD\n$NC_USER_PASSWORD" | passwd ncache
        echo "Successfully updated password for user: ncache"
    fi
fi
# IP binding
if [ -e /app/ipbinding.sh ]; then
	/app/ipbinding.sh
fi

# activation
if [ -e /app/activate.sh ]; then
	/app/activate.sh
fi

# -------------------------
# START MAIN DAEMON AS PID 1
# -------------------------

/opt/ncache/bin/service/Alachisoft.NCache.ExecutionDaemon /opt/ncache &
/opt/ncache/bin/service/Alachisoft.NCache.BridgeDaemon /opt/ncache &

# TLS: waits in the background until the daemon below is listening, then enables TLS
if [ -e /app/enable-tls.sh ]; then
	bash /app/enable-tls.sh &
fi

exec /opt/ncache/bin/service/Alachisoft.NCache.Daemon /opt/ncache
