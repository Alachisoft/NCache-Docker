# NCache Open Source - server image.
#
# Build:
#   docker build -t ncache-oss .
#
# The "resources" folder next to this Dockerfile must contain installncache.sh, ipbinding.sh,
# startup.sh, stubgenerator.sh and .bncn.so. The build machine needs internet access.

FROM ubuntu:22.04

# Build arguments.
#   BUILD_VERSION     Optional. Version recorded in the image label.
#   BUILD_DATE        Optional. Build date recorded in the image label.
ARG BUILD_DATE
ARG BUILD_VERSION

WORKDIR /app

COPY resources .

# Ports used by NCache.
EXPOSE 9800-9999

# Prerequisites.
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
        apt-transport-https \
        ca-certificates \
        curl \
        ed \
        libicu70 \
        procps && \
    rm -rf /var/lib/apt/lists/*

# NCache Open Source 5.3.603, downloaded from alachisoft.com.
# The 4 GB installation key below is the Open Source edition's default cache size.
RUN curl -fsSL --retry 3 -o ncache-oss.tar.gz \
        https://download.alachisoft.com/ncache/ncache-oss-5.3.603.tar.gz && \
    ./installncache.sh --installkey "YOUR_INSTALL_KEY" && \
    rm -rf /opt/ncache/lib/license \*

LABEL org.label-schema.name="NCache Open Source" \
      org.label-schema.version=$BUILD_VERSION \
      org.label-schema.description="NCache: Highly Scalable Distributed Cache for .NET" \
      org.label-schema.vendor="Alachisoft" \
      org.label-schema.url="https://www.alachisoft.com/ncache/" \
      org.label-schema.maintainer="support@alachisoft.com" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.schema-version="1.0"

USER ncache

# Binds NCache to the container's address on first start, then starts the NCache service.
ENTRYPOINT ["/app/startup.sh"]
