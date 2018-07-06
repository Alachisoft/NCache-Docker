# NCache: Highly Scalable Distributed Cache for .NET

## Complete set of Tags

### NCache Enterprise

*   `latest`
*   `enterprise-server-4.9`
*   `enterprise-server-4.8`
*   `enterprise-client-4.8`

### NCache Community

*   `community-server-4.9`

### NCache Open Source

*   `opensource-server-4.9`

## Docker Commands for NCache

Following commands can be used to pull images with different editions of NCache:

*   For NCache 4.9 Enterprise Server Edition use  
    `docker pull alachisoft/ncache:latest`  
    or  
    `docker pull alachisoft/ncache:enterprise-server-4.9`
*   For NCache 4.9 Community Server Edition use  
    `docker pull alachisoft/ncache:community-server-4.9`
*   For NCache 4.9 Open Source Server Edition use  
    `docker pull alachisoft/ncache:opensource-server-4.9`
*   For NCache 4.8 Enterprise Server Edition use  
    `docker pull alachisoft/ncache:enterprise-server-4.8`

## Dockerfile Links

In order to created custom Docker images, Dockerfiles can be found at the follwing [GitHub](https://github.com/Alachisoft/NCache-Docker) links:

*   [NCache Enterprise Server 4.9](https://github.com/Alachisoft/NCache-Docker/blob/master/enterprise/server/Dockerfile)
*   [NCache Enterprise Client 4.9](https://github.com/Alachisoft/NCache-Docker/blob/master/enterprise/client/Dockerfile)
*   [NCache Community Server 4.9](https://github.com/Alachisoft/NCache-Docker/blob/master/community/server/Dockerfile)
*   [NCache Community Client 4.9](https://github.com/Alachisoft/NCache-Docker/blob/master/community/client/Dockerfile)
*   [NCache Open Source Server 4.9](https://github.com/Alachisoft/NCache-Docker/blob/master/open%20source/Dockerfile)

## What is NCache?

NCache is an extremely fast and scalable Open Source distributed cache for .NET applications. Use NCache for database caching, ASP.NET Session State storage, ASP.NET View State Caching, and much more.

NCache is used by hundreds of companies all over the world in mission critical applications. See more details about NCache at [www.alachisoft.com](http://alachisoft.com). NCache documentation can be found at [www.alachisoft.com/resources/docs/](http://www.alachisoft.com/resources/docs/).

This repository contains official docker images for NCache.

## Issues

If you have any problems with or questions about this image, please contact us through a [GitHub issue](https://github.com/Alachisoft/NCache-Docker/issues).

## Licenses

*   **Please Request a FREE 60-Day Trial License Key** NCache Enterprise comes with all features during evaluation period. But, it has a **built-in performance limitation** (max 200 req/sec per cache per server) and the **amount of activity limitation** (total 500,000 requests before a cache restart is required). You can remove these limitations from NCache Enterprise by requesting a [**FREE 60-day Trial License Key**](http://www.alachisoft.com/request-trial.php) and activating all the cache servers with it. This Trial License Key can be extended upon additional request. And, when you purchase NCache Enterprise, the purchased license key also removes all these limitations.

*   NCache docker images are based on the [.NET Framework](https://hub.docker.com/r/microsoft/dotnet-framework/) 4.6.2 image which in turn is based on [Windows Server Core docker image](https://hub.docker.com/r/microsoft/windowsservercore/). The Windows licensing is same as mentioned on [Windows Server Core base image](https://hub.docker.com/r/microsoft/windowsservercore/).

## Related Repositories

*   [alachisoft/ncache](https://hub.docker.com/r/alachisoft/ncache/) for NCache Docker Images
*   [Alachisoft/NCache-Docker](https://github.com/Alachisoft/NCache-Docker) for NCache Dockerfiles
*   [microsoft/dotnet-framework](https://hub.docker.com/r/microsoft/dotnet-framework/) for .NET Framework Images
*   [microsoft/windowsservercore](https://hub.docker.com/r/microsoft/windowsservercore/) for Windows Server Core Images