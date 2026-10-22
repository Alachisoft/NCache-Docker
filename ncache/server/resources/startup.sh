#!/bin/sh
#
# startup.sh - entry point of the NCache Enterprise server container.
#
# 1. Sets the ncache user's password when NC_USER_PASSWORD is given (at least 6 characters).
# 2. Binds NCache to the container's address on the first start (ipbinding.sh).
# 3. Activates NCache when activation details are given (activate.sh).
# 4. Starts the execution and bridge services, enables TLS in the background when requested
#    (enable-tls.sh), and runs the NCache service as the container's main process.
set -e

# --- Password -----------------------------------------------------------------------------
if [ -n "$NC_USER_PASSWORD" ]; then
	# Change the password only when it differs from the current one.
	if ! echo "$NC_USER_PASSWORD" | su -c "true" ncache >/dev/null 2>&1; then
		if [ "${#NC_USER_PASSWORD}" -lt 6 ]; then
			echo "Error: NC_USER_PASSWORD must be at least 6 characters long."
			exit 1
		fi

		echo "ncache\n$NC_USER_PASSWORD\n$NC_USER_PASSWORD" | passwd ncache
		echo "Successfully updated password for user: ncache"
	fi
fi

# --- IP binding ---------------------------------------------------------------------------
if [ -e /app/ipbinding.sh ]; then
	/app/ipbinding.sh
fi

# --- Activation ---------------------------------------------------------------------------
if [ -e /app/activate.sh ]; then
	/app/activate.sh
fi

# --- Services -----------------------------------------------------------------------------
/opt/ncache/bin/service/Alachisoft.NCache.ExecutionDaemon /opt/ncache &
/opt/ncache/bin/service/Alachisoft.NCache.BridgeDaemon /opt/ncache &

# Waits in the background until the NCache service is listening, then enables TLS.
if [ -e /app/enable-tls.sh ]; then
	bash /app/enable-tls.sh &
fi

# The NCache service replaces this script as the container's main process (PID 1), so it
# receives the stop signal from docker stop.
exec /opt/ncache/bin/service/Alachisoft.NCache.Daemon /opt/ncache
