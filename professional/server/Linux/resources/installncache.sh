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

	-c | --company )	shift
			COMPANY=$1
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
tar -zxf ncache-professional.tar.gz
cd ncache-professional

sh ./install --firstname $FIRST_NAME --lastname $LAST_NAME --email abc@abc.com --company $COMPANY --evalkey evalkey

cd ..
#--- Removing installation resources
rm -f ncache-professional.tar.gz
rm -rf ncache-professional/

#--- creating the directory for the user to solve the ps logging issue
mkdir /home/ncache

#--- Adding the user to the root group
usermod -a -G root ncache

#--- Updating permissions and ownership
chmod -R 775 /home/ncache /opt/ncache/bin/tools/web /opt/ncache/bin/service /opt/ncache/libexec 
chown  ncache:root /app/ipbinding.sh 
chown  ncache:root /app/startup.sh 
chown -R ncache:root /home/ncache


#--- Remove installer sh file, no more need from this point onwards
rm -f installncache.sh
