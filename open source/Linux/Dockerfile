# Setting base image for NCache.
FROM microsoft/dotnet:2.2-runtime

# Setting the enviornment variable so the NCache install script knows that it's running inside a container
ENV container ncachedocker

# Setting work directory to copy setups and resources for configuring NCache.
WORKDIR /app

# Make sure that the 2 folders ("resources" and "setup") exist in the same directory as the Dockerfile.
# Make sure that "ipbinding.sh" script resides in the "resources" folder.
# Make sure that "installncache.sh" script resides in the "setup" folder.
# Make sure that NCache Linux setup (.tar.gz) resides in the "setup" folder. It can be downloaded from http://www.alachisoft.com/download-ncache.html.
# Copying resources and setups into the work directory of the container.
COPY resources .
COPY setup .

# Exposing ports used by NCache for communication.
# Exposing the port at which Ncache service will listen for the incoming client connection requests.
EXPOSE 9800

# Exposing the port at which Ncache service will listen for the incoming management connection requests (NCache Manager, Monitor and Tools).
EXPOSE 8250

# Make sure your machine has access to internet for installation of packages 
# Installing package procps (Prerequisite of NCache services). 
RUN apt-get update &&\
    apt-get install procps -y 

# Installing NCache Linux setup (.tar.gz).
# The parameter "--firstname" represents the first name of the user.
# The parameter "--lastname" represents the last name of the user.
# The parameter "--email" represents the e-mail address of the user.
# The parameter "--installpath" represents the path where ncache will be installed. If not provided then /opt/ncache will be used.
# The parameter "--force"  Force create destination directory if provided directory does not exist.
# The parameter "--password" represents the password for user ncache.

RUN chmod +x installncache.sh &&\
    ./installncache.sh --firstname "John" --lastname "Smith" --email "john@alachisoft.com" --installpath /opt --force --password ncache

# Currently, the IP during NCache installation is stored in the configuration files and it can not be made static at that point.
# However, the IP can be made static once the container is started.
# When the container instance is first started the startup script calls ipbinding.sh which replaces the IP with the actual IP assigned to the container and deletes itself.
# Furthermore the startup.sh script starts ncached, ncacheloaderd and ncachebridged daemon services
# Making startup.sh executable
RUN chmod +x /app/startup.sh

# Entry point for the container, once all the required configurations have been made.
ENTRYPOINT /app/startup.sh && bash