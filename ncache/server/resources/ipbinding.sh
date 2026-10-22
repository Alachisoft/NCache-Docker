#!/bin/sh
#
# ipbinding.sh - binds NCache to this container's IP address.
#
# Run once by startup.sh when the container starts, before the NCache services start. It writes
# the container's address into the service and cache configuration, records the installation
# type, and then deletes itself so later restarts keep its changes.
#
# Environment variables (optional):
#   NC_BIND_IP        Address NCache binds to. Default: the container's first IP address.
#                     Set it when the container has more than one address (e.g. --network host).
#   NC_INSTALL_TYPE   Installation type recorded in ncinfo.xml. Default: dci (Docker container).

NCACHE_HOME=/opt/ncache
NCINFO=/usr/lib/ncinfo.xml

ip="${NC_BIND_IP:-$(hostname -I | cut -d ' ' -f 1)}"

# Sets <add key="KEY" value="..."/> in a service configuration file to the bind address.
set_bind_address() {
	sed -i "s/\(<add key=\"$2\" value=\"\)[^\"]*\(\"\/>\)/\1$ip\2/" "$NCACHE_HOME/bin/service/$1"
}

# --- Service configuration ----------------------------------------------------------------
set_bind_address Alachisoft.NCache.Daemon.dll.config          NCacheServer.BindToClusterIP
set_bind_address Alachisoft.NCache.Daemon.dll.config          NCacheServer.BindToClientServerIP
set_bind_address Alachisoft.NCache.BridgeDaemon.dll.config    NBridgeServer.BindToIP
set_bind_address Alachisoft.NCache.ExecutionDaemon.dll.config LoaderIP

# --- Cache configuration ------------------------------------------------------------------
# Addresses in the cache configuration belong to the machine the image was built on; replace
# them with this container's address.
sed -i "s/[0-9]\+\.[0-9]\+\.[0-9]\+\.[0-9]\+/$ip/g" "$NCACHE_HOME"/config/*.ncconf

# --- Installation information -------------------------------------------------------------
# Each edit is a separate ed call: ed discards all of its edits when one substitution finds no
# match, and the email may already be empty.

# Clear any email address left in the image by the build.
printf '%s\n' ',s|<email>[^<]*</email>|<email></email>|g' wq | ed -s "$NCINFO" 2>/dev/null

# Record the installation type.
if [ -z "${NC_INSTALL_TYPE:-}" ]; then
	printf '%s\n' ',s|<install-type>op<\/install-type>|<install-type>dci<\/install-type>|' wq | ed -s "$NCINFO"
else
	printf '%s\n' ",s|<install-type>op<\/install-type>|<install-type>${NC_INSTALL_TYPE}s<\/install-type>|" wq | ed -s "$NCINFO"
fi

# Run only once per container.
rm -f /app/ipbinding.sh
