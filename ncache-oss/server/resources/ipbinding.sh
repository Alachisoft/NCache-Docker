#!/bin/sh
#
# ipbinding.sh - binds NCache to this container's IP address.
#
# Run once by startup.sh when the container starts, before the NCache service starts. It writes
# the container's address into the service and cache configuration, marks the installation as a
# Docker container installation, and then deletes itself so later restarts keep its changes.
#
# Environment variables (optional):
#   NC_BIND_IP    Address NCache binds to. Default: the container's first IP address.
#                 Set it when the container has more than one address (e.g. --network host).

NCACHE_HOME=/opt/ncache
NCINFO=/usr/lib/ncinfo.xml

ip="${NC_BIND_IP:-$(hostname -I | cut -d ' ' -f 1)}"

# --- Service configuration ----------------------------------------------------------------
cd "$NCACHE_HOME/bin/service" || exit 1

if [ -f Alachisoft.NCache.Daemon.dll.config ]; then
	sed -i "s/\(<add key=\"NCacheServer.BindToIP\" value=\"\)[^\"]*\(\"\/>\)/\1$ip\2/" Alachisoft.NCache.Daemon.dll.config
fi

# --- Cache configuration ------------------------------------------------------------------
# The cache configuration holds the <IP> placeholder or the address of the machine the image
# was built on; replace both with this container's address.
cd "$NCACHE_HOME/config" || exit 1

for file in *.ncconf; do
	if [ -f "$file" ]; then
		sed -i "s/<IP>/$ip/g; s/[0-9]\+\.[0-9]\+\.[0-9]\+\.[0-9]\+/$ip/g" "$file"
	fi
done

# --- Installation information -------------------------------------------------------------
# Record the installation as a Docker container (install type "dci") and clear the placeholder
# email address. The ncache user may write ncinfo.xml but cannot create files in /usr/lib, as
# sed -i would, so the result is written to a temporary file and copied back over the original.
sed -e 's|<install-type>op</install-type>|<install-type>dci</install-type>|' \
    -e 's|<email>john@yourdomain.com</email>|<email> </email>|' \
    "$NCINFO" > /tmp/ncinfo.xml.tmp && cat /tmp/ncinfo.xml.tmp > "$NCINFO"
rm -f /tmp/ncinfo.xml.tmp

# Run only once per container.
rm -f /app/ipbinding.sh
