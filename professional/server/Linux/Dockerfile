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
EXPOSE 8250-8260 9800 7800-7900 8300-8400

# Installing NCache Linux setup (.tar.gz).
# The parameter "--firstname" represents the first name of the user.
# The parameter "--lastname" represents the last name of the user.
#curl --output ncache-Professional.tar.gz path of the setup \
RUN apt-get update \
 && apt-get install -y procps ed  \
 && curl -SL --output ncache-professional.tar.gz $SETUP_HTTP_PATH \
 && ./installncache.sh --firstname "Professional" --lastname "Server" --company "ComapanyName"

# LABELING IMAGE
#LABEL org.label-schema.name="NCache Professional" \
 #org.label-schema.version=$BUILD_VERSION \
 #org.label-schema.description="NCache: Highly Scalable Distributed Cache for .NET" \
 #org.label-schema.vendor="Alachisoft" \
 #org.label-schema.url="https://www.alachisoft.com/ncache/" \
 #org.label-schema.maintainer="support@alachisoft.com" \
 #org.label-schema.build-date=$BUILD_DATE \
 #org.label-schema.schema-version="1.0"

# Switching the current user to ncache user
USER ncache

# Entry point for the container, once all the required configurations have been made.
ENTRYPOINT ["/app/startup.sh"]
