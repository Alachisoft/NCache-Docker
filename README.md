# NCache: Highly Scalable Distributed Cache for .NET

### Linux Tags

#### NCache Enterprise (.NET Edition)
*   `latest`
*   `5.3.2`, `5.3.2-enterprise`

#### NCache Enterprise (Java Edition)
*   `latest-java`
*   `5.3.2-java`, `5.3.2-enterprise-java`

#### NCache Professional

*   `latest-professional`
*   `5.3.2-professional`


### Windows Server Core Tags

#### NCache Enterprise (.NET Edition)

*   `latest`
*   `5.3.2`, `5.3.2-enterprise-wincore2019`

#### NCache Enterprise (Java Edition)

*   `latest-java`
*   `5.3.2-java`, `5.3.2-enterprise-java-wincore2019`

#### NCache Professional

*   `latest-professional`
*   `5.3.2-professional-wincore2019`

#### NCache Open Source

*   `opensource-server-5.0.4`


## Docker Commands for NCache

Following commands can be used to pull images with different editions of NCache:

### Enterprise

*   For the latest version of NCache Enterprise Server .NET Edition always use  
     `docker pull alachisoft/ncache:latest`

*   For a specific version of NCache Enterprise use version tag like this  
     `docker pull alachisoft/ncache:5.3.2`
 
### Professional

*   For the latest version of NCache Professional Server Edition always use  
     `docker pull alachisoft/ncache:latest-professional`

*   For a specific version of NCache Professional use version tag like this  
     `docker pull alachisoft/ncache:5.3.2-professional`

### Open Source

*   For NCache Open Source Server Edition on Windows Server Core use    
      `docker pull alachisoft/ncache:opensource-server-5.0.4`


## Dockerfile Links

In order to create custom Docker images, Dockerfiles can be found at the follwing [GitHub](https://github.com/Alachisoft/NCache-Docker) links:

### Enterprise .NET Edition

*   [NCache Enterprise Server For Linux](https://github.com/Alachisoft/NCache-Docker/blob/master/enterprise/dotnet-edition/server/Linux/Dockerfile)
*   [NCache Enterprise Client For Linux](https://github.com/Alachisoft/NCache-Docker/blob/master/enterprise/dotnet-edition/client/Linux/Dockerfile)
*   [NCache Enterprise Server For Windows Server Core](https://github.com/Alachisoft/NCache-Docker/blob/master/enterprise/dotnet-edition/server/WindowServer/Dockerfile)
*   [NCache Enterprise Client For Windows Server Core](https://github.com/Alachisoft/NCache-Docker/blob/master/enterprise/dotnet-edition/client/WindowServer/Dockerfile)

### Enterprise Java Edition

*   [NCache Enterprise Server For Linux](https://github.com/Alachisoft/NCache-Docker/blob/master/enterprise/java-edition/server/Linux/Dockerfile)
*   [NCache Enterprise Client For Linux](https://github.com/Alachisoft/NCache-Docker/blob/master/enterprise/java-edition/client/Linux/Dockerfile)
*   [NCache Enterprise Server For Windows Server Core](https://github.com/Alachisoft/NCache-Docker/blob/master/enterprise/java-edition/server/WindowServer/Dockerfile)
*   [NCache Enterprise Client For Windows Server Core](https://github.com/Alachisoft/NCache-Docker/blob/master/enterprise/java-edition/client/WindowServer/Dockerfile)

### Professional

*   [NCache Professional Server For Linux](https://github.com/Alachisoft/NCache-Docker/blob/master/professional/server/Linux/Dockerfile)
*   [NCache Professional Client For Linux](https://github.com/Alachisoft/NCache-Docker/blob/master/professional/client/Linux/Dockerfile)
*   [NCache Professional Server For Windows Server Core](https://github.com/Alachisoft/NCache-Docker/blob/master/professional/server/WindowServer/Dockerfile)
*   [NCache Professional Client For Windows Server Core](https://github.com/Alachisoft/NCache-Docker/blob/master/professional/client/WindowServer/Dockerfile)

### Open Source

*   [NCache Open Source Server For Windows Server Core](https://github.com/Alachisoft/NCache-Docker/blob/master/opensource/server/WindowServer/Server/Dockerfile)


## What is NCache?

NCache is an extremely fast and scalable Open Source distributed cache for .NET applications. Use NCache for database caching, ASP.NET Session State storage, ASP.NET View State Caching, and much more.

NCache is used by hundreds of companies all over the world in mission critical applications. See more details about NCache at [www.alachisoft.com](https://www.alachisoft.com). NCache documentation can be found at [www.alachisoft.com/resources/docs/](https://www.alachisoft.com/resources/docs/).

This repository contains official docker images for NCache.

## Issues

If you have any problems with or questions about this image, please contact us through a [GitHub issue](https://github.com/Alachisoft/NCache-Docker/issues).

## Licenses

*   NCache Enterprise is available free for 60 days with all features and no performance or other limitations. When the NCache image is launched for the first time, you are required to register NCache with free evaluation key using PowerShell command 'Register-NCacheEvaluation'. You can contact sales@alachisoft to get a free evaluation key. Upon purchase you will receive an annual subscription license key. Entering the annual subscription license key converts the product from evaluation mode to a purchased copy without any re-installation. And, the product works for one or more years (based on how many years subscription you have purchased). And, at the end of this subscription period you must renew the subscription or NCache stops working. However, you’re given ample alerts at renewal time.

*   NCache Enterpise Java Edition docker images for Linux are based on the Java 17, using [Ubuntu 22.04](https://hub.docker.com/_/ubuntu) base image. The Ubuntu licensing is same as mentioned on [Ubuntu base image](https://hub.docker.com/_/ubuntu).

*   NCache docker images for Windows Server Core are based on the [Windows Server Core docker image](https://hub.docker.com/r/microsoft/windowsservercore/). The Windows licensing is same as mentioned on [Windows Server Core base image](https://hub.docker.com/r/microsoft/windowsservercore/).


## Related Repositories

*   [alachisoft/ncache](https://hub.docker.com/r/alachisoft/ncache/) for NCache Docker Images
*   [alachisoft/ncache-docker](https://github.com/Alachisoft/NCache-Docker) for NCache Dockerfiles
*   [microsoft/dotnet-framework](https://hub.docker.com/r/microsoft/dotnet-framework/) for .NET Framework Images
*   [microsoft/dotnet](https://hub.docker.com/r/microsoft/dotnet/) for .NET Core Images
*   [microsoft/windowsservercore](https://hub.docker.com/r/microsoft/windowsservercore/) for Windows Server Core Images
*   [ubuntu](https://hub.docker.com/_/ubuntu) for Ubuntu base Images
  
