#!/bin/sh
#
# installncache.sh - installs NCache Open Source inside the image.
#
# Run once by the Dockerfile at build time, from /app, after ncache-oss.tar.gz has been downloaded
# there. Deletes the setup files and itself when done.
#
# Usage:
#   ./installncache.sh --installkey <key>
#
# Options:
#   -k, --installkey <key>   Installation key for NCache Open Source.

usage() {
	echo "Usage: $0 --installkey <key>" >&2
}

while [ "$1" != "" ]; do
	case $1 in
		-k | --installkey )
			shift
			INSTALL_KEY=$1
			;;
		* )
			usage
			exit 1
			;;
	esac
	shift
done

# --- Install ------------------------------------------------------------------------------
tar -zxf ncache-oss.tar.gz
cd ncache-oss

./install --installkey $INSTALL_KEY

cd ..
rm -f ncache-oss.tar.gz
rm -rf ncache-oss/

# --- Runtime library ----------------------------------------------------------------------
/app/stubgenerator.sh

# --- Permissions --------------------------------------------------------------------------
# The container runs as the ncache user, which owns the installation and the /app scripts.
chmod -R 775 /opt/ncache/bin/service /opt/ncache/lib
chown -R ncache:root /app
chown -R ncache:ncache /opt/ncache

usermod -a -G root ncache

# The installer is not needed after the build.
rm -f /app/installncache.sh
