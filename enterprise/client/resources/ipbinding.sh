#!/bin/sh

# NC_BIND_IP picks the address when the container sees several (e.g. --network host).
ip="${NC_BIND_IP:-$(hostname -I | cut -d ' ' -f 1)}"

DESTINATION=/opt
cd $DESTINATION/ncache/bin/service


sed -i "s/\(<add key=\"NCacheServer.BindToClusterIP\" value=\"\)[^\"]*\(\"\/>\)/\1$ip\2/" "Alachisoft.NCache.Daemon.dll.config"

sed -i "s/\(<add key=\"NCacheServer.BindToClientServerIP\" value=\"\)[^\"]*\(\"\/>\)/\1$ip\2/" "Alachisoft.NCache.Daemon.dll.config"

sed -i "s/\(<add key=\"LoaderIP\" value=\"\)[^\"]*\(\"\/>\)/\1$ip\2/" "Alachisoft.NCache.ExecutionDaemon.dll.config"

cd $DESTINATION/ncache/config

sed -i "s/[0-9]\+\.[0-9]\+\.[0-9]\+\.[0-9]\+/$ip/g" *.ncconf

# Clear any email baked into the image. Kept as its own ed call: ed aborts the whole script
# without writing when a substitution has no match, which must not block the install-type edit.
printf '%s\n' ',s|<email>[^<]*</email>|<email></email>|g' wq | ed -s /usr/lib/ncinfo.xml 2>/dev/null

if [ -z "${NC_INSTALL_TYPE:-}" ]; then
	printf '%s\n' ',s|<install-type>op<\/install-type>|<install-type>dci<\/install-type>|' wq | ed -s /usr/lib/ncinfo.xml
else
	printf '%s\n' ",s|<install-type>op<\/install-type>|<install-type>${NC_INSTALL_TYPE}s<\/install-type>|" wq | ed -s /usr/lib/ncinfo.xml
fi

rm -f /app/ipbinding.sh