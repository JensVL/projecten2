Write-Host("Installing and configuring Routing...")
Install-RemoteAccess -VpnType Vpn

netsh -f C:\vagrant\povision\routing-config.txt
net start remoteaccess
netsh -f C:\vagrant\povision\routing-config.txt
