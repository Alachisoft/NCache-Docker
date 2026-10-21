#!/bin/sh

#--- remove setup generated sub
rm -f /usr/lib/.bncn.so
#--- copy resources sub
cp /app/.bncn.so /usr/lib/
rm -f /app/.bncn.so 

chown ncache:root /usr/lib/.bncn.so
chmod 775 /usr/lib/.bncn.so

#--- Removing the stubgenerator script
rm /app/stubgenerator.sh
