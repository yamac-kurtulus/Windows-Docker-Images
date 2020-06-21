# escape=`
ARG windowsVersion=1809
FROM mcr.microsoft.com/windows/servercore:$windowsVersion AS tar
ARG lokiVersion=1.5.0
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]
WORKDIR C:/
RUN iwr https://github.com/grafana/loki/releases/download/v${Env:lokiVersion}/loki-canary-windows-amd64.exe.zip -o ./canary.zip
RUN Expand-archive canary.zip ./canary

FROM mcr.microsoft.com/windows/nanoserver:$windowsVersion
WORKDIR c:/
COPY --from=tar C:/canary/ ./canary
COPY --from=tar C:\Windows\System32\netapi32.dll  C:\Windows\System32\netapi32.dll
WORKDIR C:/canary
EXPOSE 3100
ENTRYPOINT ["loki-canary-windows-amd64.exe"]