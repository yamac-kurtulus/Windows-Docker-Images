#SPECIFY THE CONTAINER IMAGE
FROM mcr.microsoft.com/windows/servercore:ltsc2019

ENV GIT_VERSION 2.25.0
ENV GIT_PATCH_VERSION 1

RUN powershell -Command $ErrorActionPreference = 'Stop' ; \
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 ; \
    Invoke-WebRequest $('https://github.com/git-for-windows/git/releases/download/v{0}.windows.{1}/MinGit-{0}-busybox-64-bit.zip' -f $env:GIT_VERSION, $env:GIT_PATCH_VERSION) -OutFile 'mingit.zip' -UseBasicParsing ; \
    Expand-Archive mingit.zip -DestinationPath c:\mingit ; \
    Remove-Item mingit.zip -Force ; \
    setx /M PATH $('c:\mingit\cmd;{0}' -f $env:PATH)

#INSTALLING IIS
RUN Powershell.exe -Command Install-WindowsFeature Web-Server
RUN Powershell.exe -Command Invoke-WebRequest -UseBasicParsing -Uri "https://dotnetbinaries.blob.core.windows.net/servicemonitor/2.0.1.6/ServiceMonitor.exe" -OutFile "C:\ServiceMonitor.exe"

#Install jenkins
RUN Powershell.exe -Command Invoke-WebRequest -UseBasicParsing -Uri  http://mirrors.jenkins-ci.org/windows-stable/latest -OutFile "C:/jenkins.zip"
RUN Powershell.exe -Command Expand-Archive C:/jenkins.zip C:/Jenkins

#INSTALLING JENKINS
RUN ["msiexec.exe", "/i", "C:\\jenkins\\jenkins.msi", "/qn"]
 
#REMOVING SETUP FILES FROM CONTAINER
RUN Powershell.exe -Command remove-item c:/jenkins –Recurse

ENTRYPOINT ["C:\\ServiceMonitor.exe", "w3svc"]