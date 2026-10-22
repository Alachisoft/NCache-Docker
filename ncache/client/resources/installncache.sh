#!/bin/sh
#
# installncache.sh - installs NCache Enterprise inside the image.
#
# Run once by the Dockerfile at build time, from /app, after ncache-enterprise.tar.gz has been
# downloaded there. Deletes the setup files and itself when done.
#
# Usage:
#   ./installncache.sh --key <key> [options]
#
# Options:
#   -k, --key <key>             Installation key provided by alachisoft.com. Required.
#   -m, --install_mode <mode>   Edition to install: client (default), server or developer.
#   -p, --install_dir <dir>     Accepted for compatibility; NCache is installed under /opt.
#   -i, --bind_to_ip <ip>       Accepted for compatibility; the address is set at container start.
#   -v, --verbose               Accepted for compatibility.
#   -h, --help                  Shows this help.

usage() {
	sed -n 's/^# \{0,1\}//; 8,17p' "$0" >&2
}

while [ "$1" != "" ]; do
	case $1 in
		-i | --bind_to_ip )
			shift
			IP=$1
			;;
		-p | --install_dir )
			shift
			DESTINATION=$1
			;;
		-k | --key )
			shift
			INSTALL_KEY=$1
			;;
		-m | --install_mode )
			shift
			INSTALL_MODE=$1
			;;
		-v | --verbose )
			VERBOSE="true"
			;;
		-h | --help )
			usage
			exit
			;;
		* )
			usage
			exit 1
			;;
	esac
	shift
done

DESTINATION="${DESTINATION:-/opt}"
INSTALL_MODE="${INSTALL_MODE:-client}"
PASSWORD="${PASSWORD:-ncache}"

# --- Install ------------------------------------------------------------------------------
tar -zxf ncache-enterprise.tar.gz || { echo "Error: cannot extract ncache-enterprise.tar.gz" >&2; exit 1; }
cd ncache-enterprise || exit 1

./install --key $INSTALL_KEY -m $INSTALL_MODE -P $PASSWORD -t true || { echo "Error: NCache installation failed" >&2; exit 1; }

cd ..
rm -f ncache-enterprise.tar.gz
rm -rf ncache-enterprise/

# --- Permissions --------------------------------------------------------------------------
# The container runs as the ncache user, which owns the installation and the /app scripts.
chmod -R 775 /opt/ncache/bin/management /opt/ncache/bin/service /opt/ncache/lib
chown -R ncache:root /app
chown -R ncache:ncache /opt/ncache

usermod -a -G root ncache

# The installer is not needed after the build.
rm -f /app/installncache.sh
