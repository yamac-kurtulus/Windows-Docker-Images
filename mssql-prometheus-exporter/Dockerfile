ARG WINDOWS_VERSION='1809'
ARG NODE_VERSION='12'
FROM mcr.microsoft.com/windows/servercore:$WINDOWS_VERSION AS tar
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]
WORKDIR /app
RUN iwr https://github.com/awaragi/prometheus-mssql-exporter/archive/master.zip -o mssql-exporter.zip
RUN Expand-Archive mssql-exporter.zip ./
RUN dir
RUN rename-item prometheus-mssql-exporter-master mssql-exporter
RUN ls mssql-exporter

FROM stefanscherer/node-windows:$NODE_VERSION
WORKDIR /app
COPY --from=tar C:/app/mssql-exporter ./
RUN dir
RUN npm install --production
EXPOSE 4000
ENTRYPOINT ["node", "index.js"]