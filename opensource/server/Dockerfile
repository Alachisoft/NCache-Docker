# Setting base image for NCache.
FROM ubuntu:22.04

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
# Copying resources and setups into the work directory of the container.
COPY resources .

# Exposing ports used by NCache for communication.
EXPOSE 9800-9999

# Installing NCache Linux setup (.tar.gz).
RUN apt update && apt install -y \
 procps \
 ed \
 apt-transport-https \
 curl \
 libicu70 \
 && rm -rf /var/lib/apt/lists/*

# Use the 4GB install key in the Dockerfile, as this is the default cache size for the Open Source edition.
RUN curl -SL --output ncache-oss.tar.gz $SETUP_HTTP_PATH \
 && ./installncache.sh --installkey "YOUR_INSTALL_KEY" \
 && rm -rf /var/lib/apt/lists/* && \
    rm -rf /opt/ncache/lib/license \*

# LABELING IMAGE
LABEL org.label-schema.name="NCache Opensource" \
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
