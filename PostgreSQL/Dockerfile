####
#### argument for Windows version must be set early
####
ARG WIN_VER=1809

####
#### Download and prepare PostgreSQL for Windows
####
FROM mcr.microsoft.com/windows/servercore:${WIN_VER} as prepare

### Set the variables for EnterpriseDB
ARG EDB_VER=pg12
ENV EDB_VER $EDB_VER
ENV EDB_REPO https://sbp.enterprisedb.com/getfile.jsp?fileid=12540

##### Use PowerShell for the installation
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

##### Required to make deletions in C
USER ContainerAdministrator

### Download EnterpriseDB and remove cruft
RUN $URL1=$Env:EDB_REPO ; \
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 ; \
    Invoke-WebRequest -Uri $URL1 -OutFile 'C:\\EnterpriseDB.zip' ; \
    Expand-Archive 'C:\\EnterpriseDB.zip' -DestinationPath 'C:\\' ; \
    Remove-Item -Path 'C:\\EnterpriseDB.zip' ; \
    Remove-Item -Recurse -Force –Path 'C:\\pgsql\\doc' ; \
    Remove-Item -Recurse -Force –Path 'C:\\pgsql\\include' ; \
    Remove-Item -Recurse -Force –Path 'C:\\pgsql\\pgAdmin*' ; \
    Remove-Item -Recurse -Force –Path 'C:\\pgsql\\StackBuilder'

### Make the sample config easier to munge (and "correct by default")
RUN $SAMPLE_FILE = 'C:\\pgsql\\share\\postgresql.conf.sample' ; \
    $SAMPLE_CONF = Get-Content $SAMPLE_FILE ; \
    $SAMPLE_CONF = $SAMPLE_CONF -Replace '#listen_addresses = ''localhost''','listen_addresses = ''*''' ; \
    $SAMPLE_CONF | Set-Content $SAMPLE_FILE

### Install correct Visual C++ Redistributable Package
RUN if (($env:EDB_VER -like '9.*') -or ($env:EDB_VER -like '10.*')) { \
        Write-Host('Visual C++ 2013 Redistributable Package') ; \
        $URL2 = 'https://download.microsoft.com/download/2/E/6/2E61CFA4-993B-4DD4-91DA-3737CD5CD6E3/vcredist_x64.exe' ; \
    } else { \
        Write-Host('Visual C++ 2017 Redistributable Package') ; \
        $URL2 = 'https://download.visualstudio.microsoft.com/download/pr/11100230/15ccb3f02745c7b206ad10373cbca89b/VC_redist.x64.exe' ; \
    } ; \
    Invoke-WebRequest -Uri $URL2 -OutFile 'C:\\vcredist.exe' ; \
    Start-Process 'C:\\vcredist.exe' -Wait \
        -ArgumentList @( \
            '/install', \
            '/passive', \
            '/norestart' \
        )

# Determine new files installed by VC Redist
# RUN Get-ChildItem -Path 'C:\\Windows\\System32' | Sort-Object -Property LastWriteTime | Select Name,LastWriteTime -First 25

# Copy relevant DLLs to PostgreSQL
RUN if (Test-Path 'C:\\windows\\system32\\msvcp120.dll') { \
        Write-Host('Visual C++ 2013 Redistributable Package') ; \
        Copy-Item 'C:\\windows\\system32\\msvcp120.dll' -Destination 'C:\\pgsql\\bin\\msvcp120.dll' ; \
        Copy-Item 'C:\\windows\\system32\\msvcr120.dll' -Destination 'C:\\pgsql\\bin\\msvcr120.dll' ; \
    } else { \
        Write-Host('Visual C++ 2017 Redistributable Package') ; \
        Copy-Item 'C:\\windows\\system32\\vcruntime140.dll' -Destination 'C:\\pgsql\\bin\\vcruntime140.dll' ; \
    }

####
#### PostgreSQL on Windows Nano Server
####
FROM mcr.microsoft.com/windows/nanoserver:${WIN_VER}

#### Copy over PostgreSQL
COPY --from=prepare /pgsql /pgsql

#### In order to set system PATH, ContainerAdministrator must be used
USER ContainerAdministrator
RUN setx /M PATH "C:\\pgsql\\bin;%PATH%"
USER ContainerUser
COPY ./docker-entrypoint.cmd .
ENV PGDATA "C:\\pgsql\\data"
ENTRYPOINT docker-entrypoint.cmd

EXPOSE 5432
CMD postgres