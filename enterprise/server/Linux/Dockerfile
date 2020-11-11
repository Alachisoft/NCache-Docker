# Setting base image for NCache.
FROM mcr.microsoft.com/dotnet/core/runtime:3.0

# Setting the enviornment variable so the NCache install script knows that it's running inside a container.
ENV container ncachedocker

# Setting work directory to copy setups and resources for configuring NCache.
WORKDIR /app

# Make sure that the folder ("resources") exist in the same directory as the Dockerfile.
# Make sure that "ipbinding.sh" script resides in the "resources" folder.
# Make sure that "startup.sh" script resides in the "resources" folder.
# Make sure that "installncache.sh" script resides in the "resources" folder.
# Make sure that NCache Linux setup (.tar.gz) resides in the "resources" folder. It can be downloaded from http://www.alachisoft.com/download-ncache.html.
# Copying resources and setups into the work directory of the container.
COPY resources .

# Exposing ports used by NCache for communication.
EXPOSE 8250 8251 9800 7800-7900 8300-8400 8260 10000-10100

# Make sure your machine has access to internet for installation of packages.
# Installing package procps and powershell (Prerequisite of NCache services). 
RUN curl --output packages-microsoft-prod.deb https://packages.microsoft.com/config/debian/10/packages-microsoft-prod.deb \
 && dpkg -i packages-microsoft-prod.deb \
 && apt-get update \
 && apt-get install -y powershell procps ed  \
  && rm packages-microsoft-prod.deb


# Installing NCache Linux setup (.tar.gz).
# The parameter "--evalkey" is the install key and is sent to user through e-mail once they download NCache setup. In case if user does not get a key, contact us at http://www.alachisoft.com/company/contact-us.html.
# The parameter "--firstname" represents the first name of the user.
# The parameter "--lastname" represents the last name of the user.
# The parameter "--email" represents the e-mail address of the user.
# The parameter "--installpath" represents the path where ncache will be installed. If not provided then /opt/ncache will be used.
# The parameter "--force"  Force create destination directory if provided directory does not exist.
# The parameter "--password" represents the password for user ncache.
# The parameter "--installmode" represents the NCache installation mode and has the following values:
#		Enterprise Server Install mode = "0"
#		Enterprise Remote Client Install mode = "3"
RUN chmod -R 775 /app &&\
    ./installncache.sh --firstname "abc" --lastname "xyz" --email "abc@yourdomain.com" --company "yourcompany" --evalkey "xxxxxxxx" --installpath /opt --force --password "xxxxxxxx" --installmode 0 

# Entry point for the container, once all the required configurations have been made.
ENTRYPOINT ["/app/startup.sh"]