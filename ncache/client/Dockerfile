# NCache Enterprise - client image.
#
# Build:
#   docker build -t ncache-client .
#
# The "resources" folder next to this Dockerfile must contain installncache.sh, ipbinding.sh,
# startup.sh, activate.sh and enable-tls.sh. The build machine needs internet access.

FROM mcr.microsoft.com/dotnet/runtime:10.0-noble

# Build arguments.
#   BUILD_VERSION     Optional. Version recorded in the image label.
#   BUILD_DATE        Optional. Build date recorded in the image label.
ARG BUILD_DATE
ARG BUILD_VERSION

WORKDIR /app

COPY resources .

# Ports used by NCache.
EXPOSE 9800-9999

# Prerequisites, including PowerShell for the NCache cmdlets.
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        ed \
        libicu74 \
        procps \
        tar && \
    curl -fsSL --retry 3 -o /tmp/powershell.deb \
        https://github.com/PowerShell/PowerShell/releases/download/v7.6.7/powershell_7.6.7-1.deb_amd64.deb && \
    apt-get install -y --no-install-recommends /tmp/powershell.deb && \
    rm -rf /tmp/powershell.deb /var/lib/apt/lists/*

# NCache Enterprise 5.3.800, downloaded from alachisoft.com and installed as an NCache client.
# Replace YOUR_INSTALL_KEY with the installation key provided by alachisoft.com.
# --install_mode selects the edition: client (default), server or developer.
RUN curl -fsSL --retry 3 -o ncache-enterprise.tar.gz \
        https://download.alachisoft.com/ncache/ncache-5.3.800.tar.gz && \
    chmod -R 775 /app && \
    ./installncache.sh --key "YOUR_INSTALL_KEY" --install_mode "client" && \
    chmod u+s /usr/sbin/chpasswd && \
    apt-get autoremove -y && \
    rm -rf /opt/ncache/lib/license ncache-enterprise.tar.gz

LABEL org.label-schema.name="NCache Enterprise Client" \
      org.label-schema.version=$BUILD_VERSION \
      org.label-schema.description="NCache: Highly Scalable Distributed Cache for .NET" \
      org.label-schema.vendor="Alachisoft" \
      org.label-schema.url="https://www.alachisoft.com/ncache/" \
      org.label-schema.maintainer="support@alachisoft.com" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.schema-version="1.0"

# TLS, applied by enable-tls.sh once the NCache service is running.
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

USER ncache

# Binds NCache to the container's address, activates it, then starts the NCache service.
ENTRYPOINT ["/app/startup.sh"]
