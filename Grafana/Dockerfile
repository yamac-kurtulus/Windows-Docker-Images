# escape=`
ARG WINDOWS_VERSION=1809
ARG VERSION="7.1.1"
FROM mcr.microsoft.com/windows/servercore:$WINDOWS_VERSION AS tar
ARG VERSION
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]
WORKDIR C:/
RUN iwr "https://dl.grafana.com/oss/release/grafana-${Env:VERSION}.windows-amd64.zip" -o grafana.zip
RUN Expand-archive grafana.zip ./grafana
# Install piechart plugin


FROM mcr.microsoft.com/windows/nanoserver:$WINDOWS_VERSION
ARG VERSION
WORKDIR c:/
COPY --from=tar C:/grafana/grafana-${VERSION} ./grafana
WORKDIR C:/grafana
RUN bin\grafana-cli.exe plugins install grafana-piechart-panel
EXPOSE 3000
ENTRYPOINT ["C:\\grafana\\bin\\grafana-server.exe"]