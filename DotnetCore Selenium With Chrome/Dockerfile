#escape=`
FROM mcr.microsoft.com/windows/servercore:1809 AS sdk
ARG dotnetCoreVersion=2.1
ARG chromeVersion=83
SHELL ["powershell", "-command", "$ErrorActionPreference = 'Stop';"]
USER ContainerAdministrator
WORKDIR /setup
#Start installing required apps
RUN Invoke-WebRequest -OutFile dotnet-install.ps1 'https://dot.net/v1/dotnet-install.ps1';`
    $installDir = $env:ProgramFiles + '/dotnet/sdk/'+${env:dotnetCoreVersion};`
    & .\dotnet-install.ps1 -Channel ${env:dotnetCoreVersion} -InstallDir $installDir;`
    Remove-Item -Force dotnet-install.ps1;`
    setx /M PATH $env:PATH+';C:/Program Files/dotnet/sdk/'+${env:dotnetCoreVersion};
ENV ASPNETCORE_URLS=http://+:80 
ENV DOTNET_RUNNING_IN_CONTAINER=true 
ENV DOTNET_USE_POLLING_FILE_WATCHER=true 
ENV NUGET_XMLDOC_MODE=skip
RUN dotnet help
ENV chocolateyUseWindowsCompression = 'true'
RUN Add-WindowsFeature Web-WebSockets;` 
    Set-ExecutionPolicy Bypass -Scope Process -Force;
RUN iex(iwr -useb https://chocolatey.org/install.ps1)
#We need these totally standard fonts manually added for some reason....
COPY Fonts /Fonts
RUN C:\Fonts\Add-Font.ps1 C:\Fonts\Fonts
RUN choco install googlechrome  -fy --verbose
RUN $chromeVersion3Part = [RegEx]::Match((Get-Item 'C:/Program Files/Google/Chrome/Application/chrome.exe').VersionInfo.FileVersion, '[0-9]{1,8}\.[0-9]{1,8}\.[0-9]{1,8}').Value;`
    $chromeDriverVersionUrl = 'https://chromedriver.storage.googleapis.com/LATEST_RELEASE_' + $chromeVersion3Part; `
    $chromeDriverVersion=(Invoke-WebRequest -UseBasicParsing $chromeDriverVersionUrl).Content;`
    New-Item -Type Directory 'C:/Selenium';`
    $chromeDriverDownloadUrl='https://chromedriver.storage.googleapis.com/' + $chromeDriverVersion + '/chromedriver_win32.zip'; `
    Invoke-WebRequest $chromeDriverDownloadUrl -OutFile chromedriver.zip;`
    Expand-Archive -Path chromedriver.zip -DestinationPath 'C:/Selenium';`   
    Remove-Item chromedriver.zip;



