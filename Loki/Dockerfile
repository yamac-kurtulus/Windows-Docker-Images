# escape=`
ARG windowsVersion=1809
FROM mcr.microsoft.com/windows/servercore:$windowsVersion AS tar
ARG lokiVersion=1.5.0
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]
WORKDIR C:/
RUN iwr https://github.com/grafana/loki/releases/download/v${Env:lokiVersion}/loki-windows-amd64.exe.zip -o ./loki.zip
RUN iwr https://github.com/grafana/loki/releases/download/v${Env:lokiVersion}/loki-canary-windows-amd64.exe.zip -o ./canary.zip
RUN iwr https://github.com/grafana/loki/releases/download/v${Env:lokiVersion}/promtail-windows-amd64.exe.zip -o ./promtail.zip
RUN Expand-archive loki.zip ./loki
RUN Expand-archive canary.zip ./canary
RUN Expand-archive promtail.zip ./promtail
#download a config file example
RUN mkdir ./loki/conf
RUN iwr https://raw.githubusercontent.com/grafana/loki/v${Env:lokiVersion}/cmd/loki/loki-local-config.yaml -o ./loki/conf/loki-local-config.yaml

FROM mcr.microsoft.com/windows/nanoserver:$windowsVersion
WORKDIR c:/
COPY --from=tar C:/loki/ ./loki
COPY --from=tar C:/canary/ ./canary
COPY --from=tar C:/promtail/ ./promtail
COPY --from=tar C:\Windows\System32\netapi32.dll  C:\Windows\System32\netapi32.dll
WORKDIR C:/loki
EXPOSE 3100
ENTRYPOINT ["loki-windows-amd64.exe"]
CMD ["--config.file=conf/loki-local-config.yaml"]