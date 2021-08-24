docker build \
 -t ncachedev/ncachetest:enterprise-server-linux-5.2 \
 --build-arg BUILD_DATE=$(date -u +'%Y-%m-%dT%H:%M:%SZ') \
 --build-arg BUILD_VERSION="5.2" \
 --build-arg SETUP_HTTP_PATH="http://127.0.0.1:85/NCache/NCache%205.2/5.2.0.36/Enterprise/Linux/ncache-enterprise.tar.gz" \