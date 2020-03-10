# escape=`
ARG winVersion="1809"
FROM mcr.microsoft.com/windows/servercore:$winVersion as build
ARG GrafanaVersion="6.6.2"
SHELL ["powershell", "-command"]
WORKDIR C:/
RUN invoke-webrequest -useb https://dl.grafana.com/oss/release/grafana-${GrafanaVersion}.windows-amd64.zip
RUN expand-archive C:/
RUN rename grafana-${GrafanaVersion} grafana
FROM mcr.microsoft.com/windows/nanoserver:$winVersion as final
WORKDIR C:/grafana
COPY --from=build C:/grafana .
EXPOSE 3000
ENTRYPOINT ["./bin/grafana-server.exe"]