# escape=`
FROM mcr.microsoft.com/windows/servercore/iis:latest
SHELL ["powershell", "-command"]
# Use chocolatey to install URL Rewrite module
RUN iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1')); `
    choco feature disable --name showDownloadProgress
RUN choco install urlrewrite -y