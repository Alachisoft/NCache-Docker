# NCache: Highly Scalable Distributed Cache for .NET

#### NCache Enterprise
*   `latest`
*   `5.3.4`

#### NCache Professional

*   `latest-professional`
*   `5.3.2-professional`

#### NCache Open Source

*   `opensource-server-5.0.4`


## Docker Commands for NCache

Following commands can be used to pull images with different editions of NCache:

### Enterprise

*   For the latest version of NCache Enterprise Server .NET Edition always use  
     `docker pull alachisoft/ncache:latest`

*   For a specific version of NCache Enterprise use version tag like this  
     `docker pull alachisoft/ncache:5.3.4`
 
### Professional

*   For the latest version of NCache Professional Server Edition always use  
     `docker pull alachisoft/ncache:latest-professional`

*   For a specific version of NCache Professional use version tag like this  
     `docker pull alachisoft/ncache:5.3.3-professional`

### Open Source

*   For NCache Open Source Server Edition on Windows Server Core use    
      `docker pull alachisoft/ncache:opensource-server-5.0.4`


## Dockerfile Links

In order to create custom Docker images, Dockerfiles can be found at the follwing [GitHub](https://github.com/Alachisoft/NCache-Docker) links:

### Enterprise

*   [NCache Enterprise Server](https://github.com/Alachisoft/NCache-Docker/blob/master/enterprise/dotnet-edition/server/Linux/Dockerfile)
*   [NCache Enterprise Client](https://github.com/Alachisoft/NCache-Docker/blob/master/enterprise/dotnet-edition/client/Linux/Dockerfile)

### Professional

*   [NCache Professional Server](https://github.com/Alachisoft/NCache-Docker/blob/master/professional/server/Linux/Dockerfile)
*   [NCache Professional Client](https://github.com/Alachisoft/NCache-Docker/blob/master/professional/client/Linux/Dockerfile)

### Open Source

*   [NCache Open Source Server](https://github.com/Alachisoft/NCache-Docker/blob/master/opensource/server/WindowServer/Server/Dockerfile)


## What is NCache?

NCache is an extremely fast and scalable Open Source distributed cache for .NET & Java applications. Use NCache for database caching, ASP.NET Session State storage, ASP.NET View State Caching, and much more.

NCache is used by hundreds of companies all over the world in mission critical applications. See more details about NCache at [www.alachisoft.com](https://www.alachisoft.com). NCache documentation can be found at [www.alachisoft.com/resources/docs/](https://www.alachisoft.com/resources/docs/).

This repository contains official docker images for NCache.

## Issues

If you have any problems with or questions about this image, please contact us through a [GitHub issue](https://github.com/Alachisoft/NCache-Docker/issues).

## Licenses

*   NCache Enterprise is available free for 60 days with all features and no performance or other limitations. When the NCache image is launched for the first time, you are required to register NCache with free evaluation key using PowerShell command 'Register-NCacheEvaluation'. You can contact sales@alachisoft to get a free evaluation key. Upon purchase you will receive an annual subscription license key. Entering the annual subscription license key converts the product from evaluation mode to a purchased copy without any re-installation. And, the product works for one or more years (based on how many years subscription you have purchased). And, at the end of this subscription period you must renew the subscription or NCache stops working. However, you’re given ample alerts at renewal time.

*   NCache docker images for Linux are based on [Ubuntu 22.04](https://hub.docker.com/_/ubuntu) base image. The Ubuntu licensing is same as mentioned on [Ubuntu base image](https://hub.docker.com/_/ubuntu).


## Related Repositories

*   [alachisoft/ncache](https://hub.docker.com/r/alachisoft/ncache/) for NCache Docker Images
*   [alachisoft/ncache-docker](https://github.com/Alachisoft/NCache-Docker) for NCache Dockerfiles
*   [microsoft/dotnet](https://hub.docker.com/r/microsoft/dotnet/) for .NET Core Images
*   [ubuntu](https://hub.docker.com/_/ubuntu) for Ubuntu base Images
  
