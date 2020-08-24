ARG VERSION="2020.1.4292"
ARG WINDOWS_VERSION=1809
FROM mcr.microsoft.com/windows/servercore:${WINDOWS_VERSION} as install
ARG VERSION
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]
WORKDIR C:/seq
RUN iwr https://datalust.co/download/begin?version=${Env:VERSION} -o seq.msi
RUN Start-Process -FilePath msiexec.exe -Wait -ArgumentList @('/package', 'seq.msi', '/quiet', '/log', 'seq.txt')
COPY ["./run.ps1", "."]
EXPOSE 5341
ENTRYPOINT ["powershell.exe", "./run.ps1"]