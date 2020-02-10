$lockfile = "G:\data\lock"
if (Test-Path $lockfile) { Remove-Item $lockfile }
C:\\nexus\\nexus_root\\bin\\nexus.exe /run
