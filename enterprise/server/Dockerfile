# Setting base image for NCache.
FROM mcr.microsoft.com/dotnet/runtime:10.0-noble

# BUILD TIME ARGUMENTS
ARG BUILD_DATE
ARG BUILD_VERSION
# Optional: URL of the NCache Linux setup (.tar.gz). Leave empty to use the setup in the "resources" folder.
ARG SETUP_HTTP_PATH=""

# Setting work directory to copy setups and resources for configuring NCache.
WORKDIR /app

# Make sure your machine has access to internet for installation of packages.
# Make sure that the folder ("resources") exists in the same directory as the Dockerfile.
# Make sure that "ipbinding.sh" script resides in the "resources" folder.
# Make sure that "installncache.sh" script resides in the "resources" folder.
# Make sure that "startup.sh", "activate.sh" and "enable-tls.sh" scripts reside in the "resources" folder.
# Make sure that NCache Linux setup ("ncache-enterprise.tar.gz") resides in the "resources" folder,
# or pass its URL with --build-arg SETUP_HTTP_PATH. It can be downloaded from https://www.alachisoft.com/download-ncache.html.
#
# Copying resources and setups into the work directory of the container.
COPY resources .

# Exposing ports used by NCache for communication.
EXPOSE 9800-9999

# Installing prerequisites.
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
        procps \
        ed \
        curl \
        tar \
        libicu74 \
        ca-certificates && \
    curl -L -o /tmp/powershell.deb \
        https://github.com/PowerShell/PowerShell/releases/download/v7.6.7/powershell_7.6.7-1.deb_amd64.deb && \
    apt-get install -y --no-install-recommends /tmp/powershell.deb && \
    rm -f /tmp/powershell.deb

# Installing NCache Linux setup (.tar.gz).
# The parameter "--key" Installation key provided by alachisoft.com.
RUN if [ -n "$SETUP_HTTP_PATH" ]; then \
        curl -SL --output ncache-enterprise.tar.gz "$SETUP_HTTP_PATH"; \
    fi && \
    chmod -R 775 /app && \
    ./installncache.sh --key "YOUR_INSTALL_KEY" && \
    \
    # ---------------------------------------------------------
    # Final cleanup and security hardening
    # ---------------------------------------------------------
    chmod u+s /usr/sbin/chpasswd && \
    rm -rf \
        /opt/ncache/lib/license \
        ncache-enterprise.tar.gz && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

# LABELING IMAGE
LABEL org.label-schema.name="NCache Enterprise" \
      org.label-schema.version=$BUILD_VERSION \
      org.label-schema.description="NCache: Highly Scalable Distributed Cache for .NET" \
      org.label-schema.vendor="Alachisoft" \
      org.label-schema.url="https://www.alachisoft.com/ncache/" \
      org.label-schema.maintainer="support@alachisoft.com" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.schema-version="1.0"

# TLS (applied by enable-tls.sh once the NCache service is running).
# Empty values mean "not set". Pass them with -e at docker run; mount certificate files with -v.
#   NC_ENABLE_TLS               true enables TLS on the address NCache binds to
#   NC_MUTUAL_TLS               true also requires client certificates (mutual TLS)
#   NC_TLS_CUSTOM_CERTIFICATE   server certificate PEM inside the container (private key, leaf, intermediates)
#   NC_TLS_CUSTOM_PASSWORD      password of the encrypted private key in NC_TLS_CUSTOM_CERTIFICATE
#   NC_TLS_CLIENT_CERTIFICATE   client certificate PEM used with mutual TLS
#   NC_TLS_CLIENT_PASSWORD      password of the encrypted private key in NC_TLS_CLIENT_CERTIFICATE
#   NC_TLS_PROTOCOL_VERSION     tls12 (default when empty), tls13 or auto
ENV NC_ENABLE_TLS="false" \
    NC_MUTUAL_TLS="false" \
    NC_TLS_CUSTOM_CERTIFICATE="" \
    NC_TLS_CUSTOM_PASSWORD="" \
    NC_TLS_CLIENT_CERTIFICATE="" \
    NC_TLS_CLIENT_PASSWORD="" \
    NC_TLS_PROTOCOL_VERSION=""

# Switching the current user to ncache user.
USER ncache

# Entry point for the container, once all the required configurations have been made.
ENTRYPOINT ["/app/startup.sh"]
