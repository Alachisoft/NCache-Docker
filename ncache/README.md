# NCache Enterprise Docker Images

Dockerfiles for **NCache Enterprise 5.3.800** on Linux.

| Image | Folder | Docker Hub |
|---|---|---|
| NCache Enterprise Server | [`server/`](server) | `alachisoft/ncache:latest`, `alachisoft/ncache:5.3.800` |
| NCache Enterprise Client | [`client/`](client) | Build from the Dockerfile |

The **server** image runs the NCache service, the execution service, the bridge service and the
NCache Management Center. The **client** image runs only the NCache service, for client caches on an
application host. Both images include PowerShell with the NCache cmdlets.

## Pull

```bash
docker pull alachisoft/ncache:latest
docker pull alachisoft/ncache:5.3.800
```

## Build

The Dockerfile downloads the NCache Enterprise setup from alachisoft.com, so the build machine needs
internet access. Replace `YOUR_INSTALL_KEY` in the Dockerfile with the installation key provided by
Alachisoft, then build:

```bash
cd server
docker build -t ncache .

cd client
docker build -t ncache-client .
```

Optional build arguments, recorded in the image label: `BUILD_VERSION`, `BUILD_DATE`.

## Run

```bash
docker run -d --name ncache -p 9800:9800 -p 9801:9801 alachisoft/ncache:latest
```

| Port | Used for |
|---|---|
| 9800 | Client connections to the NCache service |
| 9801 | NCache Management Center (web) |
| 9800-9999 | Exposed by the image for cache processes and cluster communication |

On the first start the container binds NCache to its own IP address. Run the NCache cmdlets inside
the container with PowerShell:

```bash
docker exec -it ncache pwsh
```

```powershell
Get-Caches
New-Cache -Name demoCache -Server <container-ip> -Topology PartitionReplica
Start-Cache -Name demoCache
```

## Activation

NCache Enterprise is available free for 30 days with all features and no performance or other
limitations. Pass the key as an environment variable and the container activates NCache on start:

```bash
# Evaluation
docker run -d --name ncache -e NC_KEY=<evaluation-key> alachisoft/ncache:latest

# Purchased license
docker run -d --name ncache -e NC_LICENSE_KEY=<license-key> -e NC_LICENSE_ENV=<environment> alachisoft/ncache:latest
```

You can contact [sales@alachisoft.com](mailto:sales@alachisoft.com) to get a free evaluation key.
Upon purchase you will receive an annual subscription license key. Entering it converts the product
from evaluation to a purchased copy without reinstallation. At the end of the subscription period
you must renew it or NCache stops working; you are given ample alerts at renewal time.

## Environment variables

| Variable | Default | Description |
|---|---|---|
| `NC_KEY` | | Evaluation key. Activates NCache for evaluation on start. |
| `NC_LICENSE_KEY` | | License key. Used together with `NC_LICENSE_ENV`. |
| `NC_LICENSE_ENV` | | License environment. Required with `NC_LICENSE_KEY`. |
| `NC_REGISTER_AS` | | Optional role for activation: `Server`, `Client` or `Developer`. |
| `NC_INSTALL_ENV` | | Optional installation type passed to activation. |
| `NC_BIND_IP` | first container IP | Address NCache binds to. Set it when the container has more than one address, e.g. with `--network host`. |
| `NC_USER_PASSWORD` | | New password for the `ncache` user (at least 6 characters). |
| `NC_ENABLE_TLS` | `false` | `true` enables TLS on the address NCache binds to. |
| `NC_MUTUAL_TLS` | `false` | `true` also requires client certificates (mutual TLS). |
| `NC_TLS_CUSTOM_CERTIFICATE` | | Path of the server certificate PEM inside the container: private key, leaf, then intermediates. |
| `NC_TLS_CUSTOM_PASSWORD` | | Password of the encrypted private key in `NC_TLS_CUSTOM_CERTIFICATE`. |
| `NC_TLS_CLIENT_CERTIFICATE` | | Path of the client certificate PEM used with mutual TLS. |
| `NC_TLS_CLIENT_PASSWORD` | | Password of the encrypted private key in `NC_TLS_CLIENT_CERTIFICATE`. |
| `NC_TLS_PROTOCOL_VERSION` | `tls12` | `tls12`, `tls13` or `auto`. |

Mount certificate files into the container with `-v`, for example:

```bash
docker run -d --name ncache \
    -v /path/on/host/certs:/certs:ro \
    -e NC_ENABLE_TLS=true \
    -e NC_TLS_CUSTOM_CERTIFICATE=/certs/server.pem \
    alachisoft/ncache:latest
```

## Image contents

| File | Purpose |
|---|---|
| `Dockerfile` | Installs the prerequisites and PowerShell, downloads and installs NCache. |
| `resources/installncache.sh` | Installs NCache at build time. |
| `resources/startup.sh` | Container entry point: password, IP binding, activation, services. |
| `resources/ipbinding.sh` | Binds NCache to the container's address on the first start. |
| `resources/activate.sh` | Activates NCache from the environment variables above. |
| `resources/enable-tls.sh` | Enables TLS once the NCache service is running, when requested. |

## License

The images are based on the [.NET runtime image](https://hub.docker.com/r/microsoft/dotnet-runtime)
(`mcr.microsoft.com/dotnet/runtime:10.0-noble`, Ubuntu 24.04). Licensing of the base image is as
stated for that image. NCache Enterprise is licensed by Alachisoft as described above.

See the [repository README](../README.md) for the Open Source edition, issues and related repositories.
