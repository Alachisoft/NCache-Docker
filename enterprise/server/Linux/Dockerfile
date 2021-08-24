# Setting base image for NCache.
FROM mcr.microsoft.com/dotnet/sdk:3.1
# BUILD TIME ARGUMENTS
ARG BUILD_DATE 
ARG BUILD_VERSION
ARG SETUP_HTTP_PATH

# Setting work directory to copy setups and resources for configuring NCache.
WORKDIR /app

# Make sure your machine has access to internet for installation of packages 
# Installing package procps (Prerequisite of NCache services). 
# Make sure that the folder ("resources") exist in the same directory as the Dockerfile.
# Make sure that "ipbinding.sh" script resides in the "resources" folder.
# Make sure that "installncache.sh" script resides in the "resources" folder.
# Make sure that NCache Linux setup (.tar.gz) resides in the "resources" folder. It can be downloaded from https://www.alachisoft.com/download-ncache.html.
# Copying resources and setups into the work directory of the container.
COPY resources .

# Exposing ports used by NCache for communication.
EXPOSE 8250-8260 9800 7800-7850 8300-8350 9900 10000-10010

# Installing NCache Linux setup (.tar.gz).
# The parameter "--firstname" represents the first name of the user.
# The parameter "--lastname" represents the last name of the user.
# The parameter "--company" represents the first name of the user's compamy.
# The parameter "--email" represents the email of the user against which the evaluation key is register.
# The parameter "--evalkey" represents the evaluation key of the ncache.
# The parameter "--installpath" represents the path where you want to install ncache.
RUN apt-get update \
 && apt-get install -y procps ed apt-transport-https openjdk-11-jre-headless \
 && curl -SL --output ncache-enterprise.tar.gz $SETUP_HTTP_PATH \
 && ./installncache.sh --firstname "Enterprise" --lastname "Server" --company "yourcompany" --email "abc@yourdomain.com" --evalkey "xxxxxxxx" --installpath /opt  --installmode 0

# LABELING IMAGE
LABEL org.label-schema.name="NCache Enterprise" \
 org.label-schema.version=$BUILD_VERSION \
 org.label-schema.description="NCache: Highly Scalable Distributed Cache for .NET" \
 org.label-schema.vendor="Alachisoft" \
 org.label-schema.url="https://www.alachisoft.com/ncache/" \
 org.label-schema.maintainer="support@alachisoft.com" \
 org.label-schema.build-date=$BUILD_DATE \
 org.label-schema.schema-version="1.0"

# Switching the current user to ncache user
USER ncache

# Entry point for the container, once all the required configurations have been made.
ENTRYPOINT ["/app/startup.sh"]