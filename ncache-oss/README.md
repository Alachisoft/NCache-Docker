# NCache Open Source Docker Image

Dockerfile for **NCache Open Source 5.3.603** on Linux.

| Image | Folder | Docker Hub |
|---|---|---|
| NCache Open Source Server | [`server/`](server) | `alachisoft/ncache:latest-oss`, `alachisoft/ncache:5.3.603-OSS` |

The image runs the NCache service. NCache Open Source is managed with the command-line tools in
`/opt/ncache/bin/tools`.

## Pull

```bash
docker pull alachisoft/ncache:latest-oss
docker pull alachisoft/ncache:5.3.603-OSS
```

## Build

The Dockerfile downloads the NCache Open Source setup from alachisoft.com, so the build machine
needs internet access. Replace `YOUR_INSTALL_KEY` in the Dockerfile with your installation key,
then build:

```bash
cd server
docker build -t ncache-oss .
```

Optional build arguments, recorded in the image label: `BUILD_VERSION`, `BUILD_DATE`.

## Run

```bash
docker run -d --name ncache-oss -p 9800:9800 alachisoft/ncache:latest-oss
```

| Port | Used for |
|---|---|
| 9800 | Client connections to the NCache service |
| 9800-9999 | Exposed by the image for cache processes and cluster communication |

On the first start the container binds NCache to its own IP address.

## Registration

NCache Open Source is free, but it must be registered before a cache can start. Get a free
registration key from [alachisoft.com/get-oss-key.php](https://www.alachisoft.com/get-oss-key.php),
then register the container:

```bash
docker exec -it ncache-oss /opt/ncache/bin/tools/register-ncacheopensource -Key <registration-key>
```

## Managing caches

The installation creates the caches `defaultCache`, `defaultLocalCache` and `defaultPubSub`.

```bash
docker exec -it ncache-oss /opt/ncache/bin/tools/get-caches
docker exec -it ncache-oss /opt/ncache/bin/tools/start-cache -Name defaultCache
docker exec -it ncache-oss /opt/ncache/bin/tools/test-stress -CacheName defaultCache
```

Other tools in `/opt/ncache/bin/tools`: `stop-cache`, `clear-cache`, `get-cacheserverstatistics`,
`get-cacheclientstatistics`, `export-cacheconfiguration`, `export-cachekeys`, `get-ncacheversion`.

## Environment variables

| Variable | Default | Description |
|---|---|---|
| `NC_BIND_IP` | first container IP | Address NCache binds to. Set it when the container has more than one address, e.g. with `--network host`. |

## Image contents

| File | Purpose |
|---|---|
| `Dockerfile` | Installs the prerequisites, downloads and installs NCache Open Source. |
| `resources/installncache.sh` | Installs NCache at build time. |
| `resources/stubgenerator.sh` | Installs the runtime library shipped with the image at build time. |
| `resources/startup.sh` | Container entry point: IP binding, then the NCache service. |
| `resources/ipbinding.sh` | Binds NCache to the container's address on the first start. |

## License

NCache Open Source is licensed under the [Apache License 2.0](https://github.com/Alachisoft/NCache/blob/master/LICENSE).
The image is based on [Ubuntu 22.04](https://hub.docker.com/_/ubuntu); licensing of the base image is
as stated for that image.

See the [repository README](../README.md) for the Enterprise edition, issues and related repositories.
