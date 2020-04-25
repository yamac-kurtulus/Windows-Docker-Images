# escape=`
ARG windowsVersion=1809
FROM mcr.microsoft.com/windows/servercore:$windowsVersion AS tar
ARG grafanaVersion="6.7.2"
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]
WORKDIR C:/
RUN iwr "https://dl.grafana.com/oss/release/grafana-${Env:grafanaVersion}.windows-amd64.zip" -o grafana.zip
RUN Expand-archive grafana.zip ./grafana

FROM mcr.microsoft.com/windows/nanoserver:$windowsVersion
ARG grafanaVersion="6.7.2"
WORKDIR c:/
COPY --from=tar C:/grafana/grafana-${grafanaVersion} ./grafana
WORKDIR C:/grafana
COPY --from=build C:/grafana .
EXPOSE 3000
ENTRYPOINT ["C:\\grafana\\bin\\grafana-server.exe"]