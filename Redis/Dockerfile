#escape=`
FROM mcr.microsoft.com/windows/servercore:1809 as download
ARG redisVersion="3.2.100"
SHELL ["powershell", "-Command"]
WORKDIR C:/Redis
RUN Invoke-WebRequest -uri https://github.com/MSOpenTech/redis/releases/download/win-${env:redisVersion}/Redis-x64-${env:redisVersion}.zip -OutFile Redis.zip;
RUN Expand-Archive Redis.zip -dest . ;
RUN Remove-Item Redis.zip -Force
RUN setx PATH '%PATH%;C:/Redis/'

#Setup redis for unprotected mode to allow connections from outside
RUN Get-Content redis.windows.conf | Where { $_ -notmatch 'bind 127.0.0.1' } | Set-Content redis.openport.conf ; `
	Get-Content redis.openport.conf | Where { $_ -notmatch 'protected-mode yes' } | Set-Content redis.unprotected.conf ; `
	Add-Content redis.unprotected.conf 'protected-mode no' ; `
	Add-Content redis.unprotected.conf 'bind 0.0.0.0' ; `
	Get-Content redis.unprotected.conf

FROM mcr.microsoft.com/windows/nanoserver:1809 as final
WORKDIR C:/Redis
COPY --from=download C:/Redis .
EXPOSE 6379

# Define our command to be run when launching the container
ENTRYPOINT .\redis-server.exe .\redis.unprotected.conf