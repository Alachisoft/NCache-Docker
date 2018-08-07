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

	-k | --evalkey )	shift
			KEY=$1
			;;
			
	-m | --installmode )	shift
			INSTALLMODE=$1
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
sed -i "s|<DESTINATION>|$DESTINATION|g" "/app/ipbinding.sh"

# Extracting and installing NCache
tar -zxf ncache.ent.netcore.tar.gz
cd ncache-enterprise-4.9-dotnet

./install  --installmode $INSTALLMODE --evalkey $KEY --firstname $FIRST_NAME --lastname $LAST_NAME --email $EMAIL --installpath $DESTINATION --force --password $PASSWORD

# Removing installation resources
rm /app/ncache.ent.netcore.tar.gz
rm -r /app/ncache-enterprise-4.9-dotnet
rm -f /app/installncache.sh