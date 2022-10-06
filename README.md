# NCache: Highly Scalable Distributed Cache for .NET

## Complete set of Tags

### Windows Server Core Tags

#### NCache Enterprise

*   `latest`
*   `enterprise-server-5.3.1`
*   `enterprise-server-5.0.4`
*   `enterprise-server-5.0.2`
*   `enterprise-server-5.0.1`
*   `enterprise-server-5.0`
*   `enterprise-server-4.9.1`


### Windows Nano Server Tags

*   `enterprise-server-nano-4.9.1`

### Linux Tags

#### NCache Enterprise

*   `enterprise-server-linux-5.3.1`
*   `enterprise-server-linux-5.0.4`
*   `enterprise-server-linux-5.0.2`
*   `enterprise-server-linux-5.0.1`
*   `enterprise-server-linux-5.0`
*   `enterprise-server-linux-4.9.1`


## Docker Commands for NCache

Following commands can be used to pull images with different editions of NCache:

### Enterprise

*   For NCache Enterprise Server Edition on Windows Server Core use  
	`docker pull alachisoft/ncache:latest`  
    or  
    `docker pull alachisoft/ncache:enterprise-server-5.3.1`
  
*   For NCache Enterprise Server Edition on Linux Debian use  
    `docker pull alachisoft/ncache:enterprise-server-linux-5.3.1`



## Dockerfile Links

In order to create custom Docker images, Dockerfiles can be found at the follwing [GitHub](https://github.com/Alachisoft/NCache-Docker) links:

*   [NCache Enterprise Server For Windows Server Core](https://github.com/Alachisoft/NCache-Docker/blob/master/enterprise/server/WindowServer/Dockerfile)
*   [NCache Enterprise Client For Windows Server Core](https://github.com/Alachisoft/NCache-Docker/blob/master/enterprise/client/WindowServer/Dockerfile)
*   [NCache Enterprise Server For Linux](https://github.com/Alachisoft/NCache-Docker/blob/master/enterprise/server/Linux/Dockerfile)
*   [NCache Enterprise Client For Linux](https://github.com/Alachisoft/NCache-Docker/blob/master/enterprise/client/Linux/Dockerfile)
*   [NCache Opensource Client For Linux](https://github.com/Alachisoft/NCache-Docker/blob/master/opensource/client/Linux/Dockerfile)



## What is NCache?

NCache is an extremely fast and scalable Open Source distributed cache for .NET applications. Use NCache for database caching, ASP.NET Session State storage, ASP.NET View State Caching, and much more.

NCache is used by hundreds of companies all over the world in mission critical applications. See more details about NCache at [www.alachisoft.com](http://alachisoft.com). NCache documentation can be found at [www.alachisoft.com/resources/docs/](http://www.alachisoft.com/resources/docs/).

This repository contains official docker images for NCache.

## Issues

If you have any problems with or questions about this image, please contact us through a [GitHub issue](https://github.com/Alachisoft/NCache-Docker/issues).

## Licenses

*   NCache Enterprise is available free for 60 days with all features and no performance or other limitations. When the NCache image is launched for the first time, you are required to register NCache with free evaluation key using PowerShell command 'Register-NCacheEvaluation'. You can contact sales@alachisoft to get a free evaluation key. Upon purchase you will receive an annual subscription license key. Entering the annual subscription license key converts the product from evaluation mode to a purchased copy without any re-installation. And, the product works for one or more years (based on how many years subscription you have purchased). And, at the end of this subscription period you must renew the subscription or NCache stops working. However, you’re given ample alerts at renewal time.

*   NCache docker images for Windows Server Core are based on the [Windows Server Core docker image](https://hub.docker.com/r/microsoft/windowsservercore/). The Windows licensing is same as mentioned on [Windows Server Core base image](https://hub.docker.com/r/microsoft/windowsservercore/).

*   NCache docker images for Linux are based on the [.NET](https://hub.docker.com/_/microsoft-dotnet-runtime/) 6.0-runtime image which in turn is based on [Debian docker image](https://hub.docker.com/_/debian/). The Debian licensing is same as mentioned on [Debian base image](https://hub.docker.com/_/debian/).


## Related Repositories

*   [alachisoft/ncache](https://hub.docker.com/r/alachisoft/ncache/) for NCache Docker Images
*   [Alachisoft/NCache-Docker](https://github.com/Alachisoft/NCache-Docker) for NCache Dockerfiles
*   [microsoft/dotnet-framework](https://hub.docker.com/r/microsoft/dotnet-framework/) for .NET Framework Images
*   [microsoft/dotnet](https://hub.docker.com/r/microsoft/dotnet/) for .NET Core Images
*   [microsoft/windowsservercore](https://hub.docker.com/r/microsoft/windowsservercore/) for Windows Server Core Images
*   [debian](https://hub.docker.com/_/debian/) for Ubuntu Debian Images

