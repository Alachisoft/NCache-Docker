#!/bin/sh
while [ "$1" != "" ]; do
    case $1 in
	-k | --installkey )	shift
			INSTALL_KEY=$1
			;;

	* )
			usage
			exit 1
    esac
    shift
done

#--- Untaring and installing NCache
tar -zxf ncache-oss.tar.gz
cd ncache-oss

./install --installkey $INSTALL_KEY

cd ..
#--- Removing installation resources
rm -f ncache-oss.tar.gz
rm -rf ncache-oss/

#--- executing the sh script to generate the stub
/app/stubgenerator.sh

#--- Updating permissions and ownership
chmod -R 775 /opt/ncache/bin/service /opt/ncache/lib
chown -R ncache:root /app
chown -R ncache:ncache /opt/ncache

#--- Adding the user to the root group
usermod -a -G root ncache

#--- Remove installer sh file, no more need from this point onwards
rm -f installncache.sh
