#!/bin/sh
#
# stubgenerator.sh - installs the NCache runtime library shipped with the image.
#
# Run once by installncache.sh at build time. Replaces the library the setup generated in
# /usr/lib with the one in the resources folder, then deletes itself.

rm -f /usr/lib/.bncn.so
cp /app/.bncn.so /usr/lib/
rm -f /app/.bncn.so

chown ncache:root /usr/lib/.bncn.so
chmod 775 /usr/lib/.bncn.so

rm /app/stubgenerator.sh
