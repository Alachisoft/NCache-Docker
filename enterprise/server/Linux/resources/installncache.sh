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
	-e | --email )	shift
			EMAIL=$1
			;;
	-c | --company )	shift
			COMPANY=$1
			;;
	-k | --evalkey )	shift
			KEY=$1
			;;
			
	-m | --installmode )	shift
			INSTALLMODE=$1
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
#--- Untaring and installing NCache
tar -zxf ncache-enterprise.tar.gz
cd ncache-enterprise
./install --firstname $FIRST_NAME --lastname $LAST_NAME --company $COMPANY  --email $EMAIL --evalkey $KEY --installpath $DESTINATION --installmode $INSTALLMODE --java_home /usr/lib/jvm/java-11-openjdk-amd64/ 
cd ..
#--- Removing installation resources
rm -f ncache-enterprise.tar.gz
rm -rf ncache-enterprise/
#--- creating the directory for the user to solve the ps logging issue
mkdir /home/ncache
#--- Updating permissions and ownership
chmod -R 775 /home/ncache /opt/ncache/bin/tools/web /opt/ncache/bin/service /opt/ncache/libexec 
chown -R ncache:root /app /opt/ncache /home/ncache
#--- Adding the user to the root group
usermod -a -G root ncache
#--- Remove installer sh file, no more need from this point onwards
rm -f installncache.sh