# Setting base image for NCache.
FROM ubuntu:22.04

# Setting work directory to copy setups and resources for configuring NCache.
WORKDIR /app

# Make sure your machine has access to internet for installation of packages 
# Make sure that the folder ("resources") exist in the same directory as the Dockerfile.
# Make sure that "ipbinding.sh" script resides in the "resources" folder.
# Make sure that "installncache.sh" script resides in the "resources" folder.
# Make sure that NCache Linux setup (.tar.gz) resides in the "resources" folder. It can be downloaded from https://www.alachisoft.com/download-ncache.html.
# Copying resources and setups into the work directory of the container.
COPY resources .

# Exposing ports used by NCache for communication.
EXPOSE 8250-8260 9800 8300-8400

# Installing prerequisite ...
RUN apt-get update && apt-get install -y \
 procps \
 ed \
 apt-transport-https \
 curl \
 libicu-dev \
 && rm -rf /var/lib/apt/lists/*

# Installing NCache Linux setup (.tar.gz).
# The parameter "--firstname" represents the first name of the user.
# The parameter "--lastname" represents the last name of the user.
# The parameter "--company" Provide your company name.
# The parameter "--email" Provide your email address.
RUN  chmod -R 775 /app  \
 && ./installncache.sh --firstname "YOUR_FIRST_NAME" --lastname "YOUR_LAST_NAME" --company "YOUR_COMPANY" --email "YOUR_EMAIL" --installkey "******" --installmode "client" \
 && rm -rf /var/lib/apt/lists/*
 
# Switching the current user to ncache user
USER ncache

# Entry point for the container, once all the required configurations have been made.
ENTRYPOINT ["/app/startup.sh"]
