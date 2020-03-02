FROM mcr.microsoft.com/windows/servercore:1809 as download
ARG zipkinVersion="2.19.3"
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"] 
WORKDIR C:/zipkin
RUN iwr "https://search.maven.org/remotecontent?filepath=io/zipkin/zipkin-server/${env:zipkinVersion}/zipkin-server-${env:zipkinVersion}-exec.jar" -useb -o zipkin.jar
FROM openjdk:15-nanoserver-1809 as final
WORKDIR C:/zipkin
COPY --from=download C:/zipkin .
EXPOSE 9411
ENTRYPOINT java -jar zipkin.jar