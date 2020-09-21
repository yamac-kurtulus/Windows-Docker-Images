ARG VERSION="1.19.2"
ARG WINDOWS_VERSION=1809
FROM mcr.microsoft.com/windows/servercore:${WINDOWS_VERSION} as download
ARG VERSION
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"] 
ENV MHOLT_ARCHIVER_VERSION 2.0
ENV MHOLT_ARCHIVER_SHA256 c23eab86a8f77e446f2b5dbb03305ac9acfb5187108a0090a4bcb3d908fa9785
WORKDIR C:/jaeger
RUN [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 ; `
    Invoke-WebRequest $('https://github.com/mholt/archiver/releases/download/v{0}/archiver_windows_amd64.exe' -f $env:MHOLT_ARCHIVER_VERSION) -OutFile archiver.exe -UseBasicParsing ; `
    if ((Get-FileHash archiver.exe -Algorithm sha256).Hash -ne $env:MHOLT_ARCHIVER_SHA256) { Write-Error 'SHA256 mismatch' }
	
RUN iwr "https://github.com/jaegertracing/jaeger/releases/download/v${env:VERSION}/jaeger-${env:VERSION}-windows-amd64.tar.gz" -useb -o jaeger.tar.gz
RUN .\archiver.exe open jaeger.tar.gz 
RUN Rename-Item -Path $('jaeger-${0}-windows-amd64' -f ${env:VERSION}) -NewName 'C:\jaeger'

FROM openjdk:15-nanoserver-${WINDOWS_VERSION} as final
WORKDIR C:/jaeger
COPY --from=download C:/jaeger .