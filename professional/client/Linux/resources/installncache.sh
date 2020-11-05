#!/bin/sh
while [ "$1" != "" ]; do
    case $1 in
	-d | --dotnethome )	shift
			DOTNETHOME=$1
			;;
				
	-i | --ipaddress )	shift
			IP=$1
			;;

	-p | --installpath )	shift
			DESTINATION=$1
			;;	

	-f | --firstname )	shift
			FIRST_NAME=$1
			;;

	-l | --lastname )	shift
			LAST_NAME=$1
			;;

	-e | --email )		shift
			EMAIL=$1
			;;

	-c | --company )	shift
			COMPANY=$1
			;;

	-k | --evalkey )	shift
			KEY=$1
			;;
			
			
	-P | --password )	shift
			PASSWORD=$1
			NEWPASS="true"
			;;

	-F | --force )
			FORCE="true"
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
    esac
    shift
done


if [ -z $DESTINATION ]
then 
	DESTINATION="/opt"
fi

if [ -z $PASSWORD ]
then
	PASSWORD="ncache"
fi

# Setting ncache install directory
printf "%s\n" ",s|<DESTINATION>|$DESTINATION|g" wq | ed -s ipbinding.sh

# Untaring and installing NCache
tar -zxf ncache.pro.netcore.tar.gz
cd ncache5.0.4-professional-dotnet

./install --firstname $FIRST_NAME --lastname $LAST_NAME --email $EMAIL --company $COMPANY --installpath $DESTINATION --force --password $PASSWORD

# Updating permissions and ownership
chmod -R 775 /opt/ncache/bin/tools/web /opt/ncache/bin/service
chown -R ncache:root /app /opt/ncache
usermod -a -G root ncache

cd ..
# Removing installation resources
rm ncache.pro.netcore.tar.gz
rm -r ncache5.0.4-professional-dotnet/
rm -f installncache.sh
