#!/bin/sh

ip="$(hostname -I | cut -d ' ' -f 1)"

DESTINATION=/opt/ncache
cd $DESTINATION/bin/service || exit 1

# Update Daemon config if it exists
if [ -f "Alachisoft.NCache.Daemon.dll.config" ]; then
  sed -i "s/\(<add key=\"NCacheServer.BindToIP\" value=\"\)[^\"]*\(\"\/>\)/\1$ip\2/" Alachisoft.NCache.Daemon.dll.config
fi


cd $DESTINATION/config || exit 1


# Replace any IP inside ncconf files
for file in *.ncconf; do
  if [ -f "$file" ]; then
    sed -i "s/<IP>/$ip/g; s/[0-9]\+\.[0-9]\+\.[0-9]\+\.[0-9]\+/$ip/g" "$file"
  fi
done


# Mark the install as the docker image (drives console logging and licensing) and blank the template's
# placeholder email. The file is writable by the ncache user but /usr/lib is not, so rewrite the file in
# place instead of using sed -i (which needs to create a temp file next to it). Silent, unlike the ed
# edits it replaces.
sed -e 's|<install-type>op</install-type>|<install-type>dci</install-type>|' \
    -e 's|<email>john@yourdomain.com</email>|<email> </email>|' \
    /usr/lib/ncinfo.xml > /tmp/ncinfo.xml.tmp && cat /tmp/ncinfo.xml.tmp > /usr/lib/ncinfo.xml
rm -f /tmp/ncinfo.xml.tmp

# Remove script after execution

rm -f /app/ipbinding.sh