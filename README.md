# NCache: Highly Scalable Distributed Cache for .NET

Official Dockerfiles for [NCache](https://www.alachisoft.com/ncache/).

NCache is an extremely fast and scalable distributed cache for .NET and Java applications. Use
NCache for database caching, ASP.NET Session State storage, ASP.NET View State caching, and much
more. NCache is used by hundreds of companies all over the world in mission critical applications.

## Editions

| Edition | Folder | Docker Hub tags | Documentation |
|---|---|---|---|
| NCache Enterprise | [`ncache/`](ncache) | `latest`, `5.3.800` | [Enterprise README](ncache/README.md) |
| NCache Open Source | [`ncache-oss/`](ncache-oss) | `latest-oss`, `5.3.603-OSS` | [Open Source README](ncache-oss/README.md) |

```bash
docker pull alachisoft/ncache:latest        # NCache Enterprise
docker pull alachisoft/ncache:latest-oss    # NCache Open Source
```

## Repository layout

```text
ncache/
    server/      NCache Enterprise server image
    client/      NCache Enterprise client image
ncache-oss/
    server/      NCache Open Source server image
```

Each image folder contains a `Dockerfile` and a `resources/` folder with the scripts the image
runs. See the edition's README for building, running and configuring the image.

## Documentation

NCache documentation: [www.alachisoft.com/resources/docs](https://www.alachisoft.com/resources/docs/).

## Issues

If you have any problems with or questions about these images, please open a
[GitHub issue](https://github.com/Alachisoft/NCache-Docker/issues).

## Related repositories

*   [alachisoft/ncache](https://hub.docker.com/r/alachisoft/ncache/): NCache Docker images
*   [microsoft/dotnet](https://hub.docker.com/r/microsoft/dotnet/): .NET images
*   [ubuntu](https://hub.docker.com/_/ubuntu): Ubuntu base images
