# Windows-Docker-Images
Some Dockerfiles to use with Docker on Windows. Most use Windows Server 1809 images as these are tools I had to use in a Windows Server environment. For Windows 10, you may need to create your own images using these Dockerfiles. You can find the docker repository [here] (https://hub.docker.com/u/yamackurtulus). 

All the tools here already have linux images. Newer Docker versions can use the LCOW (Linux Containers on Windows) feature to run Linux images on Windows containers in hyperv isolation mode. Images in this repository are useful for

 - Virtualization scenarios for Windows version 1809+ where nested virtualization is disabled or unavailible.
 - Windows Server 2016 LTS versions (pre 1803) (tags may or may not be present in repository, you may need to recreate from dockerfiles).
 - Running more lightweight containers in process isolation mode on Windows.
 
Some images are heavily inspired from the Dockerfiles by: [Stefan Scherer](https://github.com/StefanScherer/dockerfiles-windows)
