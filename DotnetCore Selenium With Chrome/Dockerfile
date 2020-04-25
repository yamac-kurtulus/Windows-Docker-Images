#escape=`

FROM mcr.microsoft.com/windows/servercore:1809 AS sdk
SHELL ["powershell", "-command", "$ErrorActionPreference = 'Stop';"]
USER ContainerAdministrator
ENV ASPNETCORE_ENVIRONMENT = 'Devbranch'
WORKDIR /setup
#Start installing required apps
ENV chocolateyUseWindowsCompression = 'true'
RUN iex(iwr -useb https://chocolatey.org/install.ps1)
RUN echo 'install dotnet core sdk and chrome via choco'
RUN choco install dotnetcore-sdk --version 2.2 -fy
RUN choco install googlechrome -fy

