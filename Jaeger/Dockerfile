ARG VERSION="2.19.3"
ARG WINDOWS_VERSION=1809
FROM mcr.microsoft.com/windows/servercore:${WINDOWS_VERSION} as download
ARG VERSION
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"] 
WORKDIR C:/zipkin
RUN iwr "https://search.maven.org/remotecontent?filepath=io/zipkin/zipkin-server/${env:VERSION}/zipkin-server-${env:VERSION}-exec.jar" -useb -o zipkin.jar

FROM openjdk:15-nanoserver-${WINDOWS_VERSION} as final
WORKDIR C:/zipkin
COPY --from=download C:/zipkin .
EXPOSE 9411
ENTRYPOINT java -jar zipkin.jar