# NCache: Highly Scalable Distributed Cache for .NET

## Complete set of Tags

### Windows Server Core Tags

#### NCache Enterprise

*   `latest`
*   `enterprise-server-4.9.1`
*   `enterprise-server-4.9`
*   `enterprise-server-4.8`
*   `enterprise-client-4.8`

#### NCache Professional/Community

*   `professional-server-4.9.1`
*   `community-server-4.9`

#### NCache Open Source

*   `opensource-server-4.9.1`
*   `opensource-server-4.9`

### Windows Nano Server Tags

*   `enterprise-server-nano-4.9.1`

### Linux Tags

*   `enterprise-server-linux-4.9.1`

## Docker Commands for NCache

Following commands can be used to pull images with different editions of NCache:

*   For NCache 4.9 SP1 Enterprise Server Edition on Windows Server Core use  
	`docker pull alachisoft/ncache:latest`  
    or  
    `docker pull alachisoft/ncache:enterprise-server-4.9.1`  
*   For NCache 4.9 SP1 Enterprise Server Edition on Windows Nano Server (as Beta release) use  
    `docker pull alachisoft/ncache:enterprise-server-nano-4.9.1`  
*   For NCache 4.9 SP1 Enterprise Server Edition on Linux Debian use  
    `docker pull alachisoft/ncache:enterprise-server-linux-4.9.1`
*   For NCache 4.9 SP1 Professional Server Edition use  
    `docker pull alachisoft/ncache:professional-server-4.9.1`  
*   For NCache 4.9 SP1 Open Source Server Edition use  
    `docker pull alachisoft/ncache:opensource-server-4.9.1`      
*   For NCache 4.9 Community Server Edition use  
    `docker pull alachisoft/ncache:community-server-4.9`  
*   For NCache 4.9 Open Source Server Edition use  
    `docker pull alachisoft/ncache:opensource-server-4.9`  
*   For NCache 4.8 Enterprise Server Edition use  
    `docker pull alachisoft/ncache:enterprise-server-4.8`  

## Dockerfile Links

In order to create custom Docker images, Dockerfiles can be found at the follwing [GitHub](https://github.com/Alachisoft/NCache-Docker) links:

*   [NCache Enterprise Server 4.9 SP1 For Windows Server Core](https://github.com/Alachisoft/NCache-Docker/blob/master/enterprise/server/WindowServerCore/Dockerfile)
*   [NCache Enterprise Client 4.9 SP1 For Windows Server Core](https://github.com/Alachisoft/NCache-Docker/blob/master/enterprise/client/WindowServerCore/Dockerfile)
*   [NCache Enterprise Server 4.9 SP1 For Linux](https://github.com/Alachisoft/NCache-Docker/blob/master/enterprise/server/Linux/Dockerfile)
*   [NCache Enterprise Client 4.9 SP1 For Linux](https://github.com/Alachisoft/NCache-Docker/blob/master/enterprise/client/Linux/Dockerfile)
*   [NCache Professional Server 4.9 SP1](https://github.com/Alachisoft/NCache-Docker/blob/master/professional/server/Dockerfile)
*   [NCache Professional Client 4.9 SP1](https://github.com/Alachisoft/NCache-Docker/blob/master/professional/client/Dockerfile)
*   [NCache Open Source Server 4.9 SP1](https://github.com/Alachisoft/NCache-Docker/blob/master/open%20source/Dockerfile)

## What is NCache?

NCache is an extremely fast and scalable Open Source distributed cache for .NET applications. Use NCache for database caching, ASP.NET Session State storage, ASP.NET View State Caching, and much more.

NCache is used by hundreds of companies all over the world in mission critical applications. See more details about NCache at [www.alachisoft.com](http://alachisoft.com). NCache documentation can be found at [www.alachisoft.com/resources/docs/](http://www.alachisoft.com/resources/docs/).

This repository contains official docker images for NCache.

## Issues

If you have any problems with or questions about this image, please contact us through a [GitHub issue](https://github.com/Alachisoft/NCache-Docker/issues).

## Licenses

*   NCache Enterprise and NCache Professional are online products only, available **free for 60 days with all features and no performance or other limitations**. Upon download, you are given an install key that you must enter at install time. This activates NCache for 60 days but you can extend it 30 days at a time and up to 180 days total by contacting sales. Upon purchase you will receive an annual subscription license key. Entering the annual subscription license key converts the product from evaluation mode to a purchased copy without any re-installation. And, the product works for one or more years (based on how many years subscription you have purchased). And, at the end of this subscription period you must renew the subscription or NCache stops working. However, you’re given ample alerts at renewal time.

*   NCache docker images for Windows Server Core are based on the [.NET Framework](https://hub.docker.com/r/microsoft/dotnet-framework/) 4.6.2/4.7.2-runtime images which in turn are based on [Windows Server Core docker image](https://hub.docker.com/r/microsoft/windowsservercore/). The Windows licensing is same as mentioned on [Windows Server Core base image](https://hub.docker.com/r/microsoft/windowsservercore/).

*   NCache docker images for Nano Server (as Beta release) are based on the [.NET Core](https://hub.docker.com/r/microsoft/dotnet/) 2.1-runtime image which in turn is based on [Windows Nano Server docker image](https://hub.docker.com/r/microsoft/nanoserver/). The Windows licensing is same as mentioned on [Windows Nano Server base image](https://hub.docker.com/r/microsoft/nanoserver/).

*   NCache docker images for Linux are based on the [.NET Core](https://hub.docker.com/r/microsoft/dotnet/) 2.1-runtime image which in turn is based on [Debian docker image](https://hub.docker.com/_/debian/). The Debian licensing is same as mentioned on [Debian base image](https://hub.docker.com/_/debian/).


## Related Repositories

*   [alachisoft/ncache](https://hub.docker.com/r/alachisoft/ncache/) for NCache Docker Images
*   [Alachisoft/NCache-Docker](https://github.com/Alachisoft/NCache-Docker) for NCache Dockerfiles
*   [microsoft/dotnet-framework](https://hub.docker.com/r/microsoft/dotnet-framework/) for .NET Framework Images
*   [microsoft/dotnet](https://hub.docker.com/r/microsoft/dotnet/) for .NET Core Images
*   [microsoft/windowsservercore](https://hub.docker.com/r/microsoft/windowsservercore/) for Windows Server Core Images
*   [microsoft/nanoserver](https://hub.docker.com/r/microsoft/nanoserver/) for Windows Nano Server Images
*   [debian](https://hub.docker.com/_/debian/) for Ubuntu Debian Images