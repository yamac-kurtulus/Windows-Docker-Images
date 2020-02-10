# escape=`
from mcr.microsoft.com/powershell:nanoserver-1809
SHELL ["powershell", "-command"]
WORKDIR c:/
COPY ./grafana ./grafana
WORKDIR C:/grafana
EXPOSE 3000
ENTRYPOINT ["./bin/grafana-server.exe"]