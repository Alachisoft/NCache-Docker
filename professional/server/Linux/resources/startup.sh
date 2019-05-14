#!/bin/sh

if [ -e /app/ipbinding.sh ]
then
	chmod +x /app/ipbinding.sh
	/app/ipbinding.sh
fi

service ncached start