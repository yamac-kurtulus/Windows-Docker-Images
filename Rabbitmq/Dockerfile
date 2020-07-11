# escape=`
FROM mcr.microsoft.com/windows/servercore:ltsc2019

USER ContainerAdministrator  
# ERLANG_HOME: erlang will install to this location and rabbitmq will use 
# RABBITMQ_VERSION: rabbitmq version used in download url and to rename folder extracted from zip file
# ERLANG_VERSION: erlang version used in download url
# RABBITMQ_CONFIG_FILE: tell rabbitmq where to find our custom config file. Should be without the extension
ENV RABBITMQ_VERSION="3.8.2" 
ENV	ERLANG_VERSION="22.2"
ENV ERLANG_HOME="C:\erlang"
ENV RABBITMQ_CONFIG_FILE="C:\rabbitmq\conf\rabbitmq"
ENV RABBITMQ_BASE="C:\rabbitmq\base"
	
LABEL Description="RabbitMQ" Vendor="Pivotal" Version=$RABBITMQ_VERSION ErlangVersion=$ERLANG_VERSION
# setup powershell options for RUN commands
SHELL ["powershell.exe", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

# download and install erlang using silent install option, and remove installer when done
# download and extract rabbitmq, and remove zip file when done
# remove version from rabbitmq folder name
RUN Invoke-WebRequest -usebasicparsing -Uri "http://erlang.org/download/otp_win64_$env:ERLANG_VERSION.exe" -OutFile "C:\erlang_install.exe" ;
RUN Start-Process -Wait -FilePath "c:\erlang_install.exe" -ArgumentList /S, /D=$env:ERLANG_HOME ; `
        Remove-Item -Force -Path "C:\erlang_install.exe" ;
	
RUN Invoke-WebRequest -usebasicparsing -Uri "https://github.com/rabbitmq/rabbitmq-server/releases/download/v$env:RABBITMQ_VERSION/rabbitmq-server-$env:RABBITMQ_VERSION.exe" -OutFile "c:\rabbitmq.exe" ;
# Copy config and sample before creating the service
COPY ./rabbitmq.conf.sample ${RABBITMQ_CONFIG_FILE}.conf.sample
RUN "$proc = Start-Process 'c:\rabbitmq.exe' '/S' -Wait:$false -Passthru;"`
    Wait-Process -Id "$proc.Id"
RUN Remove-Item -Force -Path "c:\rabbitmq.exe" ;
# rabbit did not add binaries to path, so fixed it
RUN "setx /M PATH $($Env:PATH+';C:\Program Files\RabbitMQ Server\rabbitmq_server-3.8.2/sbin');"
#Stop service
RUN rabbitmq-service remove
EXPOSE 4369 5671 5672 25672 15672
# enable managment plugin
RUN rabbitmq-plugins enable --offline rabbitmq_management
# run server when container starts - container will shutdown when this process ends
ENTRYPOINT rabbitmq-server.bat 